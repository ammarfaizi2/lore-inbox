Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316589AbSFUNAB>; Fri, 21 Jun 2002 09:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316588AbSFUNAA>; Fri, 21 Jun 2002 09:00:00 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:51352 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S316589AbSFUM77>; Fri, 21 Jun 2002 08:59:59 -0400
Date: Fri, 21 Jun 2002 07:59:15 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200206211259.HAA26820@tomcat.admin.navo.hpc.mil>
To: dalecki@evision-ventures.com, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: latest linus-2.5 BK broken
cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki <dalecki@evision-ventures.com>:
>Yes HT gives 12%. naive SMP gives 50% and good SMP (aka corssbar bus)
>gives 70% for two CPU. All those numbers are well below the level
>where more then 2-4 makes hardly any sense... Amdahl bites you still if you
>read it like:
...

I think your numbers are a little low - I've seen between 50%-80% on
master/slave SMP depending on the job. 50% if both processess are heavily
syscall oriented, 75% (or therabouts) when both processes are more normally
balanced, and 80% if both processes are more compute bound.

Good SMP, with a crossbar switch buss should give close to 95%. Good SMP
alone should give about 75%.

My expierence with good crossbar switch is based on Cray UNICOS/YMP/SV
hardware. A well tuned hardware platform, and slightly less well tuned
SMP implementation, though the UNICOS 10 rewrite may have fixed the
SMP implementation.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
