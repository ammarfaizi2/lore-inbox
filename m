Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUFXU7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUFXU7m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 16:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263820AbUFXU7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 16:59:41 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55794 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262538AbUFXU7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 16:59:32 -0400
Date: Thu, 24 Jun 2004 22:59:22 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.7-mm2: compile error SCHED_SMT + NUMA + gcc 2.95
Message-ID: <20040624205922.GC26669@fs.tum.de>
References: <20040624014655.5d2a4bfb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624014655.5d2a4bfb.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following compile error in 2.6.7-mm2 with SCHED_SMT=y 
and NUMA=y when using gcc 2.95 (it doesn't seem to be specific to -mm):

<--  snip  -->

...
  CC      arch/i386/kernel/smpboot.o
arch/i386/kernel/smpboot.c: In function `arch_init_sched_domains':
arch/i386/kernel/smpboot.c:1195: invalid lvalue in unary `&'
arch/i386/kernel/smpboot.c:1231: invalid lvalue in unary `&'
make[1]: *** [arch/i386/kernel/smpboot.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

