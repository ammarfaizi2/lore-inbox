Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268900AbRH0U2k>; Mon, 27 Aug 2001 16:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268867AbRH0U2U>; Mon, 27 Aug 2001 16:28:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4879 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268813AbRH0U2R>; Mon, 27 Aug 2001 16:28:17 -0400
Date: Mon, 27 Aug 2001 13:25:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: patch-2.4.10-pre1
Message-ID: <Pine.LNX.4.33.0108271323290.5985-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I'm back from Finland, and there's a 2.4.10-pre1 update on kernel.org.
Changelog appended..

The most noticeable one (under the right loads) is probably the one-liner
by Daniel that avoids some bad behaviour when swapping.

		Linus

-----
pre1:
 - Jeff Hartmann: DRM AGP/alpha cleanups
 - Ben LaHaise: highmem user pagecopy/clear optimization
 - Vojtech Pavlik: VIA IDE driver update
 - Herbert Xu: make cramfs work with HIGHMEM pages
 - David Fennell: awe32 ram size detection improvement
 - Istvan Varadi: umsdos EMD filename bug fix
 - Keith Owens: make min/max work for pointers too
 - Jan Kara: quota initialization fix
 - Brad Hards: Kaweth USB driver update (enable, and fix endianness)
 - Ralf Baechle: MIPS updates
 - David Gibson: airport driver update
 - Rogier Wolff: firestream ATM driver multi-phy support
 - Daniel Phillips: swap read page referenced set - avoid swap thrashing

