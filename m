Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135699AbRD2Ik4>; Sun, 29 Apr 2001 04:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135700AbRD2Ikq>; Sun, 29 Apr 2001 04:40:46 -0400
Received: from magician.bunzy.net ([206.245.168.220]:19726 "HELO
	magician.bunzy.net") by vger.kernel.org with SMTP
	id <S135699AbRD2Iki>; Sun, 29 Apr 2001 04:40:38 -0400
Date: Sun, 29 Apr 2001 04:40:59 -0400 (EDT)
From: tc lewis <tcl@bunzy.net>
To: Davide Libenzi <davidel@xmailserver.org>
cc: <linux-kernel@vger.kernel.org>
Subject: RE: i2o/dpt/adaptec - SmartRAID V?
In-Reply-To: <XFMail.20010426173340.davidel@xmailserver.org>
Message-ID: <Pine.LNX.4.33L2.0104290436260.4409-100000@magician.bunzy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Apr 2001, Davide Libenzi wrote:
> On 27-Apr-2001 tc lewis wrote:
> >
> > i saw a few messages in the archive about these, but i'm still unclear on
> > the current situation.
> >
> > according to /proc/pci, i'm working with a:
> >   Bus  0, device   9, function  1:
> >     I2O: Distributed Processing Technology SmartRAID V Controller (rev 2).
> >       IRQ 9.
> >       Master Capable.  Latency=64.  Min Gnt=1.Max Lat=1.
> >       Prefetchable 32 bit memory at 0xf8000000 [0xf9ffffff].
> >
> > in the linux-kernel archive there was a recent message from someone noting
> > that the eata driver does not handle this card.  it looks like adaptec has
> > drivers for this for use with certain versions of linux 2.2, but not for
> > linux 2.4.
> >
> > are these cards supported at all in linux 2.4?
> >
> > i think someone mentioned there were licensing issues on including this
> > driver in the kernel tree, but it was available via some other means /
> > someone hacked it up from dpt/adaptec for use with 2.4...can i get more
> > info on this?  much appreciated.
>
> The attached file is what I'm currently using and, as far as I can tell, it
> works fine ( on a 2 way SMP PIII server ).
> The driver developer @adaptec.com told me that a newer version should be issued
> in a few days to be included in the mainstream code.
> This new version should have code fixes requested by Alan.
>

thanks, Davide.  i used the patch you sent with 2.4.3, also on a dual p3
system, and so far it's been working flawlessly as far as i can tell for a
day or two now.

i'll be watching the list for future developments and in case it gets
added to linus' source.  are there any other lists about this driver?
might it be wise to contact adaptec for info/notification on its
progression?

-tcl.


