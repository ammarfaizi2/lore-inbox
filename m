Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292329AbSBBRg0>; Sat, 2 Feb 2002 12:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292330AbSBBRgQ>; Sat, 2 Feb 2002 12:36:16 -0500
Received: from pubnix.org ([204.80.221.10]:17107 "EHLO pubnix.org")
	by vger.kernel.org with ESMTP id <S292329AbSBBRgJ>;
	Sat, 2 Feb 2002 12:36:09 -0500
Date: Sat, 2 Feb 2002 12:33:03 -0500 (EST)
From: syzygy <syzygy@pubnix.org>
To: linux-kernel@vger.kernel.org
Subject: SCSI + IDE = HANG
Message-ID: <Pine.GSO.4.21.0202021219250.13444-100000@pubnix.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had a few random hangs with my machine since I added a maxtor 27
gig IDE drive to it.  I kept trying different combinations of bus
positions etc.  I figured it was flacky hardware or something.  I added
the drive in the early 2.4 series.  Recently I became slightly suspicious
of my Adaptec 2940U2W after reading all of the problems it had in the
early 2.4.  So I upgraded the bios and got kernel 2.4.17.  Though the
problem seems diminished it is certainly not gone...

Now for the kicker...  I found a 99% guarenteed way to hard lock my
box.  I tried ripping two cds at a time.  One on the ide bus and one on
the scsi.  Just a note the data is being stored to the maxtor 27 gig
mentioned above.  The reason I point to the IDE + SCSI combo is that I can
do two scsi cdroms ripping to the maxtor and it works much more
reliably.  I am under the impression that IDE CDROMs use the ide bus quite
heavily under ripping...

General notes:
Motherboard: Supermicro P6DBU w/onboard 2940U2W
CPU: Dual PII 350mhz
SCSI Bus: 0: IBM 9gig U2W, 1: IBM 4gig U2W, 2: Pioneer DVDROM (used for
	ripping)
IDE BUS 0: Maxtor 27 gig
IDE BUS 1: Teac IDE CDRom

Also happens with Teac Slaved to Maxtor

Questions, Comments, Ideas?

Keith Baker	
Email:	Syzygy@pubnix.org

Life is a sexually transmitted disease with 100% mortality. 

