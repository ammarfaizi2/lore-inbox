Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbSKKLma>; Mon, 11 Nov 2002 06:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266354AbSKKLma>; Mon, 11 Nov 2002 06:42:30 -0500
Received: from mail.hometree.net ([212.34.181.120]:64152 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S266347AbSKKLm3>; Mon, 11 Nov 2002 06:42:29 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [PATCH] [2.4.20-rc1] compiler fix drivers/ide/pdc202xx.c
Date: Mon, 11 Nov 2002 11:49:16 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <aqo5fs$65i$1@forge.intermeta.de>
References: <200211102211.10277.daniel.mehrmann@gmx.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1037015356 2635 212.34.181.4 (11 Nov 2002 11:49:16 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 11 Nov 2002 11:49:16 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Mehrmann <daniel.mehrmann@gmx.de> writes:

>Hello Marcelo,

>i fix a compiler warning from pdc202xx.c.
>The "default:" value in the switch was empty. Gcc don`t like
>this. We don`t need this one. 

Correct solution is not to remove the "default:" but to add a "break;"

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
