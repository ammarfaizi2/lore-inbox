Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289120AbSA3Lme>; Wed, 30 Jan 2002 06:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289118AbSA3LmP>; Wed, 30 Jan 2002 06:42:15 -0500
Received: from tangens.hometree.net ([212.34.181.34]:38282 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S289117AbSA3LmG>; Wed, 30 Jan 2002 06:42:06 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: A modest proposal -- We need a patch penguin
Date: Wed, 30 Jan 2002 11:42:04 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <a38m6c$76d$1@forge.intermeta.de>
In-Reply-To: <Pine.LNX.4.33.0201291603520.7176-100000@localhost.localdomain> <E16VYVH-0003x8-00@the-village.bc.nu> <20020129144753.D9149@suse.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1012390924 31483 212.34.181.4 (30 Jan 2002 11:42:04 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 30 Jan 2002 11:42:04 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de> writes:

> Now that we have an open development branch again, perhaps its
> time for a lot of the things that have been proven stable in vendor
> kernels for a long time to get a looksee in mainline.
> Some things I feel will likely still be vendor-kernel only for some time.
> And some of them, rightly so.

Bah. RedHat puts what? 120+? Patches into 2.2 (!) to ship their vendor
kernel. And it is still much more stable than any 2.4 I've encountered
till today.

I personally run a heavily patched 2.2 (+aa, +ide +reiser +ext3 +raid
and so on) and still get uptimes on busy and heavily loaded servers
(think newsserver with 50+ MBit/sec continous traffic. Think web
accelerator for one of the busiest web sites in Germany. Think mail
system for 1M users) far beyond 200 days uptime.

Will these patches ever be integrated? No. And same will go to some
sore spots of 2.4. Think RAID for 2.2. Think NFS for 2.2 where we
almost had to strangle Alan just to put in the most obvious bug fixes
from Trond :-) . In what? 2.2.16?

Do we have NFSv3 over TCP (which is in the real world available for
how many years?)? A really reliable IDE driver (Hi Andre :-) )? A raid
code that won't stuble over recoverable SCSI errors? That does not
interact badly with some FS types (and of course with those where RAID
would be really interesting)?

We have a kernel based Webserver. But not reliable media detection for
run-of-the-mill network cards. Something which "that other OS" has
since 1995.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
