Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbTI3RoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 13:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTI3RoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 13:44:16 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:48369 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S261656AbTI3RoH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 13:44:07 -0400
Message-ID: <3F79BF3A.90208@rackable.com>
Date: Tue, 30 Sep 2003 10:36:58 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ricky Beam <jfbeam@bluetronic.net>
CC: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Tyan i7501 Pro (S2721-533) lock-up (e1000?)
References: <Pine.GSO.4.33.0309301059350.13584-100000@sweetums.bluetronic.net>
In-Reply-To: <Pine.GSO.4.33.0309301059350.13584-100000@sweetums.bluetronic.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2003 17:44:06.0111 (UTC) FILETIME=[71C6A6F0:01C3877A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky Beam wrote:
> On Mon, 29 Sep 2003, Samuel Flory wrote:
> 
>>>Anyone else seeing similar problems with the i7501 pro?
>>
>>  We been using a lot of 2721-533 without issues.  Are you certain it's
>>networking?  Have you tried a mem tester like memtst86 or ctcs?  Does
>>the issue occur with addon cards, or the e100 nic?
> 
> 
> And I've used it's 603 cousins as well without issue.  I was thinking
> after I sent the message APPro may be using uncertified memory, however,
> I don't want to have to pull it back out of the rack to find out.
> (Personally, I'd rather build them myself than buy them pre-assembled.)
> 
> It works fine until a large volume of traffic is sent at it on the gig
> ports.  It works sometimes, and locks up other times.  On rare occasions,
> the kernel stops receiving traffic -- the lights are blinking and the chip
> counters are still going up, but no traffic is showing up. (ethtool -r
> gets us back going.)

   So what is the difference when you query the interface with ethtool 
in the good vs bad state?  What does the switch think the port is set to 
in the good state vs the bad?  What sort of switch are you using?

> 
> It's currently been running for 16 hours.  I made a few changes to BIOS
> settings (nothing that should matter.)  One thing I've noticed, even though
> Tyan only has ONE BIOS published for the board, both of the boards here
> have different versions (between themselves and what tyan is pushing.)
> 

   Tyan tends to produce custom bios revs for various customer 
requirements, or to fix bugs found by that customer.  It often takes a 
while for these things to hit the main bios.


> I'm preparing to slam it with 87Mbps of traffic (as fast as I can transmit
> without error) and see how long it lasts.


   It's also possible that the mother board is defective in some manner.

> 
> --Ricky
> 
> PS: There's a Del 2650 right below it.  There are reports of problems with
> the e1000's in that thing.  It's the same chipset as I recall.
> 

   I wouldn't know about that;-)


-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

