Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132488AbREBJWU>; Wed, 2 May 2001 05:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbREBJWL>; Wed, 2 May 2001 05:22:11 -0400
Received: from tangens.hometree.net ([212.34.181.34]:61091 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S132488AbREBJWB>; Wed, 2 May 2001 05:22:01 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: Maximum files per Directory
Date: Wed, 2 May 2001 09:21:59 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9cojjn$si1$1@forge.intermeta.de>
In-Reply-To: <272800000.988750082@hades>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 988795319 5870 212.34.181.4 (2 May 2001 09:21:59 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 2 May 2001 09:21:59 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Rogge <lu01@rogge.yi.org> writes:

>While trying to create 100.000 (in words: one hundred thousand) Mailboxes 
>with
>cyrus-imapd i ran into problems.
>At about 2^15 files the filesystem gave up, telling me that there cannot be
>more files in a directory.

Ugh. Went into this on a NetApp Filer some years ago, too.

Easy solution: Use multiple partitions with cyrus. 

I also have a hashing patch for cyrus somewhere.

Does ReiserFS help here?

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
