Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269569AbRHQD6V>; Thu, 16 Aug 2001 23:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269589AbRHQD6N>; Thu, 16 Aug 2001 23:58:13 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:6415 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S269569AbRHQD57>;
	Thu, 16 Aug 2001 23:57:59 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200108170358.f7H3wCY36744@saturn.cs.uml.edu>
Subject: Re: installing .01
To: fattymikefx@yahoo.com
Date: Thu, 16 Aug 2001 23:58:12 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010817031904.3DFEF501D7@localhost.localdomain> from "tristan" at Aug 16, 2001 11:19:04 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tristan writes:

> I want to install the linux kernel 0.01 on my 386 machine, and im
> lost on how to do it.

Go up a few versions, to 0.02 maybe, if you have any hopes of
running a compiler on this system. You will need at least 4 MB of
RAM for compiling, since the early kernels didn't support swap.

Minix-386 is a hacked up Minix. Minix is an educational OS for
the 8088 that was just recently made free. There once was a
collection of patches that would add 386 feature support.
So you could get Minix running, patch it, then build Linux.

Try this:

The Minix filesystem can be 64 MB at most. Make a partition for
that, one for swap, and one for a newer Linux distribution.
This pre-Slackware thing would be a good choice:
http://www.ibiblio.org/pub/Linux/distributions/MCC/2.0+/

Um, you really don't want to be building gcc on a 386.
You might have to build intermediate versions, since the
old gcc might not compile with the most recent gcc.
Perhaps you have or can borrow a modern machine for builds.

Finding the extras, like libc and a shell, will be hard.

You might need a boot loader called "shoelace". You should
be able to run this from LILO.


