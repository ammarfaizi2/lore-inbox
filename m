Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130121AbQLLLAp>; Tue, 12 Dec 2000 06:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130846AbQLLLAf>; Tue, 12 Dec 2000 06:00:35 -0500
Received: from nas1-133.kmp.club-internet.fr ([213.44.17.133]:44280 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S130121AbQLLLAX>;
	Tue, 12 Dec 2000 06:00:23 -0500
Message-Id: <200012121023.LAA05097@microsoft.com>
Subject: Re: 2.2.18pre24 spurious diskchanges
From: Xavier Bestel <xavier.bestel@free.fr>
To: Jonathan Morton <chromatix@penguinpowered.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <l03130303b65ba02ad4e6@[192.168.239.101]>
Content-Type: text/plain
X-Mailer: Evolution 0.6 (Developer Preview)
Date: 12 Dec 2000 09:23:35 -0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >on my ide CDROm I get, roughly each 2 seconds, disk changes although the
> >drive is empty and I don't touch it:
> >
> >Dec 12 08:57:43 localhost kernel: VFS: Disk change detected on device
> >ide0(3,64)
> >Dec 12 08:58:14 localhost last message repeated 16 times
> >Dec 12 08:59:16 localhost last message repeated 31 times
> >Dec 12 09:00:17 localhost last message repeated 30 times
> >Dec 12 09:01:19 localhost last message repeated 31 times
> >Dec 12 09:02:21 localhost last message repeated 31 times
> >etc ...
> 
> It would probably help if you told us what make/model CD-ROM drive, and
> whether you're using any particular driver with it (usually the standard
> ATAPI one).

Dec 11 17:13:38 localhost kernel: hdb: UJDA150, ATAPI CDROM drive 
Dec 11 17:13:38 localhost kernel: ide2: ports already in use, skipping probe 
Dec 11 17:13:38 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 
Dec 11 17:13:38 localhost kernel: hda: IBM-DADA-25400, 5153MB w/460kB Cache, CHS=698/240/63, UDMA 
Dec 11 17:13:38 localhost kernel: hdb: ATAPI 24X CD-ROM drive, 128kB Cache 
Dec 11 17:13:38 localhost kernel: Uniform CD-ROM driver Revision: 3.11 

It's the internal CDROM in a Compaq Armada 1700.

Oops, I just killed magicdev, as told by someone, and this is gone.

Xav
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
