Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSEZKTL>; Sun, 26 May 2002 06:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315927AbSEZKTK>; Sun, 26 May 2002 06:19:10 -0400
Received: from codepoet.org ([166.70.14.212]:57560 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S315928AbSEZKTJ>;
	Sun, 26 May 2002 06:19:09 -0400
Date: Sun, 26 May 2002 04:19:10 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Robert Schwebel <robert@schwebel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020526101910.GA23705@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Robert Schwebel <robert@schwebel.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205250152110.15928-100000@hawkeye.luckynet.adm> <Pine.LNX.4.44.0205251015350.6515-100000@home.transmeta.com> <20020526005827.B598@schwebel.de> <20020526004853.GA18679@codepoet.org> <20020526073136.H598@schwebel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun May 26, 2002 at 07:31:36AM +0200, Robert Schwebel wrote:
> On Sat, May 25, 2002 at 06:48:53PM -0600, Erik Andersen wrote:
> > So now we have a full 3D model of the robot, the non-liner model
> > of the robot PID-gain space, the entire (application specific)
> > workcell model, the robot specific forward and inverse kinematics
> > routines, and the entire trajectory planning subsystem.  And of
> > course we now need the real-time IO subsystem to handle are the
> > thousands of this-and-that sensors (think PLC-type behavior).
> > etc, etc, etc.  All this in the kernel?  Nah...
> 
> People are doing this (or at least something similar) in reality these
> days... :-) 

Oh I know they are.  I was doing all of this stuff while in grad
school back in 1996, and later at my first job I was doing this
stuff too.  Had to use LynxOS back then.  Would have been nice if
we could have used Linux...  I was watching RTLinux closely back
then -- long before the patent problem.  :)

> Hopefully, your post shows clearly why there are users out there who don't
> want to make such complex algorithms open source, and I must say I can
> understand them. 

That was the hope.  So people would understand that this isn't
the type of application where you can just squirrel away the
real-time bits in a device driver...  Its got to be the whole
thing,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
