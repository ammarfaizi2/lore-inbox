Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315849AbSEGOzv>; Tue, 7 May 2002 10:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315850AbSEGOzu>; Tue, 7 May 2002 10:55:50 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:15050 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S315849AbSEGOzu>; Tue, 7 May 2002 10:55:50 -0400
Date: Tue, 7 May 2002 16:55:26 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 55
Message-ID: <Pine.SOL.4.30.0205071653140.29509-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2002, Roman Zippel wrote:
>
> > BTW.> It should indeed take both in to account as far as I can
> > see.(Despite the fact that I could affort an ATARI I hardly
> > can find one...)
>
> That's not necessary, but I'm only afraid that functionality gets lost,
> which isn't needed on the latest hardware.
>
> bye, Roman

we should fix atari byte-swapped ide in ata_read() like we do in
atapi_read() then ide_fix_driveid() will make rest...
(or I am missing something?)

--
bkz


