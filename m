Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129074AbQKFQbX>; Mon, 6 Nov 2000 11:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129193AbQKFQbN>; Mon, 6 Nov 2000 11:31:13 -0500
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:47111 "EHLO nyc.rr.com")
	by vger.kernel.org with ESMTP id <S129074AbQKFQay>;
	Mon, 6 Nov 2000 11:30:54 -0500
Date: Mon, 06 Nov 2000 11:30:54 -0500
From: Brad Corsello <bcorsello@usa.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel oops on boot in 2.4.0 test10
Reply-To: bcorsello@usa.net
X-Mailer: Spruce 0.7.4 for X11 w/smtpio 0.8.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <0676250391606b0NYCSMTP1@nyc.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> >> Trace; c0194d36 <isapnp_proc_attach_device+36/94>
> 
> >Do you have any ISAPNP cards in your system?
> 
> Yes, a Soundblaster AWE64 that has never given me any problems.  I tried
> booting
> test10 and test1 with that card pulled, and they both still oopsed on boot.
> 
> 

Jeff, I recompiled test10 with all kernel ISA PNP options disabled, and it
successfully
booted.  But I also upgraded binutils to ver 2.10, (which I know is bad for
for bug
hunting, but I wanted to get this system up ASAP).  So I guess the conclusion
to draw is that there *may* be a bug in the kernel ISA PNP code.  In any
event, this no longer appears to be a problem for me (assuming I get the user
PNP stuff to work), and no one else has reported this problem (that I am aware
of).  Many thanks for your insights.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
