Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSHNXwb>; Wed, 14 Aug 2002 19:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316043AbSHNXwb>; Wed, 14 Aug 2002 19:52:31 -0400
Received: from smtp-stjh-01-02.rogers.nf.net ([192.75.13.142]:38135 "EHLO
	smtp-stjh-01-02.rogers.nf.net") by vger.kernel.org with ESMTP
	id <S315942AbSHNXwa>; Wed, 14 Aug 2002 19:52:30 -0400
From: "Chad Young" <skidley@roadrunner.nf.net>
Date: Wed, 14 Aug 2002 21:26:23 -0230
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac1
Message-ID: <20020814235623.GA381@hendrix>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200208141634.g7EGYGO29387@devserv.devel.redhat.com> <Pine.NEB.4.44.0208150036100.1351-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0208150036100.1351-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/home/skidley/kernel/linux-2.4.20-pre2-ac1/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2
-march=i686   -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
-DKBUILD_BASENAME=swap_state  -c -o swap_state.o swap_state.c
swap_state.c:155: macro `PAGE_BUG' used without args
make[2]: *** [swap_state.o] Error 1
make[2]: Leaving directory
`/home/skidley/kernel/linux-2.4.20-pre2-ac1/mm'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory
`/home/skidley/kernel/linux-2.4.20-pre2-ac1/mm'
make: *** [_dir_mm] Error 2

-- 
"I mean they are gonna kill ya so like if ya give em a quick, short, sharp,
shock they won't do it again. Dig it! I mean he got off lightly cuz I would 
have given him a thrashing. I only hit him once. It was only a difference of 
opinion but really... I mean good manners don't cost nothin do they. Eh?"
