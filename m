Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbTDKS6A (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 14:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbTDKS6A (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 14:58:00 -0400
Received: from windsormachine.com ([206.48.122.28]:39184 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S261454AbTDKS57 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 14:57:59 -0400
Date: Fri, 11 Apr 2003 15:09:35 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: John Bradford <john@grabjohn.com>
cc: <linux-kernel@vger.kernel.org>,
       <linux-hotplug-devel@lists.sourceforge.net>,
       <message-bus-list@redhat.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
In-Reply-To: <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.33.0304111418320.14943-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Apr 2003, John Bradford wrote:

> [Puzzle]
>
> Say the power supply had five 5.25" drive power connecters, how many 1
> into 3 power cable splitters would you need to connect all 4000 disks?

never seen a 3 into 1, but we'll play along.

every 3 in 1 connector you use, triples your connections, go two
levels deep, it's 3 * 3 = 9, pretty obvious.

I'm just going to use one connector off the power supply for now.

3 ^ 7 = 2187

So we'll use another two off the PS and not go as deep

2 * (3 ^ 6) = 1458

2187 + 1458 = 3645

Need another 4000 - 3645 = 355

3 ^ 5 = 243.

Need another 355 - 243 = 112

Use another connector

3 ^ 4 = 81

Need another 112 - 81 = 31.  So close but out of first level connectors.

So I put a 3 way splitter on one of those.

3 ^ 3 = 27.  argh!

Need another 31+1(had to use up a connector) - 27 = 5.
So I put another 3 way splitter. 5 + 1 = 6.

3 ^ 1 = 3.  Need another three.  Take one off, pass it around, and we're
almost done.  Add another 3 way splitter, we've got two connectors left
over, and everything is plugged in.  Turn on the ps.  Boom, done.

Now, to count up the total.

level 1 = 1	    = 1
level 2 = 1 + 3	    =  4
Level 3 = 4 + 9     = 13
Level 4 = 13 + 27   = 40
Level 5 = 40 + 81   = 121
Level 6 = 121 + 243 = 324
Level 7 = 324 + 729 = 1053

So anyways, I used one level 7, two level 6's, one level 5, one level 4,
one level 1, one level 3, one level 1, another level 1 and finally another
level 1

total of 1053 + 324 + 324 + 121 + 40 + 1 + 13 + 1 + 1 + 1

I come up with 1879.

If i'm too high, that's to account for the fact you broke some connectors
at some point, so you used the spares.

If i'm too low, that's to account for the fact that out of 4000 drives, a
few are going to be DOA and you couldn't hook them up anyways.

Someone PLEASE tell me the simpler way to do this.

Mike

