Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264112AbTKJUN7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 15:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbTKJUN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 15:13:58 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:4 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264112AbTKJUN4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 15:13:56 -0500
Date: Mon, 10 Nov 2003 15:03:10 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <Pine.LNX.4.44.0311101118490.31529-100000@home.osdl.org>
Message-ID: <Pine.LNX.3.96.1031110142456.6278I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, Linus Torvalds wrote:

> 
> On Mon, 10 Nov 2003, Bill Davidsen wrote:
> > 
> > I take it that if the IDE maintainer and you don't use a device it will
> > not be supported in the future?
> 
> You take it wrong.
> 
> However, I'll spell this out in small words, since you don't seem to be 
> getting it:
> 
> 	open source is not about me and the IDE maintainer doing all the 
> 	work.
> 
> 	Nobody seems to be sending patches either to fix ide-scsi _or_ 
> 	those other devices you claim you're so interested in.
> 
> 	I fixed the IDE CD driver to work. I care. The fact that nobody 
> 	else seems to care about anything else is the final word.

Obviously you count the users for nothing, because someone is sure buying
those ATAPI tape drives, it's just that the people using them aren't
kernel developers. A major difference between Linux and commercial
operating systems, to be sure, no one has a financial motive to fix things
like this, so features which worked in 2.4 remain broken unless someone
cares to fix them.
> 
> Do you get it? It's all about technology. I don't hate you. Really. I'm 
> not here to try to make things difficult for you. But also, I'm not here 
> to be your personal slave, and if you think I am, you're just WRONG and 
> you should just realize that I don't care about what you think.
> 
> > I admit I can't understand why 2.6 supports old NICs and motherboard
> > chipsets which haven't been made in five years, and then deliberately
> > desupports devices which did work and which are available at computer
> > stores and mail order today.
> 
> Those other devices have people MAINTAINING THEM AND CARING!
> 
> What's so horribly hard to understand about this? You're barking up the 
> wrong tree.
> 
> Again, I tell you once more:
> 
>  - for burning IDE CD-ROM's you should use the IDE driver. Not ide-scsi. 
>    End of discussion. It's a supported and _improved_ situation from where 
>    it was in 2.4.x.

That was never the issue. The need for ide-scsi is for other devices which
are useful, and software which assume SCSI.

>  - For all those devices you claim exists, show me the patches. Nobody 
>    broke ide-scsi on purpose - but the fact is that nobody also ever came 
>    forward and _fixed_ it. 

And if they had they would have sent the patches to the maintainer, only
there doesn't seem to be one...
> 
> Get it now? 
> 
> So come back to me when you find somebody who cares enough about the 
> devices you claim exists enough that he actually _does_ something about 
> it. Until then, there's just no point in bothering me. Comprende?

Claim exist? ATAPI tape drives are made by Compaq, Exabyte and Seagate,
capacities 20-200GB/tape, and prices from $150-$650 depending on capacity.
Small businesses use these for backup, because SCSI costs too much and
DVDs aren't large enough. Individuals use them because they have a low
initial cost. Guess kernel developers use something else, or don't do
backups.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

