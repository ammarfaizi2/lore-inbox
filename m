Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129586AbQKWBEq>; Wed, 22 Nov 2000 20:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129625AbQKWBEg>; Wed, 22 Nov 2000 20:04:36 -0500
Received: from femail8.sdc1.sfba.home.com ([24.0.95.88]:52731 "EHLO
        femail8.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
        id <S129586AbQKWBEZ>; Wed, 22 Nov 2000 20:04:25 -0500
Date: Wed, 22 Nov 2000 17:40:26 -0800 (PST)
From: "Richard.Reynolds" <richard@usa.net>
To: David Riley <oscar@the-rileys.net>
cc: Jeff Epler <jepler@inetnebr.com>, linux-kernel@vger.kernel.org
Subject: Re: Was:Defective Red Hat Distribution poorly represents Linux,
 running with failed hardware?
In-Reply-To: <3A1AF6AC.F7208DC@the-rileys.net>
Message-ID: <Pine.LNX.4.20.0011221726460.28819-100000@cx970979-a>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To change the topic a bit.

Just an interesting thought, I realize that for every pro there is a
con. But what about implimenting in some kind of background "process"(for
lack of a better word right now), and probibly in a duplicate copy 
of the current kernel. Checks on the system memory and redundant
processing of known to be problems, I have not, been keeping up to date on
the kernel but I imagine that there is a map into memory that bad areas
either are or could be blocked as bad. 

While testing this at startup would not seem to be advisable, for many
reasons, including some pc's are not restarted often enough to catch such
errors in time, I think the table could be saved, and reloaded on startup,
there would also be the need to maintain this table, but I dont see that
as being unreasionable.

It only interests me in that I enjoy the stability of my Linux box,
vs. any of my Win98/nt/2k  boxes, and as someone that uses Linux I would
think such a kernel would be of interest in more quasi mission critical
installations. 

Just my 2cents
Richard Reynolds
Richard.Reynolds@usa.net


On Tue, 21 Nov 2000, David Riley wrote:

> Jeff Epler wrote:
> > 
> > On Tue, Nov 21, 2000 at 04:08:26PM -0500, David Riley wrote:
> > > Windoze is not the only OS to handle bad hardware better than Linux.  On
> > > my Mac, I had a bad DIMM that worked fine on the MacOS side, but kept
> > > causing random bus-type errors in Linux.  Same as when I accidentally
> > > (long story) overclocked the bus on the CPU.  I think that more
> > > tolerance for faulty hardware (more than just poorly programmed BIOS or
> > > chipsets with known bugs) is something that might be worth looking into.
> > 
> > And how do you propose to do that?
> > 
> > For instance, in some other operating systems having the top bit flip
> > in a pointer will cause silent use of incorrect data.  On Linux, this
> > will cause a signal 11.  Which do you prefer, bad results or an error
> > message?
> > 
> > Can you suggest a specific way in which Linux can react correctly to
> > e.g. flipped bits in RAM or cache which cannot be detected at the hardware
> > level?  Or maybe tell me how Linux can react correctly when an overclocked
> > CPU starts producing incorrect results for right shifts once every few
> > thousand instructions?
> 
> Hmm... Good point.  That would be hard to do.  On that note, there
> should be some prominent note on things like user manuals (though Linux
> users shouldn't need *manuals* :-) that notes that common crashes like
> signal 11 or "cc: internal failure" messages are generally caused by
> hardware problems.  That sort of thing would keep spurious complaints
> and error messages from inappropriate boards like this and on newbie
> boards where they belong (I'm not saying it was a bad complaint, but
> generally questions like "Why does RH 6.2, known to be stable on
> thousands of machines, not install of this machine where NT worked
> before?" belong on newbie boards and not as a flame of RedHat on the
> kernel board).  Unfortunately, most people who get these error messages
> don't read the manuals.  Besides, where would you put it in a manual?  I
> know that error codes are a great mystery among us on the MacOS (even
> those of us that have been using it for 16 years only know that Error 11
> is usually hardware and [1|2|3] are software) since they aren't really
> clearly and understandably documented in prominent user-land documentation.
> 
> By the way, I have no idea how to implement a suggestion like I had. 
> That's why I posted here.  If I had a clue how to do that any better
> than a useless, inefficient kludge, I would have done it myself and
> submitted a patch.  As much as I like the "do it yourself" model of
> development here, I think a lot of people might appreciate it if more
> experienced coders wouldn't jump down the throats of people who suggest
> a feature they can't do themselves yet.  I speak for myself, but I don't
> think I'll find a dearth of support for that opinion.
> 
> Thanks,
> 	David
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
