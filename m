Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290157AbSAQTJX>; Thu, 17 Jan 2002 14:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290158AbSAQTJN>; Thu, 17 Jan 2002 14:09:13 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62220 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290157AbSAQTI7>; Thu, 17 Jan 2002 14:08:59 -0500
Date: Thu, 17 Jan 2002 14:08:41 -0500
Message-Id: <200201171908.OAA02671@gatekeeper.tmr.com>
To: rwhron@earthlink.net
Subject: Re: Rik spreading bullshit about VM
In-Reply-To: <20020116202640.A485@earthlink.net>
Organization: TMR Associates, Schenectady NY
Cc: linux-kernel@vger.kernel.org
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020116202640.A485@earthlink.net> you write:
| About running the Andrea VM in 4M:
| I booted in single user mode.
| 
| bash-2.05a# uname -a
| Linux mountain 2.4.18pre2aa2 #1 Wed Jan 9 21:44:03 EST 2002 i586 unknown
| 
| bash-2.05a# dmesg| grep mem
| Kernel command line: BOOT_IMAGE=2418p2aa2 ro root=1602 console=ttyS1,38400n8 single mem=4m
| Memory: 2100k/4096k available (891k kernel code, 1608k reserved, 215k data, 196k init, 0k highmem)
| Freeing unused kernel memory: 196k freed

	[...snip...]

| I've tested a bunch of kernels lately.  This is only what's sitting in /boot
| since I last cleaned it out:
| 
| mountain:/boot$ ls vml*
| vmlinuz                  vmlinuz-2.4.17rc2aa2-old  vmlinuz-2.4.18-pre3         
| vmlinuz-2.4.18pre2       vmlinuz-2.4.18pre3ll      vmlinuz-2.5.1-dj11  
| vmlinuz-2.5.2-pre10      vmlinuz-2.5.2-pre9        vmlinuz-2.4.17
| vmlinuz-2.4.17rc2aa2-wli vmlinuz-2.4.18-pre4       vmlinuz-2.4.18pre2aa1
| vmlinuz-2.4.18pre3pe     vmlinuz-2.5.1-dj13        vmlinuz-2.5.2-pre11
| vmlinuz-2.5.2-pre9mingo  vmlinuz-2.4.17-rmap11a    vmlinuz-2.4.17rmap11b
| vmlinuz-2.4.18pre1-mjc2nio vmlinuz-2.4.18pre2aa2   vmlinuz-2.4.18pre3pelb
| vmlinuz-2.5.1-dj14       vmlinuz-2.5.2-pre5        vmlinuz.old
| vmlinuz-2.4.17rc2aa2    vmlinuz-2.4.18-pre1        vmlinuz-2.4.18pre1mjc2
| vmlinuz-2.4.18pre3-ac2  vmlinuz-2.5.1              vmlinuz-2.5.2
| vmlinuz-2.5.2-pre6-mingo
| 
| IMHO, 2.4.18pre2aa2 is the best!

  Of the current kernels it may well be, I have tried it on two largish
machines and it worked "right," I'm building it on a small and slow
machine to try that. However, I was not happy with the default bdflush
settings, and people who don't see what they want should use the
expanded capabilities of -aa before complaining. Also, the performance
I've seen so far, and I have NOT run a full set of tests, would
indicate that it is slightly better than 2.4.13-acN (N is 5, 7 or 8,
don't have it on this machine).

  I am looking forward to testing on many configs, and just for the
extra tuning tools in bdflush I think it will be good on all of them.
As I posted before, I think the best scheduler is the one which doesn't
have "jackpot cases" which produce really bad performance. With a
little tuning I believe -aa is there.

  Finally, that said I'm trying a patch of my own to -aa, which is why
I haven't run the full set of tests, there are two things I think will
make it even better, and I am finally getting to understand the code,
little as I wanted to.

  I can't disagree with Rik on the VM in the unpatched kernel for
several months. It really was not good, and both the -ac and -aa kernels
were taking aim at that problem. IMHO the changes went in before the
bugs went out. Needless to say Rik should not apply for a job as a
diplomat, but I can't disagree with the existance of a problem. If RH
uses a custom VM he was factual about that, although there may be
several reasons for the choice.

  Maybe we could deflect the pissing contest back to technical
discussion now?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
