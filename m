Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313032AbSDGK1Z>; Sun, 7 Apr 2002 06:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313034AbSDGK1Y>; Sun, 7 Apr 2002 06:27:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19719 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313032AbSDGK1Y>; Sun, 7 Apr 2002 06:27:24 -0400
Date: Sun, 7 Apr 2002 11:27:16 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.8-pre2
Message-ID: <20020407112716.A30048@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com> <Pine.GSO.4.21.0204071215220.2567-100000@lisianthus.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 12:17:28PM +0200, Geert Uytterhoeven wrote:
> Please either add resource management code to anakinfb and clps711xfb,
> or apply the patch below.

They're not ISA nor PCI - in fact, they're specific system-on-a-chip
framebuffers.  I therefore don't see the point of your patch.

(Oh, and a bugbear - people go running around adding checks for the
return value of request_region and friends on embedded devices where
there can't be the possibility of a clash waste memory needlessly.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

