Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268300AbUHQPL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268300AbUHQPL0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268296AbUHQPLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:11:24 -0400
Received: from mo1.b-one.net ([195.47.247.27]:33683 "EHLO smtp1.b-one.net")
	by vger.kernel.org with ESMTP id S268284AbUHQPIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:08:18 -0400
Message-ID: <1218.80.62.167.105.1092755294.squirrel@80.62.167.105>
Date: Tue, 17 Aug 2004 17:08:14 +0200 (CEST)
Subject: 
From: morten@team60.dk
To: Hi@nowhere.in.space,
       "Please CC to morten at team60 dot" <dk@nowhere.in.space>,
       "as I'm not substribed.]"@/etc/mailname
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a 120GB Seagate SATA HDD on a nForce2 motherboard with the siI 3512A
SATA controller. I use the sata_sil driver. Please ask for more" <specs@nowhere.in.space>,
 ")

A few days ago I installed Debian Sarge 3.1RC1 with the new Debian installer.
FYI it has a 2.4.26 kernel. I proceeded to download the new 2.6.8.1 kernel
from" <kernel.org@nowhere.in.space>,
 "configuring and compiling it. Everything seemed to go smooth.
Then I wanted to install modconf and ran apt-get install modconf. It fetched
the package from the Internet as it was supposed" <to@nowhere.in.space>,
 "but when it was about
to unpack the" <package@nowhere.in.space>,
 "command 0x35" <timeout@nowhere.in.space>,
 "ERROR on" <channel@nowhere.in.space>,
 id@nowhere.in.space,
 lun@nowhere.in.space,
 "I/O" <error@nowhere.in.space>,
 "dev" <sda@nowhere.in.space>,
 "abnormal status 0x58 on port 0xE181B087

I" <rebooted@nowhere.in.space>,
 "repeated - same result.
I also tried the precompiled binaries of 2.6.7 from the Debian" <archives@nowhere.in.space>,
 "but that too yielded the same result.
I also tried that it froze during boot a few" <times@nowhere.in.space>,
 "when initializing all
the daemons.

In between I used the 2.4.26 kernel that came with" <Sarge@nowhere.in.space>,
 "and it worked
perfectly fine. I also have Windows 2000 on dual" <boot@nowhere.in.space>,
 "and there's no
problems there" <either@nowhere.in.space>,
 "so I don't think it's a hardware problem.

I heard that there has been a lot of work on SATA in 2.6.7 and" <2.6.8@nowhere.in.space>,
 "so
could this be a bug?

Thanks in" <advance@nowhere.in.space>,
 linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit




Hi,

[Note: Please CC to morten at team60 dot dk, as I'm not substribed.]


I have a 120GB Seagate SATA HDD on a nForce2 motherboard with the siI 3512A
SATA controller. I use the sata_sil driver. Please ask for more specs, if
you need them. :)

A few days ago I installed Debian Sarge 3.1RC1 with the new Debian installer.
FYI it has a 2.4.26 kernel. I proceeded to download the new 2.6.8.1 kernel
from kernel.org, configuring and compiling it. Everything seemed to go
smooth.
Then I wanted to install modconf and ran apt-get install modconf. It fetched
the package from the Internet as it was supposed to, but when it was about
to unpack the package, linux froze and I got an error similar to the one
below.

ata1: command 0x35 timeout, stat 0x58 host_stat 0x1
scsi: ERROR on channel 0, id 0, lun 0, CDB: 0x2a 00 0d 95 b9 9c 00 04 00 00
current sda: sense = 70  3
ASC= c ASCQ= 2
Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 0x00
0x0c 0x02
end_request: I/O error, dev sda, sector 227916204
ATA: abnormal status 0x58 on port 0xE181B087
ATA: abnormal status 0x58 on port 0xE181B087
ATA: abnormal status 0x58 on port 0xE181B087

I rebooted, repeated - same result.
I also tried the precompiled binaries of 2.6.7 from the Debian archives,
but that too yielded the same result.
I also tried that it froze during boot a few times, when initializing all
the daemons.

In between I used the 2.4.26 kernel that came with Sarge, and it worked
perfectly fine. I also have Windows 2000 on dual boot, and there's no
problems there either, so I don't think it's a hardware problem.

I heard that there has been a lot of work on SATA in 2.6.7 and 2.6.8, so
could this be a bug?

Thanks in advance,

Morten Bojsen-Hansen
morten at team60 dot dk

