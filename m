Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261981AbREPPZK>; Wed, 16 May 2001 11:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261983AbREPPZA>; Wed, 16 May 2001 11:25:00 -0400
Received: from geos.coastside.net ([207.213.212.4]:15319 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261981AbREPPYv>; Wed, 16 May 2001 11:24:51 -0400
Mime-Version: 1.0
Message-Id: <p05100347b7284bde42c9@[207.213.214.37]>
In-Reply-To: <20010516165708.B2782@suse.cz>
In-Reply-To: <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>,
 <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>
 <p05100330b7277e2beea6@[207.213.214.37]> <3B01E670.E96A2865@uow.edu.au>
 <p0510033db727cdc4a244@[207.213.214.37]> <20010516100204.A1537@suse.cz>
 <p05100344b728409e9e36@[207.213.214.37]> <20010516165708.B2782@suse.cz>
Date: Wed, 16 May 2001 08:24:24 -0700
To: Vojtech Pavlik <vojtech@suse.cz>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: LANANA: To Pending Device Number Registrants
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 4:57 PM +0200 2001-05-16, Vojtech Pavlik wrote:
>On Wed, May 16, 2001 at 07:37:45AM -0700, Jonathan Lundell wrote:
>>  At 10:02 AM +0200 2001-05-16, Vojtech Pavlik wrote:
>>  >  > It's also  true that some buses simply don't yield up physical
>>  >>  locations (ISA springs to mind,
>>  >
>>  >ISA is quite fine, you can use the i/o space as physical locations.
>>
>>  I meant physical not as in physical-vs-virtual addresses (all ISA
>>  addresses, memory or IO, are physical in this sense, by the time they
>>  get to the bus). Rather, I meant that you can't determine which slot
>>  a given device is plugged into. If you have two NICs in two ISA
>>  slots, there's no way to distinguish between the slots. In practice,
>>  you'd have to experiment or remove a card and check the jumpering or
>>  some such.
>
>Yes. But I meant that while this indeed is not possible, still the i/o
>port address can be used instead of the slot number, because it at least
>is physically jumpered and must be unique.

Yes, I agree. And it's stable (whereas "physical" PCI addresses are 
not). Best we've got for ISA (though it's true for ISA memory 
addresses as well).

-- 
/Jonathan Lundell.
