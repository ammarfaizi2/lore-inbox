Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267260AbTCDPSx>; Tue, 4 Mar 2003 10:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268576AbTCDPSw>; Tue, 4 Mar 2003 10:18:52 -0500
Received: from imap.gmx.net ([213.165.64.20]:37972 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267260AbTCDPSw>;
	Tue, 4 Mar 2003 10:18:52 -0500
Message-Id: <5.1.1.6.2.20030304161357.00cf0860@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Tue, 04 Mar 2003 16:33:52 +0100
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
       linux-kernel@vger.kernel.org
From: Mike Galbraith <efault@gmx.de>
Subject: Re: VM / OOM troubles in 2.4.20-ck4 (-aa VM)
In-Reply-To: <Pine.GSO.4.50.0303041249251.5801-100000@quaratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:58 PM 3/4/2003 +0000, Alastair Stevens wrote:
>Hi Guys - I was surprised to discover that the very latest 2.4.20
>kernels running the latest -ck patches still have major VM problems,
>even with the -aa VM.
>
>Our dual Athlon server with 512Mb RAM / 1.2Gb swap, and not particularly
>heavily loaded, lasted 81 days with 2.4.20-ck1 under RH8.0, and then
>succumbed with these errors:
>
>   VM error: killing process wineserver
>    _alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
>
>This time, it only lasted _3 days_ with -ck4 before the same thing
>happened.
>
>I presume this is the OOM killer? Swap is indeed full, but I've no idea
>why, on a machine that's only running a couple of instances of a small
>Windoze app under WINE.

You sure your userland proggies aren't leaking like a sieve?

         -Mike

