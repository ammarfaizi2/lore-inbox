Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281189AbRKPPY5>; Fri, 16 Nov 2001 10:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281448AbRKPPYr>; Fri, 16 Nov 2001 10:24:47 -0500
Received: from paloma14.e0k.nbg-hannover.de ([62.159.219.14]:61847 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S281189AbRKPPYj>; Fri, 16 Nov 2001 10:24:39 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: Re: Tuning Linux for high-speed disk subsystems
Date: Fri, 16 Nov 2001 16:24:24 +0100
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0111161249440.17531-100000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0111161249440.17531-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011116152444Z281189-17408+15080@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 16. November 2001 12:51 schrieb Roy Sigurd Karlsbakk:
> > Our 100 Gig SCSI raid, consisting of 6 15,000 rpm drives on the
> > motherboard's two SCSI 160 channels gives a full 110MB/sec read and write
> > with RAID 0. With RAID chunks set to 1MB the write accesses go to
> > 160MB/sec and read accesses go to 90MB/sec sustained. This system would
> > make a good motion capture tool. Previous Intel attempts at onboard disk
> > I/O would give 50MB/sec.
>
> How much do you think I can get out of 2x6 15k disks - each 6 disks are on
> their own SCSI-3/160 bus.

As I count your disks may be the double for the best case. I read here on 
LKML a post that someone claims that W2k deliever 250 MB/s with such a 
configuration. Linux 2.4 should do the same. Ask the SCSI gurus.

Regards,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science
@home: Dieter.Nuetzel@hamburg.de
