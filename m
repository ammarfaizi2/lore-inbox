Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157672AbQGaStk>; Mon, 31 Jul 2000 14:49:40 -0400
Received: by vger.rutgers.edu id <S157620AbQGaSrl>; Mon, 31 Jul 2000 14:47:41 -0400
Received: from [194.25.81.131] ([194.25.81.131]:3835 "EHLO ns.weiden.de") by vger.rutgers.edu with ESMTP id <S160004AbQGaSrJ>; Mon, 31 Jul 2000 14:47:09 -0400
Date: Mon, 31 Jul 2000 22:06:03 +0200 (CEST)
From: Mike Galbraith <mikeg@weiden.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
In-Reply-To: <Pine.LNX.3.95.1000731132321.529A-100000@chaos.analogic.com>
Message-ID: <Pine.Linu.4.10.10007312111270.410-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Mon, 31 Jul 2000, Richard B. Johnson wrote:

> On 31 Jul 2000, Kai Henningsen wrote:
> 
> > pollard@tomcat.admin.navo.hpc.mil (Jesse Pollard)  wrote on 27.07.00 in <200007271531.KAA89926@tomcat.admin.navo.hpc.mil>:
> > 
> > > Might I suggest creating a "/lib/include" that works something like
> > > the /lib/modules where the kernel name is used to generate the directory
> > > for the kernel include files?
> > >
> > > That way the "uname -r" command could be used to set a symbolic link
> > > to point to the correct include files at boot time (or install time).
> > 
> > Correct for what?
> > 

<snip>

> Why would anybody change this? I fear that this is another of those;
> "It doesn't have to be better, only different..." things that have
> been going around.

Well, I suspect that there is an issue for driver authors/maintainers,
but haven't figured out quite what that issue is.  Why does it matter?

I really couldn't care less where headers officially live.. as long as
it's possiblle [preferably easy] to maintain them where _I_ want them.
(and that is nowhere near /)

	-Mike


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
