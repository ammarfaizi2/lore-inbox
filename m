Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130108AbQKQUfJ>; Fri, 17 Nov 2000 15:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQKQUfA>; Fri, 17 Nov 2000 15:35:00 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:16915 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129189AbQKQUet>; Fri, 17 Nov 2000 15:34:49 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: test11-pre6 still very broken
Date: 17 Nov 2000 12:04:22 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8v4306$sga$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0011171935560.1796-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0011171935560.1796-100000@saturn.homenet>
By author:    Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
In newsgroup: linux.dev.kernel
>
> Hi,
> 
> The mysterious lockups in test11-pre5 continue in test11-pre6. It is very
> difficult because the lockups appear to be kdb-specific (and kdb itself
> goes mad) but when there is no kdb there is very little useful information
> one can extract from a dead system...
> 
> I will start removing kernel subsystems, one by one and try to reproduce
> it on as plain kernel as possible (i.e. just io, no networking etc.)
> 
> So, this not-very-useful report just says -- test11-pre6 is extremely
> unstable, a simple "ltrace ls" can cause a lockup. Also, some programs
> work when run normally but coredump (or hang) when run via strace, but
> only sometimes, not always... (no, I don't have faulty memory, I run
> memtest!)
> 

It could be that -test5 and -test6 break some assumption kdb makes.
It has been eminently stable here.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
