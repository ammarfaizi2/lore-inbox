Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbUDQKpG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 06:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUDQKpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 06:45:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52495 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263782AbUDQKpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 06:45:00 -0400
Date: Sat, 17 Apr 2004 11:44:55 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Jorge Bernal (Koke)" <koke_lkml@amedias.org>
Cc: linux-kernel@vger.kernel.org, Joshua Kwan <joshk@triplehelix.org>
Subject: Re: [2.6.5] Oversized FB logos
Message-ID: <20040417114455.B14786@flint.arm.linux.org.uk>
Mail-Followup-To: "Jorge Bernal (Koke)" <koke_lkml@amedias.org>,
	linux-kernel@vger.kernel.org, Joshua Kwan <joshk@triplehelix.org>
References: <pan.2004.04.17.03.07.22.362894@triplehelix.org> <200404171126.09188.koke_lkml@amedias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200404171126.09188.koke_lkml@amedias.org>; from koke_lkml@amedias.org on Sat, Apr 17, 2004 at 11:26:09AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 11:26:09AM +0200, Jorge Bernal (Koke) wrote:
> what about passing CONSOLE=/dev/tty2 or CONSOLE=/dev/null at boot loader 
> command line?? I saw that once in something like bootsplash or lpp but I'm 
> not sure if this will work well.

Even better - use quiet on the kernel command line.  This sets the
console level to 4, which means only error, critical, alert and
emergency messages will appear on the console.

This means that, should something go wrong, grandma can "bug out"
and phone you, and read the error message to you.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
