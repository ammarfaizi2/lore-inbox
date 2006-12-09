Return-Path: <linux-kernel-owner+w=401wt.eu-S1161008AbWLIPAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWLIPAU (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 10:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161051AbWLIPAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 10:00:20 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:54613 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161008AbWLIPAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 10:00:18 -0500
Date: Sat, 9 Dec 2006 15:58:01 +0100 (MET)
From: Stefan Rompf <stefan@loplof.de>
To: Thomas Graf <tgraf@suug.ch>
Subject: Re: [NETLINK]: Schedule removal of old macros exported to userspace
User-Agent: KMail/1.9.1
Cc: David Miller <davem@davemloft.net>, drow@false.org, dwmw2@infradead.org,
       joseph@codesourcery.com, netdev@vger.kernel.org,
       libc-alpha@sourceware.org, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20061208.134752.131916271.davem@davemloft.net>
 <200612091249.39302.stefan@loplof.de>
 <20061209125533.GO8693@postel.suug.ch>
In-Reply-To: <20061209125533.GO8693@postel.suug.ch>
MIME-Version: 1.0
Content-Type: text/plain;  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612091559.05232.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 9. Dezember 2006 13:55 schrieb Thomas Graf:

> Please calm down a bit. I didn't claim that glibc should be linking to
> libnl. glibc is obviously a special case which can simply copy the existing
> macros into some internal compat header just like any other application
> that doesn't wish to use any of the libraries available.

But when even glibc needs internal compat headers to compile with the second 
kernel version that provides userspace headers, what is the long-term - even 
mid-term - perspective of make headers_install then?

Stefan
