Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbUCOWWe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUCOWWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:22:33 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:965 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262788AbUCOWUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:20:23 -0500
Date: Mon, 15 Mar 2004 17:20:24 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Petr Konecny <pekon@ams.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: watchdog on A7M266-D motherboard
In-Reply-To: <tlcad2iqkgi.fsf@cg.ams.sunysb.edu>
Message-ID: <Pine.LNX.4.58.0403151121420.28447@montezuma.fsmlabs.com>
References: <tlcad2iqkgi.fsf@cg.ams.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2004, Petr Konecny wrote:

> Hi,
>
> I am trying to use watchdog to reboot my computer when it freezes. I was
> wondering if amd7xx_tco is supposed to work in Asus A7M266-D
> motherboard. It seems to load fine and GETTIMEOUT return values
> decrement in one second intervals. However when the timer reaches 0
> nothing happens, it just rolls over to 37 and keeps going. Even a simple
> program that opens /dev/watchdog and sleeps forever, does not reboot the
> computer.
>
> I am currently running 2.6.4-mm2, but can test suggested
> versions/patches.  Any hints ?

I went through quite a number of boards and i had trouble ever getting the
thing to reboot itself. I've just about given up since i don't have direct
access to hardware so i'll probably submit a patch to back out the driver.
I'm willing to spend some time over the week trying one last time with you
before scrapping it though.

Thanks,
	Zwane

