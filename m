Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbSLVSkP>; Sun, 22 Dec 2002 13:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbSLVSkP>; Sun, 22 Dec 2002 13:40:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3334 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265132AbSLVSkP>; Sun, 22 Dec 2002 13:40:15 -0500
Date: Sun, 22 Dec 2002 10:49:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <m3el8awbtj.fsf@lugabout.jhcloos.org>
Message-ID: <Pine.LNX.4.44.0212221047570.2587-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Dec 2002, James H. Cloos Jr. wrote:
>
> I presume *%gs:0x18 is only for shared objects?

No, it's for everything, but it requires a glibc that has set it up.

Uli, do you make public snapshots available so that people can test the
new libraries and maybe see system-wide performance issues?

(It would also be good for testing - I've tried to be _very_ careful
inside the kernel, but in the end wide testing is always a good idea)

		Linus

