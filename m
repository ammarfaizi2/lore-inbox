Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136438AbRD3Ccu>; Sun, 29 Apr 2001 22:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136439AbRD3Cck>; Sun, 29 Apr 2001 22:32:40 -0400
Received: from smarty.smart.net ([207.176.80.102]:10764 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S136438AbRD3Cc1>;
	Sun, 29 Apr 2001 22:32:27 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200104300233.WAA26770@smarty.smart.net>
Subject: Re: X15 alpha release: as fast as TUX bu
To: linux-kernel@vger.kernel.org
Date: Sun, 29 Apr 2001 22:33:44 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Gettys
>The "put the time into a magic location in shared memory" goes back, as
>far as I know, to Bob Scheifler or myself for the X Window System,
>sometime
>around 1984 or 1985: we put it into a page of shared memory where we used
>a circular buffer scheme to put input events (keyboard/mice), so that
>we could avoid the read system call overhead to get these events (and
>more importantly, check between each request if there was input to
>process).  I don't think we ever claimed it was novel, just that we did

Perhaps you'd seen an Amiga, and jealousy led to innovation. This is about
when the Amiga came out, IIRC. AmigaDos is based on Tripos from Martin
Richards at Cambridge, which was designed from the ground up to be
"single-user, multi-tasking" in full view of the pre-existing elegance of
UNIX. There is no MMU. One bad app takes the box down, but there are no
seams and things scream when they work. There are some things about the
Amiga UI that I want to go over again some time. My vague recollection is
that devices UI served multiple readers implicitly. The structure of the
code was nice too. Everything in linked lists from address 000004.
Execbase, my old IRC nick :o)

Richards now has a beta port of Tripos to run on Linux called Cintpos.
It's in BCPL of course, which nowadays can compile itself in 8 seconds on
a P450. I had the pleasure of getting a thankyou from mr for noting that
you have to enable shared memory in your Linux kernel to run Cintpos.

Rick Hohensee
www.clienux.com
