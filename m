Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262094AbTCHQpC>; Sat, 8 Mar 2003 11:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262096AbTCHQpB>; Sat, 8 Mar 2003 11:45:01 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:20745 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262094AbTCHQow>; Sat, 8 Mar 2003 11:44:52 -0500
Date: Sat, 8 Mar 2003 17:55:15 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: David Lang <david.lang@digitalinsight.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
In-Reply-To: <Pine.LNX.4.44.0303071753100.1933-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.44.0303081727460.5042-100000@serv>
References: <Pine.LNX.4.44.0303071753100.1933-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 7 Mar 2003, David Lang wrote:

> > There is still the possibility to support multiple libc implementation, if
> > you don't like dietlibc, you're still free to use klibc.
> 
> along the same lines if you don't like klibc you are free to use or
> implement dietlibc or anything else.

Ok, it seems this requires a larger explanation.
It doesn't matter what you or I like. As long as dietlibc or klibc and 
linux are separate projects, I don't care much about the license. I have 
little problems to contribute to a BSD project, if you look at the m68k 
fpu emulator you will find a dual license. I hope this makes it clear that 
I'm not against the BSD license.

The problem starts as soon as klibc becomes part of the linux kernel, as 
it would give a clear preference to similiar projects as dietlibc. It's 
hard to imagine, that this will not cause any problem. The easiest 
solution would be relicense klibc under a license which is closer to the 
kernel license, but on the other hand meets the requirements the current 
license was choosen for. AFAICS a libgcc like license would do this job, 
but Peter made it very clear, that he does not want a different license, 
although it's unfortunately unclear why, but I have to respect that.

This means now we have to come back to the original problem: what problems 
might occur, if klibc is integrated and distributed with the kernel? Will 
it be possible to use dietlibc? What does that mean for other early 
userspace code, has to be licensed under the klibc license? Can I take 
source from a GPL project and integrate that into klibc?
I think it's important to discuss such questions now, as long as still 
possible without a lawyer, is the module story not warning enough?
My opinion at this point is, as long as Peter avoids to dicuss these 
issues, we should also consider to avoid integrating klibc in the kernel.

bye, Roman

