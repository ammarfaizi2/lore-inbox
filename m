Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbUBHXWb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 18:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbUBHXWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 18:22:30 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:4754 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S264284AbUBHXW3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 18:22:29 -0500
Subject: Re: [PROBLEM] 2.6.3-rc1: still no suspend/resume on Centrino
	notebook
From: Matthias Hentges <mailinglisten@hentges.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200402081832.i18IWAPg001599@brain.gnuhh.org>
References: <c05slq$e1r$1@sea.gmane.org>
	 <200402081832.i18IWAPg001599@brain.gnuhh.org>
Content-Type: text/plain
Message-Id: <1076282567.6594.3.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 09 Feb 2004 00:22:47 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am So, den 08.02.2004 schrieb Georg C F Greve um 19:32:
>  > The Thinkpad T40 and T41 at least; they suspend & resume properly,
>  > but there are still interrupt-losing problems when resuming, which
>  > is a totally separate issue. I believe they both use the 8255PM
>  > chipset:
> 
>  > 00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O
>  > Controller (rev 03)
> 
> Thanks.
> 
> AFAIK, there are essentially three "Centrino" chipsets
>        Intel 855GM [1]
>        Intel 855PM [2]
>        Intel 855GME [3].
> 
> So 855PM based laptops seem to work, whereas 855GM based laptops
> apparently don't. So it would be logical to assume it is the
> difference between these two that causes the problems.

*cough*

Well my laptop uses the 855PM chipset and it does *not* work. Suspend
works but the machine won't wake up (drives power up but the screen
stays blank and the machine is not pingable.

PS: Yes, my mailer is kinda fscked ATM, sorry
-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian Woody. Geek by Nature, Linux by Choice


