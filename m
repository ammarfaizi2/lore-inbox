Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263930AbRFHI3T>; Fri, 8 Jun 2001 04:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263932AbRFHI3J>; Fri, 8 Jun 2001 04:29:09 -0400
Received: from tangens.hometree.net ([212.34.181.34]:41344 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S263930AbRFHI3E>; Fri, 8 Jun 2001 04:29:04 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
Date: Fri, 8 Jun 2001 08:29:02 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9fq2ce$gkb$1@forge.intermeta.de>
In-Reply-To: <9fnjh0$d1c$1@forge.intermeta.de> <E1583xV-0001f3-00@the-village.bc.nu>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 991988942 17629 212.34.181.4 (8 Jun 2001 08:29:02 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Fri, 8 Jun 2001 08:29:02 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> And this is legal according to the "Kernel GPL, Linus Torvalds edition
>> (TM)" which says "any loadable module can be binary only". Not "only
>> loadable modules which are drivers". It may not be the intention but
>> it is the fact.

>Linus opinion on this is irrelevant. Neither I nor the FSF nor many others
>have released code under anything but the vanilla GPL. By merging such code
>Linus lost his ability to vary the license.

Ok, this is a new opinion, because it voids the "using the published
module ABI is unconditionally ok as stated again and again.

>So it comes down to the question of whether the module is linking (which is
>about dependancies and requirements) and what the legal scope is. Which
>is a matter for lawyers.

And this would void DaveMs' argument, that only the "official in
Linus' kernel published interface is allowed for binary modules". This
would mean, that putting the posted, unofficial patch under GPL into
the kernel and then using this interface for a binary module is just
the same as using only the official ABI from a lawyers' point of
view! 

This would make DaveMs' position even less understandable, because
there would be no difference for a proprietary vendor but keeping the
patch out of the kernel makes life harder for people like the original
poster that want to test new (open sourced) protocols like SCTP.

> Anyone releasing binary only modules does so having made their own
> appropriate risk assessment and having talked (I hope) to their
> insurers

Ugh, this is a sentence we're bound to read out of context on ZDNet
and m$.com... =:-( (Linux head developer warns companies to do risk
assessment before releasing drivers for Linux... Film at 11.)

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
