Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130559AbQJ0V1E>; Fri, 27 Oct 2000 17:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130593AbQJ0V0y>; Fri, 27 Oct 2000 17:26:54 -0400
Received: from mail-out.chello.nl ([213.46.240.7]:36657 "EHLO
	amsmta04-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S130559AbQJ0V0u>; Fri, 27 Oct 2000 17:26:50 -0400
Date: Sat, 28 Oct 2000 00:34:50 +0200 (CEST)
From: Igmar Palsenberg <maillist@chello.nl>
To: jpranevich@lycos-inc.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Big file support in Linux 2.2
In-Reply-To: <85256985.00556CD3.00@SMTPNotes1.ma.lycos.com>
Message-ID: <Pine.LNX.4.21.0010280033490.12608-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello,
> 
> For one of our projects here, we've crashed head first into the 2 gig file size
> limitation in Linux 2.2 kernels. While I know that this has been solved in
> 2.3/2.4, has there been any work to backport this feature into a Linux 2.2
> kernel? I'm looking for a temporary solution until we can move to Linux 2.4
> directly, but obviously not until after it's been "really" released. :)
> 
> Yes, I know this is likely to be relatively unstable. (Probably almost as
> unstable as running a 2.4-pre kernel in production), but at least it would give
> us a start.

Seek for LFS on Freshmeat. Requires a kernel patch, and a glibc
recompile. I'm still having some problems with it, mainly cp -ar giving
some wonderful weard strace results.

> 
> Thanks for your help,
> 
> Joe


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
