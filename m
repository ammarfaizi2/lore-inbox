Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314484AbSESPvh>; Sun, 19 May 2002 11:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314486AbSESPvg>; Sun, 19 May 2002 11:51:36 -0400
Received: from servidor.unam.mx ([132.248.10.1]:35986 "EHLO servidor.unam.mx")
	by vger.kernel.org with ESMTP id <S314484AbSESPvf>;
	Sun, 19 May 2002 11:51:35 -0400
Subject: Problem with swap partition.
From: David Eduardo Gomez Noguera <davidgn@servidor.unam.mx>
To: kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 19 May 2002 11:04:57 -0500
Message-Id: <1021824299.2430.7.camel@hikaru>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
I have just changed to a new hard disk:

Disk /dev/hdc: 16 heads, 63 sectors, 77545 cylinders

Nr AF  Hd Sec  Cyl  Hd Sec  Cyl    Start     Size ID
 1 00   1   1    0  15  63   65       63    66465 83
 2 00   0   1   66  15  63 1023    66528 77952672 83
 3 00  15  63 1023  15  63 1023 78019200   146160 82
 4 00   0   0    0   0   0    0        0        0 00

The 3'rd partition is a Linux Swap,
/dev/hdc3         77401     77545     73080   82  Linux swap

but swapon -a gives
swapon: /dev/hdc5: Invalid argument

its a 40Gb hd seagate ultra ata.

Is there any issue with them? (dont think so, since the other partitions
work ok). its a 2.4.17 .

ps. I dont know if i might be missing some kernel module.
-- 
ICQ: 15605359 Bicho
                                  =^..^=
First, they ignore you. Then they laugh at you. Then they fight you.
Then you win. Mahatma Gandhi.
-------------------------------気検体の一致------------------------------------
暑さ寒さも彼岸まで。
恋にししょうなし。恋はしあんの他。
アン アン アン とっても大好き


