Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbSLPJMe>; Mon, 16 Dec 2002 04:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266278AbSLPJMe>; Mon, 16 Dec 2002 04:12:34 -0500
Received: from mail.hometree.net ([212.34.181.120]:25732 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S266064AbSLPJMd>; Mon, 16 Dec 2002 04:12:33 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: RFC: p&p ipsec without authentication
Date: Mon, 16 Dec 2002 09:20:27 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <atk5sr$a06$1@forge.intermeta.de>
References: <Pine.LNX.4.50L.0212151745360.2711-100000@imladris.surriel.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1040030427 16130 212.34.181.4 (16 Dec 2002 09:20:27 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 16 Dec 2002 09:20:27 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

>Hi,

>I've got a crazy idea.  I know it's not secure, but I think it'll
>add some security against certain attacks, while being non-effective
>against some others.

While the idea itself is nice, it would allow many attackers on your
host to "dive" under IDS systems or avoid stateful firewalls which do
protocol verification. And IDS system is "a three letter acronym
listening on your traffic". And you want to avoid that. =:-)

It won't traverse many firewalls either (because they won't let IPSEC
pass) and you might get in trouble with NAT and protocols that need
NAT fixup.

And you basically divide the Internet into "Linux <-> Linux" and "the
rest". :-)

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
