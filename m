Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTJLQvW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 12:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTJLQvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 12:51:22 -0400
Received: from web13004.mail.yahoo.com ([216.136.174.14]:55148 "HELO
	web13004.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263487AbTJLQvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 12:51:20 -0400
Message-ID: <20031012165119.17264.qmail@web13004.mail.yahoo.com>
Date: Sun, 12 Oct 2003 09:51:19 -0700 (PDT)
From: retu <retu834@yahoo.com>
Subject: Re: 2.7 thoughts: common well-architected object model 
To: Valdis.Kletnieks@vt.edu
Cc: Jamie Lokier <jamie@shareable.org>, Kenn Humborg <kenn@linux.ie>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200310121644.h9CGiUeb011798@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


nobody says that it belongs into the kernel rather
designed by core=kernel folks core-up, that is e.g.
not being a derivative of a set of all-encompassing
classes developed for an application. 

I think the issue is serious and brushing it aside as
being non-kernel at first will come back biting.
What's going on could be described as being cornered. 


--- Valdis.Kletnieks@vt.edu wrote:
> On Sun, 12 Oct 2003 09:04:19 PDT, retu said:
> 
> > What's the solution out of this - a clean, open
> object
> > model designed by the core folks, extensible and
> free
> > of licensing issues - and that in the next months.
>  
> 
> The point that seems to be continually missed is
> that although
> it may be a *fine* concept for userspace, it doesn't
> belong in the
> kernel.  There's a syscall barrier for multiple
> reasons, some technical
> and some political/legal.
> 
> If anything, we collectively DON'T want to go there
> because a clever lawyer
> could argue that doing a "all the way from kernel to
> userspace" object-oriented
> scheme would make essentially all userspace code a
> derived work, since it would
> be so tightly entwined with the kernel
> implementation (basically, you'd be
> subjecting all of userspace to the same "derived
> work" limbo that closed-source
> kernel modules currently live in).  This could
> render totally irrelevant this
> text from /usr/src/linux/COPYING:
> 
>    NOTE! This copyright does *not* cover user
> programs that use kernel
>  services by normal system calls - this is merely
> considered normal use
>  of the kernel, and does *not* fall under the
> heading of "derived work".
>  Also note that the GPL below is copyrighted by the
> Free Software
>  Foundation, but the instance of code that it refers
> to (the Linux
>  kernel) is copyrighted by me and others who
> actually wrote it.
> 
> Yes, this would mean that userspace would be GPL'ed
> as well, and
> you'll never see Oracle on a Linux box again for a
> VERY long time....
> 

> ATTACHMENT part 2 application/pgp-signature 



__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
