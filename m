Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbUCBOQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 09:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbUCBOQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 09:16:35 -0500
Received: from tuxhome.net ([217.160.179.19]:23433 "EHLO tuxhome.net")
	by vger.kernel.org with ESMTP id S261640AbUCBOQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 09:16:34 -0500
From: Markus Hofmann <markus@gofurther.de>
Organization: gofurther.de
To: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.2 - System clock runs too fast
Date: Tue, 2 Mar 2004 15:15:25 +0100
User-Agent: KMail/1.6.1
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200402101332.26552.markus@gofurther.de> <200402231413.27757.markus@gofurther.de> <1077568263.19860.85.camel@cog.beaverton.ibm.com>
In-Reply-To: <1077568263.19860.85.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403021515.25751.markus@gofurther.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello John

Now I've had time to check and test the things you told me.

- DMA was enabled for the disk.
- cpu freq was disabled in the BIOS.
- and I think it depends on the laptop's power state. once the clock runs 
normal with power supply and ac. But now I can't relicate this.

regards
Markus

Am Montag, 23. Februar 2004 21:31 schrieb john stultz:
> On Mon, 2004-02-23 at 05:13, Markus Hofmann wrote:
> > After a recompiling kernel my system clock runs now again too slow. Your
> > patch helps with a fast running clock but not with a slow clock. Do you
> > have an idea what to do now?!?
>
> Things to check:
> o Is DMA enabled for the disks on your system
> 	run "/sbin/hdparm /dev/hdX" to see
> o Does the problem show up depending on the laptop's power state?
> 	(ie: does plugging it in or unplugging it change the issue)
> o Does disabling cpu freq change in the BIOS affect anything?
>
> thanks
> -john
