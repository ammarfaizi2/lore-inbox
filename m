Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315893AbSEZKIX>; Sun, 26 May 2002 06:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315924AbSEZKIW>; Sun, 26 May 2002 06:08:22 -0400
Received: from [80.120.128.82] ([80.120.128.82]:19716 "EHLO hofr.at")
	by vger.kernel.org with ESMTP id <S315893AbSEZKIV>;
	Sun, 26 May 2002 06:08:21 -0400
From: Der Herr Hofrat <der.herr@mail.hofr.at>
Message-Id: <200205260913.g4Q9DPT20434@hofr.at>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]y
In-Reply-To: <20020525204542.A10392@stm.lbl.gov> from David Schleef at "May 25,
 2002 08:45:42 pm"
To: David Schleef <ds@schleef.org>
Date: Sun, 26 May 2002 11:13:25 +0200 (CEST)
CC: Larry McVoy <lm@work.bitmover.com>, Karim Yaghmour <karim@opersys.com>,
        Larry McVoy <lm@bitmover.com>, Wolfgang Denk <wd@denx.de>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > > There was one more match that was publicly claimed as copying by
> > > the maintainer of RTLinux -- a few fields in the scheduler structure.
> > > The script caught those, too, once I set the threshhold down to 3
> > > lines, which also picked up hundreds of mismatches.  
> > 
> > Good luck making that stick in court.  First of all, the RTAI guys have
> > admitted over and over that RTAI is a fork of the RTLinux source base.
> 
> Paolo (the maintainer) hasn't.  I (the second largest contributor)
> hasn't.  I understand why others talk about RTAI and RTLinux forking,
> since the _projects_ forked, and the _ideas_ forked, but the _code_
> was always separate.  At some point, a person gives up trying to
> argue the point, and just says "it forked".  But when you get down
> to brass tacks, there was no code fork, because there was never one
> code base.
> 
> There was some sharing of code in the beginning, typically code that
> was sent to the RTLinux mailing list by third parties.  In that case,
> the code was copyrighted by the individual.  The fact that it later
> showed up in RTLinux as "copyright VJY associates" does not change
> the fact that Paolo got it from the original author.
>

david - you know the code.

rtai-24.1.6a/fifo/rtai_fifos.c:line 25-31:

*/ 
ACKNOWLEDGEMENT NOTE: besides naming conventions and the idea of a fifo handler
function, the only remaining code from RTL original fifos, as written and 
copyrighted by Michael Barabanov, should be the function "check_blocked" 
(modified to suite my style). However I like to remark that I owe to that code 
my first understanding of Linux devices drivers (Paolo Mantegazza).
/*

in rtai-1.6:oldfifos/rtai_fifos.c:line 1-9:

/*          Modification of RTL-FIFO devices by Paolo Mantegazza            */
/* The original RTL_FIFOS are developped and copyrighted by Michael         */
/* Barabanov, 1997, who derived them from fs/pipe.c in Linux, which is in   */
/* turn copyrighted with "Copyright (C) 1991, 1992 Linus Torvalds".         */
/* This modified version is for use with the RTAI module. It works in the   */
/* same way as its original counterpart, but now you can chose either a     */
/* task queue for bottom halves or an immediate wake up, plus assigning a   */
/* static user buffer.                                                      */
/* See functions: rtf_create_using_bh and rtf_create_using_bh_and_usr_buf.  */


In my opinion it is obvious that the RT comunity that was RTLinux and RTAI for
quite a while was "stealing" ideas and code from each other - and that is a 
very good thing to happen in GPL'ed environments, there was for a long time 
one mailing list and that was being shared in a productive manner by both
groups. The fact that the two groups splitt up and are fighting each 
other is what is really hurting both sides a lot and probably also hurting 
Linux in the market that has interest in hard-realtime. 

hofrat
