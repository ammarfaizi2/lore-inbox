Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319073AbSHPVTs>; Fri, 16 Aug 2002 17:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319117AbSHPVTs>; Fri, 16 Aug 2002 17:19:48 -0400
Received: from www.wotug.org ([194.106.52.201]:1848 "EHLO
	gatemaster.ivimey.org") by vger.kernel.org with ESMTP
	id <S319073AbSHPVTs>; Fri, 16 Aug 2002 17:19:48 -0400
Date: Fri, 16 Aug 2002 22:21:28 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: henrique <henrique@cyclades.com>
cc: Oliver Xymoron <oxymoron@waste.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Problem with random.c and PPC
In-Reply-To: <200208161751.35895.henrique@cyclades.com>
Message-ID: <Pine.LNX.4.44.0208162219110.1659-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2002, henrique wrote:

>What would you do in my situation. I am dealing with the Motorola MPC860T and 
>my system has no disk (I use a flash), no mouse, no keyboard, no PCI bus. It 
>has just a fast-ethernet, a console port and some serial ports. 
>
>After reading the discussion on the lkml I realize that the only places I can 
>get randomness in my system is in the serial.c (that controls the serial 
>ports) and arch/ppc/8xx_io/fec.c (fast eth driver) interrupts.

Is there another way -- add a 'noise' device by connecting a PIO pin or 
similar to suitable hardware? It shouldn't bee too hard to do as a one-off. 
For example:

 [noise-diode]--[amplifier]--[schmidt-trigger-inverter]---[PIO INT pin]


Ruth

-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

