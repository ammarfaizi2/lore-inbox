Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314457AbSEMVnE>; Mon, 13 May 2002 17:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSEMVnD>; Mon, 13 May 2002 17:43:03 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:19856 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S314457AbSEMVnD>; Mon, 13 May 2002 17:43:03 -0400
Date: Mon, 13 May 2002 23:43:14 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Phillip.Watts@nlynx.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Compact Flash bug
In-Reply-To: <86256BB8.0077508C.00@nlynx.com>
Message-ID: <Pine.GSO.3.96.1020513233800.26083k-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

