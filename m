Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269937AbRHWSoO>; Thu, 23 Aug 2001 14:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269963AbRHWSoF>; Thu, 23 Aug 2001 14:44:05 -0400
Received: from stanis.onastick.net ([207.96.1.49]:61201 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S269937AbRHWSnv>; Thu, 23 Aug 2001 14:43:51 -0400
Date: Thu, 23 Aug 2001 14:44:06 -0400
From: Disconnect <lkml@sigkill.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010823144406.G25051@sigkill.net>
In-Reply-To: <20010822030807.N120@pervalidus> <20010823103620.A6965@kittpeak.ece.umn.edu> <20010823115506.D25051@sigkill.net> <20010823182934Z16190-32383+1035@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010823182934Z16190-32383+1035@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001, Daniel Phillips did have cause to say:
> Take a close look at the word "just" in that sentence.  Kernel configuration 
> is not a trivial task at all and it gets less trivial every time Linux gets 
> more general.

I don't disagree. But the point isn't how trivial or non-trivial the task
of configuring the kernel is, the point is for a lot of people it is the
ONLY task that they will use python for.  And everyone who builds a kernel
will have gcc, so thats the 'ideal' dependency.  Second and third most
likely, a C++ compiler or perl (depending on what you figure the
installbase of each one is).  Forth, some form of java runtime.  And after
that is python.  (I'm not advocating using any of the above for kernel
configuration. But they are more likely to already be installed than
python is.)

What this says is that either linux sources are going to grow (and the
build process get more complex) by whatever the size of the python
interpreter is, OR some method will be used that doesn't require a
separate interpreter.

This is also in agreement with his statement about reducing the dependence
on external tools, whereas requiring everyone to install python does not.  
It could either be read as using straight gcc C -or- as including all the
external tools in buildable form.  I'm betting on the former.

---
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P- L+++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t
5--- X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
