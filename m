Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310174AbSCKSDY>; Mon, 11 Mar 2002 13:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310325AbSCKSBr>; Mon, 11 Mar 2002 13:01:47 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:59398
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S310317AbSCKSBX>; Mon, 11 Mar 2002 13:01:23 -0500
Date: Mon, 11 Mar 2002 10:00:33 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19
In-Reply-To: <3C8CE34B.4030800@evision-ventures.com>
Message-ID: <Pine.LNX.4.10.10203110945480.10583-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Martin Dalecki wrote:

> OK, so there is no f*cking magic utility from IBM to do suspend
> of MicroDrives under linux through the TASKFILE interface at all
> as you have climed!

It does not need to be there, but since the truth needs to be known.
You got in the way with a cosmetic blowjob to Linus while I was trying to
fix the bottom transport layer.  Since I never got to finish, I left it to
you hands to to finish.  Even after telling Linus about the problem he
still does not get it.

> >>I see no special purpose Win2000 microdrive drivers on IBM.
> >>
> > 
> > No because Microsoft implement the bloody standard in the first place. It
> 
> Hack, then tell me what I'm at?
>
> > works very nicely in MS systems. It works ok in 2.4.18 except with a couple
> > of boxes that don't poke the drive from the APM layer (eg IBM PC110)
> > 
> > 
> >>And I suppose you don't even *own* an IBM MicroDrive. And please
> > If you wish to call me a liar, why not do so directly ?
> 
> If I wished this I would just do. Trust me!

Yep, even you know how many babies were made on the statement "Trust me!".

> >>1. How is Win2000 going to work then?
> >>
> > 
> > Because its standards compliant. It wasnt written by a half clued wannabe
> > who has never read the manuals and can do nothing but call people who have
> > a "liar". And a standards compliant implementation does all the right power
> 
> Andre Hedrick will may kill you... However apparently we agree that
> there is something wrong with the current driver.

Oh I fixed the problem as far as the hardware atomic segment goes, I am
waiting to see if you understand the problem and can fix it.  The real
problem is Linus ... because he can not or will not see the issue.
Nor will he listen to the issue anymore.

> > management commands. Win 98 didnt quite get it right and you'll find one
> > of the updates addresses IDE problems. Ironically fixing the same flush
> > cache and shut down politely problem you plan to break in Linux
> 
> No, the problem *is there* Pavel just attempts to FIX IT and I do
> nothing but supporting him on this. You can hardly claim that
> he hooks the whole up on the wrong place...

Recall Pavel refused my offer of assistance to help him, but that was in a
private mail.

> > For the other reason - they are better written. But a driven can be both
> > well written and correct. Its quite apparently you don't care about "correct".
> 
> Wrong I care. But I still didn't get too this right now.
> 
> > If your design is not rigorously following the standard (plus the usual
> > amount of vendor got it wrong slop) then bad things will occur.
> 
> Trivially right.

Whatever ....

> > I'm not arguing that Andre's code is good, or that it doesn't need
> > some serious redesign. I'm just suggesting it would be a good idea if whoever
> > wrote it new what the hell the were doing, or at least spent the time to
> > understand the ATA documentation and implement it.
> 
> So what the heck. Do you thing it will happen overnight!?
> Just see how much time it took to get the init tables into
> some reasonable shape... and the road is still ahead on the
> simple issue of getting them out of ide-pci.c finally!!!
> There is only one way of cooperation here - sharing even not quite finished but
> not broken code - and I still hold up that this is the case with
> Pavels code.

Lame, could have been fixed w/ a know solution.
The main reason for delaying this feature set was to have an means to
force open spec for most of the hardware in PATA.

> > Now contrary to your claim I do have an ibm microdrive, do you have the
> > ATA specs, have you ever read them ? I really doubt it.
> 
> It wasn't a claim but just a suspiction. So this is cleared.
> But apparently there is no special IBM command using taskfile
> to do magic things to it. So therefore it's still valid:
> your example was indeed a mock-up.

No, mine has there real test base, I goto there Lab people and submit
examples and questions and learn.  I doubt they will listen to you reading
your code base, since you have claimed taskfile is wrong.  It was
developed in concert with IBM.

> For your information: I have read the standard papers and comments
> to them. But the application notes from IBM and actual code
> from different operating systems gives a much better formal
> description of what is needed anyway. Or are you going to claim
> that narrative languaue is more precise then actual C code?

Oh and I only have co-authored the document you are reading and work with
the OEM.  So I am clearly out classed by you.

Regards,

Andre Hedrick
The Second Linux X-IDE guy


