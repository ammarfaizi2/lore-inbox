Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbUJaRQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUJaRQD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 12:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUJaRQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 12:16:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43276 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261410AbUJaRP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 12:15:57 -0500
Date: Sun, 31 Oct 2004 17:15:44 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 478] M68k SERIAL_PORT_DFNS only if CONFIG_ISA
Message-ID: <20041031171544.A17342@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <200410311003.i9VA3ZVQ009578@anakin.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200410311003.i9VA3ZVQ009578@anakin.of.borg>; from geert@linux-m68k.org on Sun, Oct 31, 2004 at 11:03:35AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 11:03:35AM +0100, Geert Uytterhoeven wrote:
> M68k serial: Only define SERIAL_PORT_DFNS when CONFIG_ISA is defined. Otherwise
> the first 4 slots in the 8250 driver are unavailable on non-ISA machines.
> (from Kars de Jong)

I won't be applying this patch - you may wish to consider doing this an
alternative way once the contents of my BK tree becomes public.

include/asm-*/serial.h is almost dead!  Long live serial.h!

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
