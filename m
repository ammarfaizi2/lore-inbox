Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264969AbTAETAg>; Sun, 5 Jan 2003 14:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264983AbTAETAg>; Sun, 5 Jan 2003 14:00:36 -0500
Received: from smtp1.home.se ([195.66.35.200]:42640 "EHLO smtp1.home.se")
	by vger.kernel.org with ESMTP id <S264969AbTAETAf>;
	Sun, 5 Jan 2003 14:00:35 -0500
Message-ID: <006f01c2b4ed$e84610f0$0219450a@sandos>
From: =?iso-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
To: <linux-kernel@vger.kernel.org>
Subject: Re: How does the disk buffer cache work?
Date: Sun, 5 Jan 2003 20:08:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Earlier I wrote to the list where my SS10 hung on
the partition check
> This happens to me aswell. 2.5.35(I think) and 2.4.20
> is not working, a slackware 2.2 bootdisk is fine
though
> so something is wrong. The hdd is fine in DOS aswell.

More details: lspci -vv output for the IDE controller:

00:07.1 IDE interface: Intel Corp. 82371FB PIIX IDE
[Triton I] (rev 02) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: [virtual] I/O ports at 01f0
        Region 1: [virtual] I/O ports at 03f4
        Region 2: [virtual] I/O ports at 0170
        Region 3: [virtual] I/O ports at 0374
        Region 4: I/O ports at 3000 [size=16]

The hdd is a 1GB ST51080A, but I dont know if its the
particualr hdd that causes problems, or if its
something else. A cdrom on the same channel works. Dont
have any other hdds to test with right now.

---
John Bäckstrand


