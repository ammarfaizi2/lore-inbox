Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269070AbUIHJqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269070AbUIHJqO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269076AbUIHJp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:45:59 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:54174 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269068AbUIHJpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:45:46 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R9
Date: Wed, 8 Sep 2004 11:46:09 +0200
User-Agent: KMail/1.6.2
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Alexander Nyberg <alexn@dsv.su.se>
References: <20040903120957.00665413@mango.fruits.de> <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu>
In-Reply-To: <20040908082050.GA680@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409081146.09526.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 of September 2004 10:20, Ingo Molnar wrote:
> 
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Does not work on 32 bit x86:
> > 
> >   CHK     include/linux/compile.h
> >   UPD     include/linux/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > kernel/built-in.o(.init.text+0xcbf): In function `interruptible_sleep_on':
> > kernel/sched.c:1563: undefined reference to `init_irq_proc'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> does -R9 work for you:
> 
>   
http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12-R9

Er, it doesn't work for me:

  HOSTCC  scripts/genksyms/parse.o
  HOSTLD  scripts/genksyms/genksyms
  CC      scripts/mod/empty.o
/bin/sh: line 1: x86_64-unknown-linux-gcc: command not found
make[2]: *** [scripts/mod/empty.o] Error 127
make[1]: *** [scripts/mod] Error 2
make: *** [scripts] Error 2

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
