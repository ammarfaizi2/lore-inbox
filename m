Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbSKJN1a>; Sun, 10 Nov 2002 08:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264865AbSKJN1a>; Sun, 10 Nov 2002 08:27:30 -0500
Received: from mail.hometree.net ([212.34.181.120]:4071 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S264857AbSKJN13>; Sun, 10 Nov 2002 08:27:29 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [PATCH-2.5.46] IDE BIOS timings
Date: Sun, 10 Nov 2002 13:34:14 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <aqln8m$sbb$1@forge.intermeta.de>
References: <20021107164009.GL1737@tmathiasen> <1036775438.16898.31.camel@irongate.swansea.linux.org.uk> <20021108165641.GA18126@suse.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1036935254 19250 212.34.181.4 (10 Nov 2002 13:34:14 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sun, 10 Nov 2002 13:34:14 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

>-	unsigned autotune	: 2;	/* 1=autotune, 2=noautotune, 0=default */
>+	unsigned autotune	: 3;	/* 1=autotune, 2=noautotune, 
>+					   3=biostimings, 0=default */
 
Why are three bits reserved for four states?  (or am I reading this
wrong? Sorry, my C has started to become a little rusty).

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
