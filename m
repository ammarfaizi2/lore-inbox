Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUHSPYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUHSPYz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266514AbUHSPX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 11:23:29 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:5256 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266334AbUHSPSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 11:18:08 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 19 Aug 2004 17:16:59 +0200
To: mj@ucw.cz, matthias.andree@gmx.de
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       kernel@wildsau.enemy.org, diablod3@gmail.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <4124C46B.nail83H31GJ2S@burner>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
 <d577e5690408190004368536e9@mail.gmail.com>
 <4124A024.nail7X62HZNBB@burner> <20040819131026.GA9813@ucw.cz>
 <4124AD46.nail80H216HKB@burner> <20040819135614.GA12634@ucw.cz>
 <4124B314.nail8221CVOE9@burner> <20040819141442.GC13003@ucw.cz>
 <20040819150704.GB1659@merlin.emma.line.org>
In-Reply-To: <20040819150704.GB1659@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please let us cluse this duplicate discussion here.
It does not give new informstion and it takes a lot of my time.

>From matthias.andree@gmx.de  Thu Aug 19 17:07:13 2004

>Non-issue.  SuSE 9.1 PRO:

>$ rpm -qf /usr/bin/cdrecord
>cdrecord-2.01a27-21
>$ /usr/bin/cdrecord -version
>ZYï¿½$: Operation not permitted. WARNING: Cannot set RR-scheduler
>ZYï¿½$: Permission denied. WARNING: Cannot set priority using setpriority().
>ZYï¿½$: WARNING: This causes a high risk for buffer underruns.

What you see is 2 SuSE created bugs :-(

1)	printing this message at all in this special case

2)	SuSE using non initialized variables.

>Cdrecord-Clone-dvd 2.01a27 (i686-suse-linux) Copyright (C) 1995-2004 JÃ¶rg Schilling
>Note: This version is an unofficial (modified) version with DVD support
>Note: and therefore may have bugs that are not present in the original.
>Note: Please send bug reports or support requests to http://www.suse.de/feedback
>Note: The author of cdrecord should not be bothered with problems in this version.


Isn't is pure taunt to output the text "may have bugs" after verifying two bugs?


>$ /opt/schily/bin/cdrecord -version
>Cdrecord-Clone 2.01a37 (i686-pc-linux-gnu) Copyright (C) 1995-2004 Jï¿½rg Schilling
>/opt/schily/bin/cdrecord: Warning: Running on Linux-2.6.8.1
>/opt/schily/bin/cdrecord: There are unsettled issues with Linux-2.5 and newer.
									^^^^^^
									should 
									be "later"
>/opt/schily/bin/cdrecord: If you have unexpected problems, please try Linux-2.4 or Solaris.

>I read the discussion as though these issues had been settled with
>Linux 2.6.8. Is 2.01a37 too old to be aware of the fix or is there an
>issue left with finding the "right" header files?

cdrtools is in code freeze and Linux-2.6.8 did open new problems that would 
require code anhancements that cannot be done in this state of cdrtools.

There are other problems that have been discussed last week.....

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
