Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261972AbREPO5k>; Wed, 16 May 2001 10:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261974AbREPO5a>; Wed, 16 May 2001 10:57:30 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:40076 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S261972AbREPO5T>;
	Wed, 16 May 2001 10:57:19 -0400
Date: Wed, 16 May 2001 16:57:08 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010516165708.B2782@suse.cz>
In-Reply-To: <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>, <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com> <p05100330b7277e2beea6@[207.213.214.37]> <3B01E670.E96A2865@uow.edu.au> <p0510033db727cdc4a244@[207.213.214.37]> <20010516100204.A1537@suse.cz> <p05100344b728409e9e36@[207.213.214.37]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p05100344b728409e9e36@[207.213.214.37]>; from jlundell@pobox.com on Wed, May 16, 2001 at 07:37:45AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 07:37:45AM -0700, Jonathan Lundell wrote:
> At 10:02 AM +0200 2001-05-16, Vojtech Pavlik wrote:
> >  > It's also  true that some buses simply don't yield up physical
> >>  locations (ISA springs to mind,
> >
> >ISA is quite fine, you can use the i/o space as physical locations.
> 
> I meant physical not as in physical-vs-virtual addresses (all ISA 
> addresses, memory or IO, are physical in this sense, by the time they 
> get to the bus). Rather, I meant that you can't determine which slot 
> a given device is plugged into. If you have two NICs in two ISA 
> slots, there's no way to distinguish between the slots. In practice, 
> you'd have to experiment or remove a card and check the jumpering or 
> some such.

Yes. But I meant that while this indeed is not possible, still the i/o
port address can be used instead of the slot number, because it at least
is physically jumpered and must be unique.

-- 
Vojtech Pavlik
SuSE Labs
