Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271215AbRHOO0j>; Wed, 15 Aug 2001 10:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271214AbRHOO03>; Wed, 15 Aug 2001 10:26:29 -0400
Received: from elektroni.ee.tut.fi ([130.230.131.11]:4363 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP
	id <S271200AbRHOO0S>; Wed, 15 Aug 2001 10:26:18 -0400
Date: Wed, 15 Aug 2001 17:26:31 +0300
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.2.20pre series and booting problem
Message-ID: <20010815172631.A17156@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I just tried to compile kernels from the 2.2.20pre series for the first
time. 2.2.20pre3 boots ok but pre5-pre9 do not:


Uncompressing Linux...

Out of memory

  -- System halted


I'm sorry if I this is well-known: I haven't been following the list very
closely lately. Maybe it has something to do with this:

o       Add support for the 2.4 boot extensions to 2.2  (H Peter Anvin) 

I tried with gcc-2.7.2.3 + binutils-2.9.1.0.25 and with egcs-1.1.2 +
binutils-2.11.90.0.19. On a 486 with 48 M RAM and lilo 21.7-5 and on a
Pentium MMX with 64 M RAM and lilo 19.
