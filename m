Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137090AbREKJym>; Fri, 11 May 2001 05:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137092AbREKJyd>; Fri, 11 May 2001 05:54:33 -0400
Received: from ghostwheel.underley.eu.org ([217.97.235.9]:1293 "EHLO
	bobas.nowytarg.top.pl") by vger.kernel.org with ESMTP
	id <S137090AbREKJyO>; Fri, 11 May 2001 05:54:14 -0400
From: Daniel Podlejski <underley@witch.underley.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <20010511103233.A2252@gruyere.muc.suse.de>
In-Reply-To: <alan@lxorguk.ukuu.org.uk> <20010511103233.A2252@gruyere.muc.suse.de>
X-PGP-Fingerprint: 4D 72 53 F8 FE 8C 53 B9  66 AD F6 EA C9 17 CD 82
X-Homepage: http://www.underley.eu.org/
Message-Id: <20010511093456Z5269733-750+13@witch.underley.eu.org>
Date: Fri, 11 May 2001 11:34:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On linux-kernel, ak@suse.de (Andi Kleen) wrote:
[...]
:  If /arc is not on a different hd it is probably a good idea to make 
:  sure test.tar.gz is small enough to fit into memory and has been read
:  at least once to be cache hot (that was the case with my test tar). 
:  Otherwise you're testing how fast the hd can seek between the two places 
:  and how far XFS and ext2 are away, and both are not very interesting.

hda: IBM-DTLA-307030, ATA DISK drive
hdc: ST34312A, ATA DISK drive
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(66)
hdc: 8420832 sectors (4311 MB) w/512KiB Cache, CHS=524/255/63, UDMA(33)

/arc is logical volume on hda, /mobile is partition on hdc (mobile -
becouse it's on disk in mobile rack ;)), so test is good.

Soon I will test this on SCSI disk.

-- 
Daniel Podlejski <underley@underley.eu.org>
   ... A blind man kneels on broken class
   Building the bars of his own case ...
