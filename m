Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314475AbSEMWB5>; Mon, 13 May 2002 18:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314483AbSEMWB5>; Mon, 13 May 2002 18:01:57 -0400
Received: from ils.nlynx.com ([204.251.47.66]:26387 "HELO nlynx.com")
	by vger.kernel.org with SMTP id <S314475AbSEMWB4>;
	Mon, 13 May 2002 18:01:56 -0400
X-Lotus-FromDomain: NLYNX
From: Phillip.Watts@nlynx.com
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-kernel@vger.kernel.org
Message-ID: <86256BB8.0079455E.00@nlynx.com>
Date: Mon, 13 May 2002 17:04:34 -0500
Subject: Re: Compact Flash bug
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I was referring to   drive_is_flashcard()  in ide.c
I believe SunDisk SDCFB  s/b SanDisk.





"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> on 05/13/2002 04:43:14 PM

To:   Phillip Watts/austin/Nlynx@Nlynx
cc:   linux-kernel@vger.kernel.org

Subject:  Re: Compact Flash bug



On Mon, 13 May 2002 Phillip.Watts@nlynx.com wrote:

> in 2.4.18  the routine which is determining if Compact Flash
> has  Sandisk  spelled SunDisk.

 That looks correct.  The company seems to have problems with identity:

# hdparm -i /dev/hda

/dev/hda:

 Model=SunDisk SD35B-64, FwRev=vcb 1.45, SerialNo=MT311213748
 Config={ HardSect NotMFM Fixed DTR>10Mbs nonMagnetic }
 RawCHS=490/8/32, TrkSize=0, SectSize=576, ECCbytes=4
 BuffType=DualPort, BuffSize=1kB, MaxMultSect=1, MultSect=1
 CurCHS=490/8/32, CurSects=125440, LBA=yes, LBAsects=125440
 IORDY=no
 PIO modes: pio0 pio1
 DMA modes:
 AdvancedPM=no

(that's a traditional 3.5" ATA flash device).

--
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +





