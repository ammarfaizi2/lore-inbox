Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153682-31090>; Thu, 17 Dec 1998 02:12:10 -0500
Received: from tiger.coe.missouri.edu ([128.206.158.20]:11972 "EHLO COE.Missouri.EDU" ident: "IDENT-NONSENSE") by vger.rutgers.edu with ESMTP id <153881-31090>; Thu, 17 Dec 1998 02:10:54 -0500
Date: Thu, 17 Dec 1998 01:49:53 -0600
From: Tymm Twillman <tymm@coe.missouri.edu>
To: carguin@iname.com
cc: linux-kernel@vger.rutgers.edu
Subject: Re: process checkpointing
In-Reply-To: <Pine.LNX.4.05.9812160037170.4534-100000@rincewind.home>
Message-ID: <Pine.SGI.4.02.9812170147380.17079-100000@tiger.coe.missouri.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

Have you looked into libckpt? 

http://www.cs.utk.edu/~plank/papers/USENIX-95W.html

-Tymm

On Wed, 16 Dec 1998 carguin@iname.com wrote:

> On Tue, 15 Dec 1998, Guest wrote:
> 
> > are there any patches to support process checkpointin on x86 ?
> 
> I'm currently working on this, but I have virtually nothing written yet.
> Since you mention it, I'll take this opporunity to seek input from the
> rest of the community.
> 
> Actually, I'm surprised I haven't seen anything from anyone else yet. The
> basic problem (ignoring, for now, things like open files) appears to be
> fairly straightforward. I'm fairly certain I can implementing the dumping
> of the process in just userspace (using ptrace and /proc), and I half
> suspect that the reloading can also be done in userspace.
> 
> Mind you, this is a problem, since I am doing this for my final in a class
> about the Linux kernel. I kinda have to modify the kernel, and I'm not
> sure I really need to.
> 
> Of course, to actually be useful gets more complicated. Even ignoring
> things like IPC it's complicated. You really have to handle pipes, or else
> you have no stdin/stdout. Those are usually considered of some importance
> to programs. And security.... I haven't really thought too hard about it,
> but it seems to me that there are some definite security issues to
> consider here.
> 
> --
> Chris Arguin                 | "...All we had were Zeros and Ones -- And 
> CArguin@iname.com            |  sometimes we didn't even have Ones."
>                              +--------------+	- Dilbert, by Scott Adams
> http://leonardo.sr.unh.edu/arguin/home.html |
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.rutgers.edu
> Please read the FAQ at http://www.tux.org/lkml/
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
