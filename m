Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268256AbTCBUCU>; Sun, 2 Mar 2003 15:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269251AbTCBUCU>; Sun, 2 Mar 2003 15:02:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39692 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268256AbTCBUCR>;
	Sun, 2 Mar 2003 15:02:17 -0500
Message-ID: <3E6265AB.9090304@pobox.com>
Date: Sun, 02 Mar 2003 15:12:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Arador <diegocg@teleline.es>,
       "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030302014915.34a6de37.diegocg@teleline.es> <1046571336.24903.0.camel@irongate.swansea.linux.org.uk> <3E615C38.7030609@pobox.com> <20030302014039.GC1364@dualathlon.random> <3E616224.6040003@pobox.com> <20030302020907.GE1364@dualathlon.random> <3E623F37.6060005@pobox.com> <20030302181615.GA25902@dualathlon.random>
In-Reply-To: <20030302181615.GA25902@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> your point is purerly theorical at this point in time. bitbucker is so
> far from being an efficient exporter that arguing right now about
> stopping at the exporter or going ahead to clone it completely is a
> totally pointless discussion at this point in time.
> 
> Once it will be a fully functional exporter please raise your point
> again, only then it will make sense to discuss your point.

Ok, fair enough ;)


> I'm not even convinced it will become a full exporter if Larry finally
> provides the kernel data via an open protocol stored in an open format
> as he promised us some week ago, go figure how much I can care what it
> will become after it has the readonly capability.

I think this is a fair request.

IMO a good start would be to get BK to export its metadata for each 
changeset in XML.  Once that is accomplished, (a) nobody gives a damn 
about BK file format, and (b) it is easy to set up an automated, public 
distribution of XML changesets that can be imported into OpenCM, cvs, or 
whatever.


>>Let us get this small point out of the way:  I agree that GNU CSSC 
>>cannot read the BitKeeper ChangeSet file, which is a file critical for 
>>getting the "weave" correct.
> 
> 
> This is not what I understood from your previous email:
> 
> 	"BK format"?  Not really.  Patches have been posted (to lkml, even) to
> 	GNU CSSC which allow it to read SCCS files BK reads and writes.
> 	
> 	Since that already exists, a full BitKeeper clone is IMO a bit silly,
> 
> now you're saying something completely different, you're saying, "yes the
> CSSC obviously isn't enough and we _only_ _need_ the exporter but please
> don't do more than the exporter or it will waste developement
> resources". This is why you changed topic as far as I'm concerned, but
> no problem, I'm glad we agree the exporter is useful now.

I am sorry for the misunderstanding then.  Let me quote from an email I 
sent to you yesterday:

	A BK exporter is useful.

So I think we do agree :)


>>To me, a "BK clone, read only for now" is vastly different from a "BK 
>>exporter".  The "for now" clearly implies that it will eventually 
>>attempt to be a full SCM.
> 
> 
> Why do you care that much now? I can't care less. Period. I need the
> exporter and for me the exporter or the bk-clone-read-only is the same
> thing, I don't mind if I've to run `bk` or `exportbk` or rsync or
> whatever to get the data out.
> 
> If bitbucket will become much better than bitkeeper 100 years from now,
> much better than a clone, is something I can't care less at this point
> in time, and it may be the best or worst thing it will happen to the
> whole SCM open source arena, you can't know, I can't know, nobody can
> know at this point in time.
> 
> You agreed the exporter is useful, so we agree, I don't mind what will
> happen after the useful thing is avaialble, it's the last of my worries,
> and until we reach that point obviously there is no risk to reinvent the
> wheel (unless the data become available in a open protocol first).


Yes.  As you see, I care about the future and not the present, in my 
arguments:  I believe that a BK clone may hurt the overall [future] 
effort of creating a good quality open source SCM.  So, in my mind I 
separate the two topics of "BK exporter" and "future BK clone."


To get back to the topic of "BK exporter", I think it is more productive 
to get Larry to export in an open file format.  I will work with him 
this week to do that.  Reading the BK format itself may be interesting 
to some, but I would rather have BitMover do the work and export in an 
open file format ;-)  Reading BK format directly is "chasing a moving 
target" in my opinion.

	Jeff



