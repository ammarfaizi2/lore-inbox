Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbUJZV1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbUJZV1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbUJZV1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:27:19 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:27911 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261482AbUJZVZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:25:47 -0400
Message-ID: <417EC3EE.2090905@techsource.com>
Date: Tue, 26 Oct 2004 17:38:54 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Lars Roland <lroland@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <4ad99e05041025093856cd16ba@mail.gmail.com> <417D32F0.20100@techsource.com> <20041026210243.GA27123@hh.idb.hist.no>
In-Reply-To: <20041026210243.GA27123@hh.idb.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Helge Hafting wrote:
> On Mon, Oct 25, 2004 at 01:08:00PM -0400, Timothy Miller wrote:
> 
>>
>>Lars Roland wrote:
>>
>>
>>>For my own part I can tell you, that a dual head dvi card is high on
>>>my wish list (if it can run 1200*1600 on each head), if you can make
>>>one with Linux support, then I would be happy to pay 200-300$ for it,
>>>even if it did not have the best 3D support (just enough power for
>>>future xorg/enlightenment effect and I am happy).
>>>
>>>
>>
>>I expect that we will offer a multi-head model.
> 
> 
> Great!
> 
> Will this be a card with two pci id's, and two
> fully independent graphichs accelerators?

Maybe.  Or maybe two independent graphics contexts in the same chip, or 
any number of other solutions.

This isn't a serious technical hurdle.  If nothing else, we can stick a 
bridge between two chips and the bus.

> 
> That is necessary for two-user setups.  A single-user
> setup with xinerama use a single xserver process that
> can deal with hardware dependencies.  A two-user
> setup use two xserver processes that doesn��'t cooperate
> at all.  One basically doesn�'t know that the other exists,
> so it cannot know what register the other process messes
> with and so on.  A dual processor machine might even
> mean that both servers runs simultaneosuly - so
> there cannot be dependencies.  Also, an xserver likes
> to reserve a pci ID for itself, so life gets much
> easier if the card has two pci ids - i.e. two
> graphichs cards on a single circuit board.
> 
> Of course I am willing to pay twice the single-card
> price for such a card that has two of every chip
> (except for the shared bus interface circuits).

The economics are much more complex than that, although I don't really 
understand them well.  What you're asking for is a niche product and is 
subject to niche pricing.  It will sell for what the market will bear.

Products like this may have to have a higher profit margin, in order to 
make up for slimmer margins on more commodity products.  But don't quote 
me because I'm officially clueless on this topic.  :)

> I hope such a design won't be too much extra work,
> basically you design the single-card accelerator FPGA
> and other supporting chips
> and stuff two of everything on the same PCB.
> 
> Note that this  "double" card improves performance for
> the more common case of one user with two screens too. :-)

Quite true.  :)

