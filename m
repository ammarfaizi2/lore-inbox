Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbRE3JdC>; Wed, 30 May 2001 05:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262674AbRE3Jcw>; Wed, 30 May 2001 05:32:52 -0400
Received: from tangens.hometree.net ([212.34.181.34]:25482 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S262682AbRE3Jcl>; Wed, 30 May 2001 05:32:41 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: [PATCH] net #9
Date: Wed, 30 May 2001 09:32:39 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9f2enn$jbr$1@forge.intermeta.de>
In-Reply-To: <200105300048.CAA04583@green.mif.pg.gda.pl>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 991215159 21868 212.34.181.4 (30 May 2001 09:32:39 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 30 May 2001 09:32:39 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl> writes:

>-static char	name[4][IFNAMSIZ] = { "", "", "", "" };

>+static char	name[4][IFNAMSIZ];

Ugh. Sure about that one? the variables have been pointers to zero,
now they're zero...

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
