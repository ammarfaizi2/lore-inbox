Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269787AbRIIKKu>; Sun, 9 Sep 2001 06:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271941AbRIIKKk>; Sun, 9 Sep 2001 06:10:40 -0400
Received: from tangens.hometree.net ([212.34.181.34]:10446 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S269787AbRIIKK2>; Sun, 9 Sep 2001 06:10:28 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: Re[2]: Basic reiserfs question
Date: Sun, 9 Sep 2001 10:10:48 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9nff78$cuq$1@forge.intermeta.de>
In-Reply-To: <F45bR99kQgkV07DPT1p00005d9e@hotmail.com> <200109071335.f87DZcI01604@atmpe.omnitel.net>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1000030248 10287 212.34.181.4 (9 Sep 2001 10:10:48 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sun, 9 Sep 2001 10:10:48 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nerijus Baliunas <nerijus@users.sourceforge.net> writes:

>HR> I only have secondhand reports from users who patch RedHat boot scripts as
>HR> described at the end of www.namesys.com/faq.html, so your statement leaves me
>HR> puzzled as to whether the secondhand reports were from persons who didn't
>HR> understand the boot scripts.  Comments are welcome.

>I didn't patch any boot scripts at all - they are pure RH ones.

It's true, that the RH 6.2 scripts only remount the root-FS read-only
before rebooting if it is on ext2. This is only true for the root-FS
(not any other FS), and I could check this only on RH 6.2 (Don't know
about RH 7.x, I'd guess that they fixed it). If you don't have your
root-FS on Reiser / XFS / JFS, you have no problem with RH 6.x

The FAQ entry from namesys is just misleading. 

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
