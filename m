Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSGMTvg>; Sat, 13 Jul 2002 15:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSGMTvf>; Sat, 13 Jul 2002 15:51:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34318 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315388AbSGMTvf>; Sat, 13 Jul 2002 15:51:35 -0400
Date: Sat, 13 Jul 2002 20:54:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Peter Osterlund <petero2@telia.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-rc1-ac3
Message-ID: <20020713205422.E25995@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0207131435570.3808-100000@linux-box.realnet.co.sz> <m2n0svr42e.fsf@best.localdomain> <1026584861.13886.27.camel@irongate.swansea.linux.org.uk> <m265zj9zxn.fsf@best.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m265zj9zxn.fsf@best.localdomain>; from petero2@telia.com on Sat, Jul 13, 2002 at 09:43:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2002 at 09:43:16PM +0200, Peter Osterlund wrote:
> So, is any of the above true for x86 processors? Or are there other
> reasons to expect frequency scaling to increase battery run-time.

You're right if your CPU usage is 100% - lowering the CPU clock rate
means you take longer to complete the task, and with the static
element of the CPU power consumption, you'd probably end up using
more energy to perform the same task in a longer time.

However, if, like most desktops, your CPU is sitting around 90% idle,
if you lower the CPU clock rate, the idle time will drop.  Since the
power drops, the rate at which the CPU uses energy also drops.
However, overall your task completes in the same amount of time.

For instance, you are reading a file with "less".  Is running the CPU
at full speed going to make you read the file any faster than if it's
running at slow speed?  How about the amount of energy that the CPU
consumes for this task?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

