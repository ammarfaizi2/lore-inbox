Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130287AbRARAkJ>; Wed, 17 Jan 2001 19:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131104AbRARAjv>; Wed, 17 Jan 2001 19:39:51 -0500
Received: from pine.parrswood.manchester.sch.uk ([213.205.138.155]:7431 "EHLO
	parrswood.manchester.sch.uk") by vger.kernel.org with ESMTP
	id <S130287AbRARAjf>; Wed, 17 Jan 2001 19:39:35 -0500
Date: Thu, 18 Jan 2001 00:39:31 +0000 (GMT)
From: Tim Fletcher <tim@parrswood.manchester.sch.uk>
To: Andre Hedrick <andre@linux-ide.org>
cc: Vojtech Pavlik <vojtech@suse.cz>, Terrence Martin <tmartin@cal.montage.ca>,
        <linux-kernel@vger.kernel.org>
Subject: Re: File System Corruption with 2.2.18
In-Reply-To: <Pine.LNX.4.10.10101171630000.19441-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.30.0101180035080.28099-100000@pine.parrswood.manchester.sch.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > maybe but why?
> >
> > Because it stores no data, hence the wiping out of it is no problem?
>
> Well that is useless test them because you can not test things completely.

I ment that if the partiton has no persient data on it then the test can
be run (the test wipes all data on the partition out during the test,
right?) with no loss of data on the machine. The partition is still on the
same disk so the test data is valid?

I am thinking that the test is somewhat like badblocks -w or have I got
the wrong end of the stick?

-- 
   Tim Fletcher - Network manager   .~.
                                    /V\      L   I   N   U   X
     nightshade@solanum.net        // \\  >Don't fear the penguin<
tim@parrswood.manchester.sch.uk   /(   )\
 irc: Night-Shade on quakenet      ^^-^^

"I love the way Microsoft follows standards.  In much the
same manner that fish follow migrating caribou."
                                            Paul Tomblin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
