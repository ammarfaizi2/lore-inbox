Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286108AbRLJAVX>; Sun, 9 Dec 2001 19:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286111AbRLJAVO>; Sun, 9 Dec 2001 19:21:14 -0500
Received: from [144.137.81.66] ([144.137.81.66]:20618 "EHLO wagner")
	by vger.kernel.org with ESMTP id <S286108AbRLJAVI>;
	Sun, 9 Dec 2001 19:21:08 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: anton@samba.org, davej@suse.de, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Linux 2.4.17-pre5 
In-Reply-To: Your message of "Sun, 09 Dec 2001 16:16:21 -0000."
             <E16D6cn-00071w-00@the-village.bc.nu> 
Date: Mon, 10 Dec 2001 11:21:29 +1100
Message-Id: <E16DECH-0001bM-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E16D6cn-00071w-00@the-village.bc.nu> you write:
> Its not voodoo optimisation, its benchmarked work from Intel.

At the very least, please pass this paraphrase on to the Intel people.
I asserted:

	If you number each CPU so its two IDs are smp_num_cpus()/2
	apart, you will NOT need to put some crappy hack in the
	scheduler to pack your CPUs correctly.

> Perhaps you'd like to submit your PPC64 HT patches to the list today
> so that they can be tried comparitively on the Intel HT and we can see if
> its a better generic solution ?

I apologize: clearly my previous post was far too long, as you
obviously did not read it.  There is no sched.c patch.

> For 2.5 the scheduler needs a rewrite anyway so its a non issue there.

Disagree.  Without widespread understanding of how the simple
scheduler works, writing a more complex one is doomed.

The Intel people, whom you assure me "know what their chip needs"
obviously have trouble understanding the subtleties of the current
scheduler.  What hope the rest of us?

Rusty.
PS.  Alan, go back and READ what my analysis, or this will be a VERY
     long thread.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
