Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310199AbSCKQoB>; Mon, 11 Mar 2002 11:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310202AbSCKQnw>; Mon, 11 Mar 2002 11:43:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13067 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310199AbSCKQnj>; Mon, 11 Mar 2002 11:43:39 -0500
Subject: Re: [PATCH] 2.5.6 IDE 19
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Mon, 11 Mar 2002 16:58:49 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3C8CDA0D.7020703@evision-ventures.com> from "Martin Dalecki" at Mar 11, 2002 05:23:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kT8L-00014f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You are claiming this repeatidly. But please just send me the f*cking
> strace and I will beleve you. Or point me at the corresponding docs.

You tell me how to strace the bios for one

> I see no special purpose Win2000 microdrive drivers on IBM.

No because Microsoft implement the bloody standard in the first place. It
works very nicely in MS systems. It works ok in 2.4.18 except with a couple
of boxes that don't poke the drive from the APM layer (eg IBM PC110)

> And I suppose you don't even *own* an IBM MicroDrive. And please

If you wish to call me a liar, why not do so directly ?

> some required functionality by now. Just to satisfy your imagination of how
> broken an implementation of the ATA firmware could be isn't a reaons.
> If you have a damn Micro Drive, then feel free to add the required wakeup code -
> you are all welcome. But please don't implement it as cat jksadfgkjhasdjkf >
> /proc/some/wried/stuff.

I've got a nice working 2.4 system thank you. I don't have time to rewrite
the IDE layer at the moment. The fact that every 2.5 I've tried either
crashed or corrupted my filesystems the moment I did anything load related
with it (eg cerberus) convinces me its not something I have time to even
consider yet.

> > promptly, or on power off. I'd like to see what you plan to do about all
> > the IBM disks you plan to mistreat and give bad blocks that require a 
> > reformat ?
> 
> For gods sake:
> 
> 1. How is Win2000 going to work then?

Because its standards compliant. It wasnt written by a half clued wannabe
who has never read the manuals and can do nothing but call people who have
a "liar". And a standards compliant implementation does all the right power
management commands. Win 98 didnt quite get it right and you'll find one
of the updates addresses IDE problems. Ironically fixing the same flush
cache and shut down politely problem you plan to break in Linux

> 3. Why are *all the other* ATA drivers in different operating systems
> such easy on this matter and generally much simpler leaner and more
> readable then the Linux one?!

For the other reason - they are better written. But a driven can be both
well written and correct. Its quite apparently you don't care about "correct".
If your design is not rigorously following the standard (plus the usual
amount of vendor got it wrong slop) then bad things will occur.

I'm not arguing that Andre's code is good, or that it doesn't need
some serious redesign. I'm just suggesting it would be a good idea if whoever
wrote it new what the hell the were doing, or at least spent the time to
understand the ATA documentation and implement it.

Now contrary to your claim I do have an ibm microdrive, do you have the
ATA specs, have you ever read them ? I really doubt it.

Alan
