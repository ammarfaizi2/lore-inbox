Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131648AbQKUW5Q>; Tue, 21 Nov 2000 17:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131666AbQKUW5G>; Tue, 21 Nov 2000 17:57:06 -0500
Received: from [209.143.110.29] ([209.143.110.29]:26121 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S131648AbQKUW47>; Tue, 21 Nov 2000 17:56:59 -0500
Message-ID: <3A1AF6AC.F7208DC@the-rileys.net>
Date: Tue, 21 Nov 2000 17:27:05 -0500
From: David Riley <oscar@the-rileys.net>
X-Mailer: Mozilla 4.74 (Macintosh; U; PPC)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Jeff Epler <jepler@inetnebr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Defective Red Hat Distribution poorly represents Linux
In-Reply-To: <200011202032.eAKKWQi06469@pincoya.inf.utfsm.cl> <3A1AE442.E8C83873@the-rileys.net> <20001121155027.I7090@inetnebr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Epler wrote:
> 
> On Tue, Nov 21, 2000 at 04:08:26PM -0500, David Riley wrote:
> > Windoze is not the only OS to handle bad hardware better than Linux.  On
> > my Mac, I had a bad DIMM that worked fine on the MacOS side, but kept
> > causing random bus-type errors in Linux.  Same as when I accidentally
> > (long story) overclocked the bus on the CPU.  I think that more
> > tolerance for faulty hardware (more than just poorly programmed BIOS or
> > chipsets with known bugs) is something that might be worth looking into.
> 
> And how do you propose to do that?
> 
> For instance, in some other operating systems having the top bit flip
> in a pointer will cause silent use of incorrect data.  On Linux, this
> will cause a signal 11.  Which do you prefer, bad results or an error
> message?
> 
> Can you suggest a specific way in which Linux can react correctly to
> e.g. flipped bits in RAM or cache which cannot be detected at the hardware
> level?  Or maybe tell me how Linux can react correctly when an overclocked
> CPU starts producing incorrect results for right shifts once every few
> thousand instructions?

Hmm... Good point.  That would be hard to do.  On that note, there
should be some prominent note on things like user manuals (though Linux
users shouldn't need *manuals* :-) that notes that common crashes like
signal 11 or "cc: internal failure" messages are generally caused by
hardware problems.  That sort of thing would keep spurious complaints
and error messages from inappropriate boards like this and on newbie
boards where they belong (I'm not saying it was a bad complaint, but
generally questions like "Why does RH 6.2, known to be stable on
thousands of machines, not install of this machine where NT worked
before?" belong on newbie boards and not as a flame of RedHat on the
kernel board).  Unfortunately, most people who get these error messages
don't read the manuals.  Besides, where would you put it in a manual?  I
know that error codes are a great mystery among us on the MacOS (even
those of us that have been using it for 16 years only know that Error 11
is usually hardware and [1|2|3] are software) since they aren't really
clearly and understandably documented in prominent user-land documentation.

By the way, I have no idea how to implement a suggestion like I had. 
That's why I posted here.  If I had a clue how to do that any better
than a useless, inefficient kludge, I would have done it myself and
submitted a patch.  As much as I like the "do it yourself" model of
development here, I think a lot of people might appreciate it if more
experienced coders wouldn't jump down the throats of people who suggest
a feature they can't do themselves yet.  I speak for myself, but I don't
think I'll find a dearth of support for that opinion.

Thanks,
	David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
