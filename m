Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132576AbRDAXPx>; Sun, 1 Apr 2001 19:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132577AbRDAXPm>; Sun, 1 Apr 2001 19:15:42 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:64032 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S132576AbRDAXPd>; Sun, 1 Apr 2001 19:15:33 -0400
Date: Sun, 1 Apr 2001 18:14:46 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <200104011754.KAA20725@work.bitmover.com>
Message-ID: <Pine.LNX.3.96.1010401175435.28121g-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2001, Larry McVoy wrote:
> Problem details
>     Bug report quality
[...]
> 	But the main thing was to extract all the info we could
> 	automatically.	One thing was the machine config (hardware and
> 	at least kernel version).  The other thing was extract any oops
> 	messages and get a stack traceback.

Basically look through REPORTING-BUGS for a laundry list of helpful info.

> 	The other main thing was to define some sort of structure to the
> 	bug report and try and get the use to categorize if they could.
> 	In an ideal world, we would use the maintainers file and the
> 	stack traceback to cc the bug to the maintainer.  I think we want
> 	to explore this a bit.	I'm not sure that the maintainer file is
> 	the way to go, what if we divided it up into much broader chunks
> 	like "fs", "vm", "network drivers", and had a mail forwarder
> 	for each area.	That could fan out to the maintainers.

(slight tangent)
One thing people have talked about in the past is updating MAINTAINERS
to actually reflect real life...  some of the active maintainers
don't have maintainer entries.  That may be intentional, maybe not...

For drivers at least, bugs -should- be mailed to the driver
maintainer where possible, which is not always the same as the
subsystem maintainer.


>     Signal/noise
[...]
> 	Jens wants there to be a queue of 

Jes?

> 	new bugs and a mechanism where people can come in the morning, pull
> 	a pile of bugs off of the queue, sort them, sending some to the real
> 	database.  This idea has a lot of merit, it needs some pondering as
> 	DaveM would say, to get to the point that we have a workable mechanism
> 	which works in a distributed fashion.

Back when I was hacking GNOME, various janitors (to use the now-popular
term) would go through and clean the bug database, sorting through a lot
of the noise.

Newbies are finding the Kernel Janitors project as an excellent way to
begin to contribute to the kernel.  There are definitely interested,
smart people willing to help, that at present don't know a lot about the
kernel.  Such volunteers, like the GNOMEs mentioned above, could be a
vast benefit to this particular step of the bug tracking process.  You
http://sourceforge.net/projects/kernel-janitor/    </plug>

> Past experiences
>     This is a catch all for sound bytes that we don't want to forget...
> 
>     - one key observation: let bugs "expire" much like news expires.  If
>       nobody has been whining enough that it gets into the high signal 
>       bug db then it probably isn't real.  We really want a way where no
>       activity means let it expire.

Agreed, with a caveat:  some bugs should stay around but not expire.
There is a class of bugs that shouldn't go away from the "less noise"
bug database when there is no activity.  ie. hard problems we want to
remember, but solve in a later version.


> Requirements

1) An e-mail interface.

For sorting through massive amounts of bugs, NNTP is far more useful.
Maybe as a query interface as well, NNTP is useful.  But for getting
into the nitty-gritty details of handling a bug, e-mail is generally the
primary medium of communication between developer and user.

debian-bugs assigns each bug a unique e-mail address, and all e-mail
that arrives in that mailbox is appended to the bug's comments.

2) Support for binary attachments from users


