Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270009AbRHWTBf>; Thu, 23 Aug 2001 15:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269978AbRHWTBZ>; Thu, 23 Aug 2001 15:01:25 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:26051 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S269971AbRHWTBJ>;
	Thu, 23 Aug 2001 15:01:09 -0400
Date: Thu, 23 Aug 2001 21:01:21 +0200
From: David Weinehall <tao@acc.umu.se>
To: Disconnect <lkml@sigkill.net>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010823210121.E1434@khan.acc.umu.se>
In-Reply-To: <20010822030807.N120@pervalidus> <20010823103620.A6965@kittpeak.ece.umn.edu> <20010823115506.D25051@sigkill.net> <20010823182934Z16190-32383+1035@humbolt.nl.linux.org> <20010823144406.G25051@sigkill.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010823144406.G25051@sigkill.net>; from lkml@sigkill.net on Thu, Aug 23, 2001 at 02:44:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2001 at 02:44:06PM -0400, Disconnect wrote:
> On Thu, 23 Aug 2001, Daniel Phillips did have cause to say:
> > Take a close look at the word "just" in that sentence.  Kernel configuration 
> > is not a trivial task at all and it gets less trivial every time Linux gets 
> > more general.
> 
> I don't disagree. But the point isn't how trivial or non-trivial the task
> of configuring the kernel is, the point is for a lot of people it is the
> ONLY task that they will use python for.  And everyone who builds a kernel
> will have gcc, so thats the 'ideal' dependency.  Second and third most
> likely, a C++ compiler or perl (depending on what you figure the
> installbase of each one is).  Forth, some form of java runtime.  And after
> that is python.  (I'm not advocating using any of the above for kernel
> configuration. But they are more likely to already be installed than
> python is.)
> 
> What this says is that either linux sources are going to grow (and the
> build process get more complex) by whatever the size of the python
> interpreter is, OR some method will be used that doesn't require a
> separate interpreter.
> 
> This is also in agreement with his statement about reducing the dependence
> on external tools, whereas requiring everyone to install python does not.  
> It could either be read as using straight gcc C -or- as including all the
> external tools in buildable form.  I'm betting on the former.

Look, either you implement CML2 in C (it can be done; but I'd wager it
isn't easy), or you pay someone else to do it, _or_ you stop complaining.
Simple as that. If you really can't stand having Python on your machine
(I'll bet it's a perl vs python religious thing... I have both installed),
there's always $EDITOR + .config for you to use. I promise that you won't
have to install any extra libraries/compilers/whatever to use that one.

Read the archives damn it, it's not the first time this kind of
arguing takes place here.

I'll give you another option:

make do with the current set of tools (with all of its errors and
short-comings, which are _numerous_) and maintain a forward-compatible
version. 


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
