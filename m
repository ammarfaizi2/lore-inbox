Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267630AbUHELTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267630AbUHELTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 07:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267649AbUHELTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 07:19:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14803 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267630AbUHELSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 07:18:43 -0400
Date: Thu, 5 Aug 2004 13:18:35 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Rick Lindsley <ricklind@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.8-rc3-mm1: SCHEDSTATS compile error
Message-ID: <20040805111835.GB2746@fs.tum.de>
References: <20040805031918.08790a82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805031918.08790a82.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 03:19:18AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.8-rc2-mm2:
>...
> +schedstats-2.patch
>...
>  CPU scheduler statitics
>...

<--  snip  -->

...
  CC      kernel/sched.o
kernel/sched.c: In function `show_schedstat':
kernel/sched.c:372: error: structure has no member named `sd'
kernel/sched.c:372: error: dereferencing pointer to incomplete type
kernel/sched.c:375: error: dereferencing pointer to incomplete type
kernel/sched.c:380: error: dereferencing pointer to incomplete type
kernel/sched.c:381: error: dereferencing pointer to incomplete type
kernel/sched.c:382: error: dereferencing pointer to incomplete type
kernel/sched.c:383: error: dereferencing pointer to incomplete type
kernel/sched.c:384: error: dereferencing pointer to incomplete type
kernel/sched.c:387: error: dereferencing pointer to incomplete type
kernel/sched.c:387: error: dereferencing pointer to incomplete type
kernel/sched.c:388: error: dereferencing pointer to incomplete type
kernel/sched.c:388: error: dereferencing pointer to incomplete type
make[1]: *** [kernel/sched.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

