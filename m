Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316364AbSEOKL1>; Wed, 15 May 2002 06:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316365AbSEOKL0>; Wed, 15 May 2002 06:11:26 -0400
Received: from c90136.upc-c.chello.nl ([212.187.90.136]:62093 "EHLO
	peder.flower") by vger.kernel.org with ESMTP id <S316364AbSEOKLZ>;
	Wed, 15 May 2002 06:11:25 -0400
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre8-ac3 -- thread_info?
In-Reply-To: <200205141244.g4ECi6P29886@devserv.devel.redhat.com>
Organization: Jan at Appel
From: Jan Nieuwenhuizen <janneke@gnu.org>
Date: Wed, 15 May 2002 12:11:24 +0200
Message-ID: <87ptzxlnzn.fsf@peder.flower>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> writes:

> The usual IDE merge comments apply. Please treat this tree with care.

Hi,

It seems that 2.4.19pre8-ac3 introduced the use of thread_info, but
it's not defined in sched.h?

Greetings,
Jan.

gcc -D__KERNEL__ -I/var/src/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -O2 -c -o sched.o sched.c
sched.c: In function `migration_thread':
sched.c:1595: structure has no member named `thread_info'
sched.c:1600: structure has no member named `thread_info'
sched.c:1606: structure has no member named `thread_info'
sched.c:1574: warning: `cpu_src' might be used uninitialized in this function
make[2]: *** [sched.o] Error 1


-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org

