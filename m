Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbUCESka (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 13:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbUCESk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 13:40:29 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:36880 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262673AbUCESkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 13:40:22 -0500
Message-ID: <4048CC7F.4070009@techsource.com>
Date: Fri, 05 Mar 2004 13:52:47 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 'simulator' and wave-form analysis tool?
References: <4048B36E.8000605@techsource.com> <Pine.LNX.4.53.0403051253220.32349@chaos>
In-Reply-To: <Pine.LNX.4.53.0403051253220.32349@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard B. Johnson wrote:

> 
> 
> If you are making hardware that goes between the CPU and the
> rest of the world, then you can keep track of anything that's
> going on with some hardware-software combination, external
> to the chip you are analyzing. These things exist and they
> are called emulators, even though most don't emulate anything,
> they use the real chip, but provide the physical and logical
> connections to the user. However, in the case of an already-made
> machine, you are limited in what you can do on the machine
> with software. For instance, to trap every memory access, you
> would need a trap-handler and set all the memory to trap
> on an access. This would a bit hard to do within the kernel
> because all the code on that page would trap as instructions
> were fetched. So, some mere "hook" won't do it, you need
> a kernel that executes a kernel and I think one for Linux
> already exists. So, before you get too involved, you might
> want to check that out.


I must have been unclear.  I was not suggesting adding hardware.  I was 
suggesting that we could run Linux under Bochs, which is a software x86 
emulator.  Being what it is, hooks can be added to track "cpu activity" 
is it occurs within the emulator.  This is all a simulation.  The key 
idea I was suggesting was to log processor activity (of the emulator) 
and develop a viewer program which would help people visualize the activity.

Bochs already has hooks.  I could write a logger and a viewer.

