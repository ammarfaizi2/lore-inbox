Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269409AbTCDMrr>; Tue, 4 Mar 2003 07:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269411AbTCDMrr>; Tue, 4 Mar 2003 07:47:47 -0500
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:52870 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S269409AbTCDMrq>; Tue, 4 Mar 2003 07:47:46 -0500
Date: Tue, 4 Mar 2003 12:58:11 +0000 (GMT)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: alastair@quaratino
To: linux-kernel@vger.kernel.org
Subject: VM / OOM troubles in 2.4.20-ck4 (-aa VM)
Message-ID: <Pine.GSO.4.50.0303041249251.5801-100000@quaratino>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys - I was surprised to discover that the very latest 2.4.20
kernels running the latest -ck patches still have major VM problems,
even with the -aa VM.

Our dual Athlon server with 512Mb RAM / 1.2Gb swap, and not particularly
heavily loaded, lasted 81 days with 2.4.20-ck1 under RH8.0, and then
succumbed with these errors:

  VM error: killing process wineserver
   _alloc_pages: 0-order allocation failed (gfp=0x1d2/0)

This time, it only lasted _3 days_ with -ck4 before the same thing
happened.

I presume this is the OOM killer? Swap is indeed full, but I've no idea
why, on a machine that's only running a couple of instances of a small
Windoze app under WINE.

Is there a problem here? Should I just give up and run 2.5? ;-)

Cheers
Alastair                            .-=-.
__________________________________,'     `.
                                           \   www.mrc-bsu.cam.ac.uk
Alastair Stevens, Systems Management Team   \       01223 330383
MRC Biostatistics Unit, Cambridge UK         `=.......................
