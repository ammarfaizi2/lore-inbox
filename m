Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUI0Ex0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUI0Ex0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 00:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbUI0Ex0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 00:53:26 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:35317 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S265900AbUI0ExY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 00:53:24 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4
Date: Mon, 27 Sep 2004 00:53:22 -0400
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>
References: <20040926181021.2e1b3fe4.akpm@osdl.org>
In-Reply-To: <20040926181021.2e1b3fe4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409270053.22911.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.42.203] at Sun, 26 Sep 2004 23:53:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 September 2004 21:10, Andrew Morton wrote:
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-
>rc2/2.6.9-rc2-mm4/
>
>- ppc64 builds are busted due to breakage in bk-pci.patch
>
>- sparc64 builds are busted too.  Also due to pci problems.
>
>- Various updates to various things.  In particular, a kswapd
> artifact which could cause too much swapout was fixed.
>
>- I shall be offline for most of this week.
>

The bootup hangs, from dmesg after reboot to 2.6.9-rc2-mm3:

Checking 'hlt' instruction... OK.
-----
2.6.9-rc2-mm4 hangs here, and never gets to the next line
-----
NET: Registered protocol family 16

So I assume something in the next line hangs it. Sysrq-t has no 
repsonse, must use the hardware reset button.

Ideas?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
