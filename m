Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbUBWUc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbUBWUc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:32:59 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:21499 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262038AbUBWUbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:31:08 -0500
Subject: Re: 2.6.2 - System clock runs too fast
From: john stultz <johnstul@us.ibm.com>
To: Markus Hofmann <markus@gofurther.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200402231413.27757.markus@gofurther.de>
References: <200402101332.26552.markus@gofurther.de>
	 <200402111007.50549.markus@gofurther.de>
	 <1076524588.795.28.camel@cog.beaverton.ibm.com>
	 <200402231413.27757.markus@gofurther.de>
Content-Type: text/plain
Message-Id: <1077568263.19860.85.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 23 Feb 2004 12:31:03 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-23 at 05:13, Markus Hofmann wrote:
> After a recompiling kernel my system clock runs now again too slow. Your patch 
> helps with a fast running clock but not with a slow clock. Do you have an 
> idea what to do now?!?

Things to check: 
o Is DMA enabled for the disks on your system 
	run "/sbin/hdparm /dev/hdX" to see
o Does the problem show up depending on the laptop's power state?
	(ie: does plugging it in or unplugging it change the issue)
o Does disabling cpu freq change in the BIOS affect anything?

thanks
-john

