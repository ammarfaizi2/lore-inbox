Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130524AbQJ0VHo>; Fri, 27 Oct 2000 17:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130457AbQJ0VHe>; Fri, 27 Oct 2000 17:07:34 -0400
Received: from mail-out.chello.nl ([213.46.240.7]:6177 "EHLO
	amsmta01-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S130519AbQJ0VHR>; Fri, 27 Oct 2000 17:07:17 -0400
Date: Sat, 28 Oct 2000 00:15:16 +0200 (CEST)
From: Igmar Palsenberg <maillist@chello.nl>
To: Ricky Beam <jfbeam@bluetopia.net>
cc: Kernel devel list <linux-kernel@vger.kernel.org>
Subject: Re: syslog() blocks on glibc 2.1.3 with kernel 2.2.x
In-Reply-To: <Pine.LNX.4.04.10010261143060.14708-100000@beaker.bluetopia.net>
Message-ID: <Pine.LNX.4.21.0010280013370.12608-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Sadly, you WILL still lose entries if the system crashes before fs metadata
> has been flushed to disk.  Unless the inode has the correct size stored, the
> crap fsync()ed to disk doesn't make much difference.

Yep. I can't really think of a case where you wouldn't lose data in case
of for example a hard lock.

> (This is amplified by dcache.)

I'm not that familiar with kernel internals..

To bring up that point : Anyone had a good advice on a good OS internals
book ?? I'm gonna read the 2.2.x kernel sources, so I could use a good
background.


	Regards,

		Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
