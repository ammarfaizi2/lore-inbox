Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbTBPXit>; Sun, 16 Feb 2003 18:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbTBPXit>; Sun, 16 Feb 2003 18:38:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50948 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265361AbTBPXit>; Sun, 16 Feb 2003 18:38:49 -0500
Date: Sun, 16 Feb 2003 15:44:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Jacobowitz <dan@debian.org>
cc: Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Signal/gdb oddity in 2.5.61
In-Reply-To: <20030216232751.GA7687@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0302161544230.3917-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Feb 2003, Daniel Jacobowitz wrote:
> 
> I've also got a conceptual issue with your change.  Continuing a
> process normally overrides a pending stop.  Why shouldn't this be true
> with ptrace too?  It used to be - not in the POSIX sense, since we
> wouldn't override things like SIGTSTP, but the point holds.

I do agree. It seems that the old behaviour was more logical than the new 
one is. 

		Linus

