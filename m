Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316832AbSFVSXQ>; Sat, 22 Jun 2002 14:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSFVSXQ>; Sat, 22 Jun 2002 14:23:16 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:6086 "EHLO
	pimout4-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S316832AbSFVSXP>; Sat, 22 Jun 2002 14:23:15 -0400
Message-Id: <200206221823.g5MIMuO327686@pimout4-int.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux, the microkernel (was Re: latest linus-2.5 BK broken)
Date: Sat, 22 Jun 2002 08:24:35 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
References: <E17LmrQ-0002vp-00@the-village.bc.nu>
In-Reply-To: <E17LmrQ-0002vp-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 June 2002 11:31 am, Alan Cox wrote:
> > A microkernel design was actually made to work once, with good
> > performance. It was about fifteen years ago, in the amiga.  Know how they
> > pulled it off? Commodore used a mutant ultra-cheap 68030 that had -NO-
> > memory management unit.
>
> Vanilla 68000 actually. And it never worked well - the UI folks had
> to use a library not threads. The fs performance sucked

I dug through my notes a bit, and the interview I was thinking (with one of 
the designers before he died, Jay Minor I think) said that when they did 
upgrade to the 68030 (long after the A1000), they specifically comissioned an 
MMU-less version (68EC030), and that if they'd had to deal with an MMU in the 
first place he doubted they could ever have gotten a microkernel architecture 
to work.

Unfortunately, all I have from said interview at the moment are the notes I 
took.  My first year of computer history research was a learning experience 
about how to do research, back before I learned to store the URL the notes 
came from with the notes (no, the fact it's in my bookmarks list doesn't mean 
I can find it again), and to save pages to my hard drive becaue the links 
have been known to go away over time... :)

On a side note, it's fun looking through the tanenbaum-torvalds debate 
archive and see all the people holding up the amiga as an example of a 
successful microkernel with decent performance, and note the lack of MMU...

Rob
