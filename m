Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262194AbREZAVx>; Fri, 25 May 2001 20:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262202AbREZAVn>; Fri, 25 May 2001 20:21:43 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:37901 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S262194AbREZAVZ>; Fri, 25 May 2001 20:21:25 -0400
Date: Fri, 25 May 2001 20:21:48 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@vesta.nine.com>
To: <linux-kernel@vger.kernel.org>
Subject: AT keyboard optional on i386?
Message-ID: <Pine.LNX.4.33.0105252003530.32376-100000@vesta.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm trying to run Linux on a broken motherboard that is constantly
producing random noice on the AT keyboard port. I'm going to use a USB
keyboard, but I cannot get Linux to ignore the AT keyboard port.

Is there any way to disable the AT keyboard? I think the best solution
would be to make it optional, just like almost everything in the kernel,
e.g. PS/2 mouse. Some embedded i386 systems could save a few kilobytes of
RAM by disabling the AT keyboard.

It looks like that other architectures (arm and mips) already have an
option CONFIG_PC_KEYB exactly for that. However, it's a dependent variable
- it's set based on the machine type.

Does anybody have a patch for making AT keyboard optional on i386 or
should I make it myself?

-- 
Regards,
Pavel Roskin

