Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267370AbTBLPn0>; Wed, 12 Feb 2003 10:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267361AbTBLPn0>; Wed, 12 Feb 2003 10:43:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9736 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267370AbTBLPnY>; Wed, 12 Feb 2003 10:43:24 -0500
Date: Wed, 12 Feb 2003 15:53:10 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Adam Belay <ambx1@neo.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.20][2.5.60] /proc/interrupts comparsion - two irqs for i8042?
Message-ID: <20030212155310.C852@flint.arm.linux.org.uk>
Mail-Followup-To: Shawn Starr <spstarr@sh0n.net>,
	Adam Belay <ambx1@neo.rr.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302121035420.147-100000@coredump.sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302121035420.147-100000@coredump.sh0n.net>; from spstarr@sh0n.net on Wed, Feb 12, 2003 at 10:36:16AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 10:36:16AM -0500, Shawn Starr wrote:
>   1:         15          XT-PIC  i8042
>  12:         60          XT-PIC  i8042
> 
> Interesting, why are we using two interrupts for the i8042 (keyboard).

i8042 != keyboard.

i8042 == keyboard controller + (optionally) PS/2 mouse controller.

IRQ1 = keyboard IRQ
IRQ12 = PS/2 mouse IRQ

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

