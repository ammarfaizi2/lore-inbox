Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbTI3PO3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbTI3PO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:14:28 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:14829 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S261592AbTI3POU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:14:20 -0400
Date: Tue, 30 Sep 2003 11:13:57 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Samuel Flory <sflory@rackable.com>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Tyan i7501 Pro (S2721-533) lock-up (e1000?)
In-Reply-To: <3F78E18F.50504@rackable.com>
Message-ID: <Pine.GSO.4.33.0309301059350.13584-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Sep 2003, Samuel Flory wrote:
>> Anyone else seeing similar problems with the i7501 pro?
>
>   We been using a lot of 2721-533 without issues.  Are you certain it's
>networking?  Have you tried a mem tester like memtst86 or ctcs?  Does
>the issue occur with addon cards, or the e100 nic?

And I've used it's 603 cousins as well without issue.  I was thinking
after I sent the message APPro may be using uncertified memory, however,
I don't want to have to pull it back out of the rack to find out.
(Personally, I'd rather build them myself than buy them pre-assembled.)

It works fine until a large volume of traffic is sent at it on the gig
ports.  It works sometimes, and locks up other times.  On rare occasions,
the kernel stops receiving traffic -- the lights are blinking and the chip
counters are still going up, but no traffic is showing up. (ethtool -r
gets us back going.)

It's currently been running for 16 hours.  I made a few changes to BIOS
settings (nothing that should matter.)  One thing I've noticed, even though
Tyan only has ONE BIOS published for the board, both of the boards here
have different versions (between themselves and what tyan is pushing.)

I'm preparing to slam it with 87Mbps of traffic (as fast as I can transmit
without error) and see how long it lasts.

--Ricky

PS: There's a Del 2650 right below it.  There are reports of problems with
the e1000's in that thing.  It's the same chipset as I recall.


