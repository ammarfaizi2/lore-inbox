Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318929AbSG1ILY>; Sun, 28 Jul 2002 04:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318931AbSG1ILY>; Sun, 28 Jul 2002 04:11:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39690 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318929AbSG1ILX>; Sun, 28 Jul 2002 04:11:23 -0400
Date: Sun, 28 Jul 2002 09:14:40 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Report Status for 2.5.29
Message-ID: <20020728091440.A12389@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0207272154080.5213-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207272154080.5213-100000@dad.molina>; from tmolina@cox.net on Sat, Jul 27, 2002 at 10:03:23PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 10:03:23PM -0500, Thomas Molina wrote:
>    Oops w/PCMCIA modem & 8250_cs       open         2.5.28

Actually closed; the "update" patch I sent to lkml fixes it, and that's
also in 2.5.29.

As far as 2.5.29 goes, there is one outstanding serial problem - a
missing include of <asm/io.h> into 8250_pci.c (oddly my builds don't
find it.)  Oh, and 2.5.29 just has other problems elsewhere which
them cause the serial driver (and I'd imagine other subsystems) to
oops.

If someone knows of other serial problems, bring 'em on down. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

