Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbTAEEef>; Sat, 4 Jan 2003 23:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbTAEEef>; Sat, 4 Jan 2003 23:34:35 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:23817
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262808AbTAEEed>; Sat, 4 Jan 2003 23:34:33 -0500
Date: Sat, 4 Jan 2003 20:41:56 -0800 (PST)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Andrew Morton <akpm@digeo.com>
cc: Rik van Riel <riel@conectiva.com.br>, Richard Stallman <rms@gnu.org>,
       andrew@indranet.co.nz, linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
In-Reply-To: <3E179CCF.F4CAE1E5@digeo.com>
Message-ID: <Pine.LNX.4.10.10301041901530.421-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew et al.,

Now this is a point of responsible policy making, and your previous
position to characterize me as somebody who solely wants to rip off and
use the work of our peers was unwarrented!  Have a glass of milk to help
the crow, trust me it works.

Now the question before developers of "Linux", and not the FSF, GNU
Project, so Richard it has been fun but we shall let you go do what you do
best for now.

Granting special rights to developers is not acceptable, nor would I even
assume or expect to be above the rules.

Grandfathering our design mistakes, and giving notice now that 2.6/3.0
shall have explicit rules and provisions for binary only seems
reasonable.  It would allow time for everyone to get their house in order.
Additionally the developers should not impose restrictions or willfully
change the the current exported_symbols of today for 2.6/3.0 to provide
backwards compatability for another development cycle.

If the kernel developers force out all current binary only vendors of
today now, the ramp up and recovery time to support our current shortages
is incredible and steep.

I will have to take a calculated risk of exposure and trust our peers are
reasonable and will not seek to destroy one another.

Just to let you all in on the scope of the project, I am hoping to empower
all the folks who have shipped and promoted Linux on the hardware side.
Yeah, I mean all the white box builders who are having it as rough as
everyone else.  The big storage vendors are users-keepers of all of our
hard work.  iSCSI is the first time Enterprise storage is not controlled
by the few and the powerful who are basically untouchable.

I have a goal and a vision to enable Linux to dominate the Enterprise
Storage arena and do it in a cost effective manner.  The time is now as
the hardware vendors who will only ship binary modules and look to other
architects to embed the protocol.

If you are against this idea of bringing enterprise storage to the masses,
under Linux, I will be forced to migrate the most valuable piece of IP to
another platform.  To give each of you an idea how much work is involved
to achieve interoperability ...

http://www.PyXTechnologies.com/target.html

This is a snapshot of MicroSoft NT4+SP6 running on a Dell Beetle Box.
The initiator is the IBM v8 1.2.2 windows initiator.
The target is PyX-Target using 3ware 8500-8 SATA with 6 Maxtor 160/5400.
The benchmark is Intel's IOmeter.
I have no control of the initiator environment :-/

The image break down goes as the following.

                        Random Access | Sequential Access
                        ---------------------------------
 67% read,  33% write  | 112 MB/sec   | 112 MB/sec
  0% read, 100% write  |  69 MB/sec   |  69 MB/sec
100% read,   0% write  | 180 MB/sec   | 171 MB/sec

I can make this an absolute win for Linux from my side.

The strenght of Dave Miller and Jeff Garzik on the netork stack for TOE's.
The vision of Jens Axboe to deploy BIO successfully.
The stomachs of James Bottomley and Douglas Gilbert to fix SCSI.
The insanity of Rik van Riel, Andrea Arcangeli, yourself for MM.
The new RAID 6 by H. Peter Anvin.
Plus the MD/LVM gang.
With grit of Alex Viro to keep us all straight!

It takes all of us, all of you, and more to make Linux the the absolute
winner take all in the future of enterprise storage.

---------

I am either in or out, but I will not risk loosing the ability to recover
all of my development costs and fill the bank account first before I give
it up and grab the next generation of storage technology roller coaster in
another three years.  There are three levels of Error Recovery, and one
released a year is reasonable to me.  That implies, I could publish ERL=0
today before I have recovered a DIME, with 18 months in the hole now.

Again all I want to know is where the threshold of fair usage lays.

This posting made by Linus to the gnu.misc.discuss newsgroup (Message-ID
"4b0rbb$5iu@klaava.helsinki.fi") on December 17, 1995 where he
basically gave his permission for the EXPORT_SYMBOL
vs. EXPORT_SYMBOL_GPL system hereby proprietary modules that call only
EXPORT_SYMBOL symbols are allowed:

http://groups.google.com/groups?as_umsgid=4b0rbb%245iu%40klaava.helsinki.fi

Until there is some type of agreement ratified by all of us, this is a
safe position for setting and holding a precedence.  If any one of the
copyright holders in the kernel wishes to formally object, please do so
now.  If you are not one of these people I would ask you to hold your
comments, because FSF has "released" responsiblity of enforcement to them.
Please respect my request.

Regards,

Andre Hedrick, CTO & Founder
iSCSI Software Solutions Provider
http://www.PyXTechnologies.com/


On Sat, 4 Jan 2003, Andrew Morton wrote:

> Andre Hedrick wrote:
> > 
> > Rik and Richard,
> > 
> > As you see, I in good faith prior to this holy war, had initiated a formal
> > request include a new protocol into the Linux kernel prior to the freeze.
> > The extention was requested to insure the product was of the highest
> > quality and not limited with excessive erratium as the ratification of the
> > IETF modified, postponed, and delayed ; regardless of reason.
> > 
> > Obviously, PyX had (has) on its schedule to product a high quality target
> > which is transport independent on each side of the protocol.  We are not
> > sure of this position because of the uncertain nature of the basic usages
> > of headers and export_symbols.
> > 
> 
> I suggest that if a function happens to be implemented as an inline
> in a header then it should be treated (for licensing purposes) as
> an exported-to-all-modules symbol.  So in Linux, that would be LGPL-ish.
> 
> The fact that a piece of kernel functionality happens to be inlined
> is a pure technical detail of linkage.
> 
> If there really is inlined functionality which we do not wish made
> available to non-GPL modules then it should be either uninlined and
> not exported or it should be wrapped in #ifdef GPL.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 




