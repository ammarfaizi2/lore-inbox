Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUHNSoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUHNSoF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 14:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUHNSoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 14:44:05 -0400
Received: from fmr02.intel.com ([192.55.52.25]:33479 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S264560AbUHNSoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 14:44:01 -0400
Subject: Re: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Marcus Hartig <m.f.h@web.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <566B962EB122634D86E6EE29E83DD808182C3286@hdsmsx403.hd.intel.com>
References: <566B962EB122634D86E6EE29E83DD808182C3286@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1092509038.7765.271.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Aug 2004 14:43:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-14 at 12:40, Marcus Hartig wrote:
> Hello,
> 
> when I compile 2.6.8(.1) with this ACPI patch or without, I get this
> error while compiling:
> 
>   CC      drivers/acpi/dispatcher/dsfield.o
> In file included from drivers/acpi/dispatcher/dsfield.c:49:
> include/acpi/acnamesp.h:450: error: syntax error before '(' token
> include/acpi/acnamesp.h:457: warning: function declaration isn't a
> prototype
> make[3]: *** [drivers/acpi/dispatcher/dsfield.o] Error 1
> make[2]: *** [drivers/acpi/dispatcher] Error 2
> make[1]: *** [drivers/acpi] Error 2
> make: *** [drivers] Error 2
> 
> ?
> 
> gcc version 3.4.1 20040714 (Red Hat 3.4.1-7)
> config: http://www.marcush.de/.config

Hmm, this config builds for me with gcc 3.3,
and neither dsfield.c nor acnamesp.h have changed in months.

is it possible your source tree has been corrupted?

thanks,
-Len


