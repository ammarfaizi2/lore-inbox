Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbSLHJVe>; Sun, 8 Dec 2002 04:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265255AbSLHJVe>; Sun, 8 Dec 2002 04:21:34 -0500
Received: from mail.hometree.net ([212.34.181.120]:48821 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265247AbSLHJVd>; Sun, 8 Dec 2002 04:21:33 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [BUG] 2.4.20-BK
Date: Sun, 8 Dec 2002 09:29:12 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <asv3d8$nr$1@forge.intermeta.de>
References: <200212071434.11514.m.c.p@wolk-project.de> <200212072036.08500.m.c.p@wolk-project.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1039339752 5754 212.34.181.4 (8 Dec 2002 09:29:12 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sun, 8 Dec 2002 09:29:12 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen <m.c.p@wolk-project.de> writes:

>pdc202xx_new: static build, module build do not have Special FastTrack 
>features so the system will say neither IDE port enabled (BIOS) so it won't 
>work.
[...]
>    ide0: BM-DMA at 0x9400-0x9407, BIOS settings: hda:pio, hdb:pio
>    ide1: BM-DMA at 0x9408-0x940f, BIOS settings: hdc:pio, hdd:pio
[...]
>    ide2: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
>    ide3: BM-DMA at 0xffa8-0xffaf, BIOS settings: hda:pio, hdb:DMA

Shouldn't these bei hde - hdh ? I'd be scared by my machine reporting
hda thrice. :-)

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
