Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312275AbSC2W6L>; Fri, 29 Mar 2002 17:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312277AbSC2W6C>; Fri, 29 Mar 2002 17:58:02 -0500
Received: from tangens.hometree.net ([212.34.181.34]:41868 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S312275AbSC2W5o>; Fri, 29 Mar 2002 17:57:44 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Request for 2.4.20 to be a non-trivial-bugfixes-only
Date: Fri, 29 Mar 2002 22:57:42 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <a82rh6$pu6$1@forge.intermeta.de>
In-Reply-To: <5.1.0.14.0.20020329205616.00b6ebe0@mailhost.ivimey.org> <5.1.0.14.0.20020329210605.00b5ded8@mailhost.ivimey.org>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1017442662 15432 212.34.181.4 (29 Mar 2002 22:57:42 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Fri, 29 Mar 2002 22:57:42 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org> writes:

>fixed bugs I might hit next. Problem is, I have been looking for the 'good' 
>kernel for a while: trying 2.4.6, 2.4.8, 2.4.15, 2.4.17, 2.4.18rc1 -- I'm 
>starting to wonder when it might get here.

2.4.19-pre4-ac2 is the first kernel since ages that is able to boot up on
an Intel SC5x00 server with SDS2 board without either

- losing one processor
- losing one gig of RAM
- locking up in highmem
- locking up when loading the GDTH driver

2x 1,13GHz PIII Processor, 2 GB RAM, ServerWorks OSB5 chipset, GDTH
8523RZ controller driving four 36 GB U160 disks). Nice little box for
kernel compiles (actually it is a java application server running
apache / tomcat and various webapps, but until our stability issues
are ironed out I can play with it). 2.4.19pre4ac2 survived the
stress-kernel test from VA Linux for hours. Something no other kernel
in the 2.4 series was able to do. Now if I could please get a sensor
driver for the ADM1026...

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
