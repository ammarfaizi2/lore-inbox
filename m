Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265042AbRGNW4N>; Sat, 14 Jul 2001 18:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265101AbRGNW4D>; Sat, 14 Jul 2001 18:56:03 -0400
Received: from smarty.smart.net ([207.176.80.102]:38411 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S265042AbRGNWz6>;
	Sat, 14 Jul 2001 18:55:58 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200107142310.TAA07985@smarty.smart.net>
Subject: Re: __KERNEL__ removal
To: linux-kernel@vger.kernel.org
Date: Sat, 14 Jul 2001 19:10:30 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Jeff Garzik
>If there -must- be parts of the kernel that are visible to userspace,
>yes, we should separate them and make that separation obvious.  I would
>not call our current setup obvious :)


There are. -must-. Plan 9 minimizes them. It ain't POSIX, I'm guessing,
never having seen a POSIX in real life myself. I do happen to have K&R2
right here though. Hmmm, unistd.h is not in the 89 spec. Well of course
not. It's not C. You need need need that (which is why I did libsys.a),
and I think Plan 9 has a thing that lays out calling conventions for
syscalls, and some other things about the local CPU. Actually, Plan 9 lays
out lots of CPUs, being heterogenously distributed. That's where I get
dizzy, and start to wax unix-traditional. With all my twisted antics, I've
never cross-compiled anything. You also need ioctls for userland probably,
which Plan 9 either doesn't have or they actually figured out how to hide
them.

There's also a level below unistd.h maybe. A libcpu or something. Dono.

Rick Hohensee
		www.clienux.com
