Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157569AbQG2AyD>; Fri, 28 Jul 2000 20:54:03 -0400
Received: by vger.rutgers.edu id <S157565AbQG2AxK>; Fri, 28 Jul 2000 20:53:10 -0400
Received: from lancaster.nexor.co.uk ([193.63.53.1]:57597 "EHLO lancaster.nexor.co.uk") by vger.rutgers.edu with ESMTP id <S157685AbQG2Aur>; Fri, 28 Jul 2000 20:50:47 -0400
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.rutgers.edu, lk@tantalophile.demon.co.uk (Jamie Lokier), drepper@redhat.com (Ulrich Drepper), torvalds@transmeta.com (Linus Torvalds), alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: RLIM_INFINITY inconsistency between archs
In-Reply-To: Your message of "Fri, 28 Jul 2000 14:15:22 BST." <200007281315.OAA30398@flint.arm.linux.org.uk>
Date: Sat, 29 Jul 2000 02:09:30 +0100
From: David Howells <David.Howells@nexor.co.uk>
Message-Id: <20000729005258Z157685-16386+2027@vger.rutgers.edu>
Sender: owner-linux-kernel@vger.rutgers.edu

Russell King writes:
> David Howells writes:
> > Why not /usr/modules or /usr/kernel for the stuff required to compile modules
> > (in other words stuff that the kernel doesn't actually use), for example:
> 
> All these discussions about moving stuff to /usr are forgetting one
> fundamental point in the FHS - /usr is NOT guaranteed to be mounted
> at boot.  In fact, /usr may very well be shared between machines.

You missed my point - put _compile_ time stuff under /usr/whatever and
_runtime_ stuff under /lib/modules or /kernel

David Howells

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
