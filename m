Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275763AbRJBFBt>; Tue, 2 Oct 2001 01:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275765AbRJBFBi>; Tue, 2 Oct 2001 01:01:38 -0400
Received: from femail27.sdc1.sfba.home.com ([24.254.60.17]:11171 "EHLO
	femail27.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S275763AbRJBFBX>; Tue, 2 Oct 2001 01:01:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Mike Fedyk <mfedyk@matchmail.com>,
        Chris Howells <chris@chrishowells.co.uk>
Subject: Re: linux-kernel-announce?
Date: Mon, 1 Oct 2001 21:01:10 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011001164720Z275269-761+14414@vger.kernel.org> <20011001124811.D25387@mikef-linux.matchmail.com>
In-Reply-To: <20011001124811.D25387@mikef-linux.matchmail.com>
MIME-Version: 1.0
Message-Id: <01100121011009.09156@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 October 2001 15:48, Mike Fedyk wrote:
> On Mon, Oct 01, 2001 at 05:47:29PM +0100, Chris Howells wrote:
> > Are there any plans for a low volume list of announcements regarding the
> > Linux kernel? For example, whenever Linus or Alan or whoever releases a
> > kernel, I would find it very useful to be notified of this by e-mail,
> > since I typically wish to run the latest stable Linux kernel that is
> > available.
> >
> > Sure this information is available here on the main list, although I
> > personally do not have the time (or to be honest, the inclanation) to be
> > on this list. As a result of this, I tend not to find out about the
> > latest kernel releases until a day or two later and I notice a story on
> > Slashdot, or stumble on to kernel.org, and see the announcement there.
>
> The problem with that, is that there is usually a reply to the announcement
> that is helpful before you compile it.  Many times there is even a small
> patch (usually for pre or -ac kernels) that fixes some small oversight.
>
> At the moment, if you want to run the latest kernel, you should be reading
> this list.

What people have wanted for a while is a high signal low noise condensed 
new-kernel-news mailing list.  The closest we have right now is the weekly 
linux-kernel digests:kernel traffic at http://kt.zork.net, and the "kernel" 
page of Linux weekly news http://lwn.net.

Now Alan Cox not only does a pretty good job of ac-release logs, but he has a 
diary as well (http://www.linux.org.uk/diary).  I'm unaware of being able to 
get Alan's release announcements as read-only a mailing list, but I suppose 
if somebody suggested the idea to him he might not be too opposed to it.  
Good luck getting through his spam-blocker, though.

A little before the start of the 2.4 series, Linus started doing alan style 
changelogs.  They're often a bit vague ("merge with alan"), but much better 
than nothing.  I floated a proposal a while back to give Linus a better tool 
for this that he might actually use*, but nothing's come of it.  Larry McVoy 
is trying to get a source code repository thing called BitKeeper up to 
Linus's standards, but that's been going on for at least two years and isn't 
ready yet...

The other major emerging fork seems to be Andrea Arcangelli's (the -aa 
patches), but I haven't really been following it seperately.  Andrea is VERY 
good at about splitting patches out seperately on his web page, though.  (I 
don't know it off the top of my head, but Google could find Jimmy Hoffa given 
half a chance, so try that.)

Hopefully 2.5 will be out by the end of 2003, at which point Alan will 
probably inherit 2.4 maintenance.  (Which VM we go with at that point is an 
open question. :)

Rob

* The proposal was to feed Linus a patch application perl script.  The way 
linus applies patches is he saves email he likes to a big file, and then goes 
patch -p1 < thebigfile at the end of an email reading session.  The emails 
themselves generally have some kind of description of the patch, as well as 
the patches themselves seperated out into nice small chunks (Linus insists on 
this).

So what we need really is a mailing list of just the emails Linus applies to 
his tree, with the documentation in them.  That's what the perl script would 
do: break them back into seperate emails and mail them out to an otherwise 
read-only list, in addition to calling patch on Linus's tree.  This would be 
REALLY nice in terms of people who want to keep granular CVS repositories, 
too, and wouldn't be any extra work for Linus...

Does this sound like an idea to anybody else?
