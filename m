Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbVA1U7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVA1U7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbVA1U5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:57:08 -0500
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:8130 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S262787AbVA1UuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:50:04 -0500
Message-ID: <41FAA51F.9050304@am.sony.com>
Date: Fri, 28 Jan 2005 12:48:31 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Zanussi <zanussi@us.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, karim@opersys.com
Subject: Re: [PATCH] relayfs redux, part 2
References: <16890.38062.477373.644205@tut.ibm.com>
In-Reply-To: <16890.38062.477373.644205@tut.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Zanussi wrote:
> diff -urpN -X dontdiff linux-2.6.10/fs/Kconfig linux-2.6.10-cur/fs/Kconfig
...

> +	  This file system is also available as a module ( = code which can be
> +	  inserted in and removed from the running kernel whenever you want).
> +	  The module is called relayfs.  If you want to compile it as a
> +	  module, say M here and read <file:Documentation/modules.txt>.
...

This is a real nit, but personally I'd remove the stuff in parens above.
 It's not relayfs' job to educate users about what a module is.

I'll try to give some more substantive feedback next week.

Tim
