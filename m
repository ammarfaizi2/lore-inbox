Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbTJTN1J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 09:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbTJTN1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 09:27:09 -0400
Received: from [62.67.222.139] ([62.67.222.139]:10953 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S262574AbTJTN1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 09:27:05 -0400
Date: Mon, 20 Oct 2003 15:27:05 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: Uncorrectable Error on IDE, significant accumulation
Message-ID: <20031020132705.GA1171@synertronixx3>
Reply-To: konsti@ludenkalle.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: http://www.ludenkalle.de/konsti/pubkey.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.

I have a probably unusual question which is mainly directed to the
linux-kernel IDE driver developers due to their experience with IDE
disks.

I have a PC @home, which accumulates HDDs in it which die.

This Weekend my 120GB Maxtor begun to die with Uncorrectable Errors.
I thought "OK, another damn Quality Hard Drive" But half a year ago I
replaced a not so old 40GB MAxtor in it and before that a 20GB System
Disk and a WD800JB has already 6 Secors remapped (smartctl -a). My
friends call me the "Master of the HDD cemetary".

After that I realized, that 99% of my harddisk which die do this in that
PC. I have a K7S5A Mainboard in it with SiS chipset. Kernel IDE Driver
sis5513 is compiled in, UDMA switched on.

My question is, can a subtile Hardware error in the Mainboard exist so
that HDDs is written bullshit to into some sektors which is discovered
days or months later when reading/writing there?
Or can the Kernel provocate (in Hardware!) Uncorrectable errors with
software?
I used Kernel 2.4.20-acX and since 2.5.69-mmX this one.
Or do I have simply bad luck in buying HDDs?
They are mounted good, the Wires are accurately folded together, 1" air
above and under each disk, additional case fan...
It is my home server for mail/news/print/nfs and used as public ftp at
lan-partys 3 or 4 times a year. For this purpose (pub ftp) there are two
disks of three used with an LVM2 around all three. 
Statistically after each lan-party one drive dies. Not immedieately
though.

Any opinions? Similair Experiences? Software? Hardware? Bad Luck?

Regards, Konstantin Kletschke


-- 
2.6.0-test1-mm2
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 3:45, 20 users
