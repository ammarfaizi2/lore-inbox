Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136098AbRECAPI>; Wed, 2 May 2001 20:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136097AbRECAO6>; Wed, 2 May 2001 20:14:58 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:42586 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136092AbRECAOn>; Wed, 2 May 2001 20:14:43 -0400
Date: Wed, 2 May 2001 20:14:38 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200105030014.f430EcO25964@devserv.devel.redhat.com>
To: Marc@SoftwareHackery.Com, <linux-kernel@vger.kernel.org>
Subject: Re: Build problems 2.4.4 on SPARC
In-Reply-To: <mailman.988827960.5573.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.988827960.5573.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While trying to compile the 2.4.4 kernel on a SPARC-20, I encounter the
> following error.

> make[1]: Entering directory `/usr/src/linux-2.4.4/mm'
> make all_targets
> make[2]: Entering directory `/usr/src/linux-2.4.4/mm'
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.4/include -Wall -Wstrict-prototypes
> -O2 -fomit-frame-pointer -fno-strict-aliasing -m32 -pipe -mno-fpu
> -fcall-used-g5 -fcall-used-g7    -c -o memory.o memory.c
> memory.c:183: macro `pmd_alloc' used with too many (3) args

Known problem... For some reason, even current vger CVS has it.
You might want to try Eirik's patch, but I have not idea if
it is correct.

 http://marc.theaimsgroup.com/?l=linux-sparc&m=98731698113169&w=2

IMHO, sparc needs a port maintainer. Obviously, DaveM has barely
enough time to deal with sparc64. Unfortunately it is not a position
for weak (like myself). At various times I, Uzi, and Anton tried
that crown for size, but it is way too big and heavy.

-- Pete
