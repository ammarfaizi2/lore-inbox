Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261969AbREPOiu>; Wed, 16 May 2001 10:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261970AbREPOij>; Wed, 16 May 2001 10:38:39 -0400
Received: from geos.coastside.net ([207.213.212.4]:54996 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261969AbREPOiY>; Wed, 16 May 2001 10:38:24 -0400
Mime-Version: 1.0
Message-Id: <p05100344b728409e9e36@[207.213.214.37]>
In-Reply-To: <20010516100204.A1537@suse.cz>
In-Reply-To: <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>,
 <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>
 <p05100330b7277e2beea6@[207.213.214.37]> <3B01E670.E96A2865@uow.edu.au>
 <p0510033db727cdc4a244@[207.213.214.37]> <20010516100204.A1537@suse.cz>
Date: Wed, 16 May 2001 07:37:45 -0700
To: Vojtech Pavlik <vojtech@suse.cz>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: LANANA: To Pending Device Number Registrants
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:02 AM +0200 2001-05-16, Vojtech Pavlik wrote:
>  > It's also  true that some buses simply don't yield up physical
>>  locations (ISA springs to mind,
>
>ISA is quite fine, you can use the i/o space as physical locations.

I meant physical not as in physical-vs-virtual addresses (all ISA 
addresses, memory or IO, are physical in this sense, by the time they 
get to the bus). Rather, I meant that you can't determine which slot 
a given device is plugged into. If you have two NICs in two ISA 
slots, there's no way to distinguish between the slots. In practice, 
you'd have to experiment or remove a card and check the jumpering or 
some such.
-- 
/Jonathan Lundell.
