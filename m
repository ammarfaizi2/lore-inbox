Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbSKJNfA>; Sun, 10 Nov 2002 08:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264868AbSKJNfA>; Sun, 10 Nov 2002 08:35:00 -0500
Received: from mail.hometree.net ([212.34.181.120]:13031 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S264867AbSKJNe7>; Sun, 10 Nov 2002 08:34:59 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [PATCH] Re: sscanf("-1", "%d", &i) fails, returns 0
Date: Sun, 10 Nov 2002 13:41:45 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <aqlnmp$sd4$1@forge.intermeta.de>
References: <Pine.LNX.4.44.0211081211141.4471-100000@penguin.transmeta.com> <Pine.LNX.4.33L2.0211081407560.32726-100000@dragon.pdx.osdl.net>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1036935705 19394 212.34.181.4 (10 Nov 2002 13:41:45 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sun, 10 Nov 2002 13:41:45 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

>+		digit = *str;
>+		if (is_sign && digit == '-')
>+			digit = *(str + 1);

If signed is not allowed and you get a "-", you're in an error case
again...

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
