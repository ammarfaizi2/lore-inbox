Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319163AbSIDMbj>; Wed, 4 Sep 2002 08:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319164AbSIDMbj>; Wed, 4 Sep 2002 08:31:39 -0400
Received: from mail.hometree.net ([212.34.181.120]:31450 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S319163AbSIDMbi>; Wed, 4 Sep 2002 08:31:38 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: 2.4.18 & 2.4.19 IDE chipset clash? Promise PDC20267/SvrWks CSB5
Date: Wed, 4 Sep 2002 12:36:12 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <al4uns$ibm$1@forge.intermeta.de>
References: <1031109167.4925.38.camel@eljefe.wsm.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1031142972 2709 212.34.181.4 (4 Sep 2002 12:36:12 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 4 Sep 2002 12:36:12 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Johnson <jeff@wsm.com> writes:

>Greetings,

>	I am trying to get a kernel running on an Intel SCB2 board. It has
>onboard Promise PDC20267 RAID and Serverworks IDE controllers. The
>problem I am seeing is when Promise support is compiled into the kernel
>the Serverworks IDE chip will appear but fail to become available. The
>CDROM drive attached to the Serverworks chip is never visible. If I
>disable the Promise chip in the board's bios and boot the same kernel
>the serverworks IDE attaches and the CDROM shows up and can be accessed.

You must force the Promise IDE support. And you should use an -ac
kernel because the Promise RAID support there is much better.

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
