Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318140AbSGWQ6T>; Tue, 23 Jul 2002 12:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318141AbSGWQ6T>; Tue, 23 Jul 2002 12:58:19 -0400
Received: from ns1.systime.ch ([194.147.113.1]:28934 "EHLO mail.systime.ch")
	by vger.kernel.org with ESMTP id <S318140AbSGWQ6S>;
	Tue, 23 Jul 2002 12:58:18 -0400
From: "Martin Brulisauer" <martin@uceb.org>
To: George France <france@handhelds.org>
Date: Tue, 23 Jul 2002 19:01:07 +0200
Subject: Re: kbuild 2.5.26 - arch/alpha
CC: linux-kernel@vger.kernel.org
Message-ID: <3D3DA7F3.9275.1480075C@localhost>
References: <3D3D6B3B.25754.1392D3FD@localhost>
In-reply-to: <02072311055101.22920@shadowfax.middleearth>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jul 2002, at 11:05, George France wrote:
> that version for a while until it is stable.  In the past few months most of 
> the efforts have been spent on 2.4.9.  Currently there have been discussions 
> in regard to:
> 
> 1) porting all those patches for 2.4.9 forward to 2.4.[18-19] and 2.5.x.  

I am currently running 2.4.18 from SuSE without any (major) 
problems. I found it here:
ftp://ftp.suse.com/pub/people/sf/axp/7.1/RPMS/kernel-source-
2.4.18.SuSE-0.alpha.rpm.
Then I took arch/alpha/kernel/core_cia.c from version 2.4.12
(the current version does not run on XLT's booting with MILO;
the latest one is 2.4.12).

> 2) taking a look at the latest 2.5.x in the next few weeks, as we are aware 
> that 2.5.x does not compile on Alpha.

Hopefully I can fix core_cia.c to run on XLT's (it's hard to find any 
documentation on this toppic) and arch/alpha/kernel/setup.c for 
machines booting with linload.exe/MILO because the hwrpb
struct is built by MILO and does not match the one booting from
SRM (eg. empty percpu struct resulting in a cpucount of zero
in /proc/cpuinfo).

Regards,
Martin

