Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261331AbSKGRmN>; Thu, 7 Nov 2002 12:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261332AbSKGRmN>; Thu, 7 Nov 2002 12:42:13 -0500
Received: from xedos.starman.ee ([62.65.192.3]:51597 "EHLO mx1.starman.ee")
	by vger.kernel.org with ESMTP id <S261331AbSKGRmM>;
	Thu, 7 Nov 2002 12:42:12 -0500
Message-ID: <32851.62.65.205.175.1036691341.squirrel@webmail.starman.ee>
Date: Thu, 7 Nov 2002 19:49:01 +0200 (EET)
Subject: 2.5.46: ide-cd cdrecord success report
From: "MdkDev" <mdkdev@starman.ee>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Reply-To: mdkdev@starman.ee
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Decided to replicate Adam Kropelins CD burning test (burn cd while
executing 'dd if=/dev/zero of=foo bs=1M'). Didn't have any problems - I
burned 323 MB ISO image while running the aforementioned dd command.
cdrecord reported:Track 01:  323 of  323 MB written (fifo 100%) [buf  99%]   4.2x.
Track 01: Total bytes read/written: 339247104/339247104 (165648 sectors).
Writing  time:  566.244s
Average write speed   4.0x.
Min drive buffer fill was 99%
Fixating...
Fixating time:   77.859s
cdrecord: fifo had 5344 puts and 5344 gets.
cdrecord: fifo was 0 times empty and 5186 times full, min fill was 92%.

File foo contained 7363 1 MB records.

Hardware:
CPU - AMD XP 2100+
RAM - 512 MB
MB - MSI KT3 Ultra3 (VIA KT333 chipset)
HDD - 2 IBM Deskstar IDE disks (using integrated RAID controller PDC 20276
as an ordinary ATA133 controller)CD burner - LiteOn LTR-16101B


