Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316960AbSEWRHK>; Thu, 23 May 2002 13:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316962AbSEWRHK>; Thu, 23 May 2002 13:07:10 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:38424 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316960AbSEWRHI>; Thu, 23 May 2002 13:07:08 -0400
Date: Thu, 23 May 2002 13:07:04 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200205231707.g4NH74K06402@devserv.devel.redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <mailman.1022085725.386.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anybody: if you've ever used /dev/ports, holler _now_.
> 
> 		Linus

I often use it as an alternative to #include <asm/io.h>,
which you decreed illegal. I understand <sys/io.h> is a legal
alternative, but a bunch of platforms forget to
include <sys/io.h>, for instance Jes cried bloody murder
when asked to add it to ia-64. But if you decide to drop /dev/port
I can tough it out. Solaris lives without it, and so can we.

I saw this whining about outl not implemented for
write(fd, &my_int, 4), and I think the guy had a little point.
Though if he wanted it, he ought to submit a patch.

-- Pete
