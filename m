Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSEAKSG>; Wed, 1 May 2002 06:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293337AbSEAKSF>; Wed, 1 May 2002 06:18:05 -0400
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:4748 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S293203AbSEAKSF>; Wed, 1 May 2002 06:18:05 -0400
Date: Wed, 1 May 2002 11:18:04 +0100 (BST)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: alastair@gerber
To: linux-kernel@vger.kernel.org
Subject: kernel BUG in "page_alloc.c" with 2.4.19-pre7-ac2
Message-ID: <Pine.GSO.4.44.0205011113420.1714-100000@gerber>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a small problem report observed with my Athlon system running
2.4.19-pre7-ac2 under RH 7.2.93 (skipjack beta):

Basically, "page_alloc.c" generated a BUG error when unmounting my
filesystems during a reboot. I wasn't able to capture the full output,
but I hope may be useful to report this anyway. If it happens again I'll
try to grab the details....

But this fault seems *not* to be repeatable - I rebooted several times
with no problems, and my filesystems also appear to be fine.

Cheers
Alastair

o o o o o o o o o o o o o o o o o o o o o o o o o o o o
Alastair Stevens           \ \
MRC Biostatistics Unit      \ \___________ 01223 330383
Cambridge UK                 \___ www.mrc-bsu.cam.ac.uk

