Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269460AbTCDSBt>; Tue, 4 Mar 2003 13:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269470AbTCDSBt>; Tue, 4 Mar 2003 13:01:49 -0500
Received: from air-2.osdl.org ([65.172.181.6]:38058 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S269460AbTCDSBs>;
	Tue, 4 Mar 2003 13:01:48 -0500
Date: Tue, 4 Mar 2003 11:48:22 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: <jt@hpl.hp.com>
cc: Dominik Brodowski <linux@brodo.de>, <torvalds@transmeta.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       <mika.penttila@kolumbus.fi>
Subject: Re: [PATCH] pcmcia: get initialization ordering right [Was: [PATCH
 2.5] : i82365 & platform_bus_type]
In-Reply-To: <20030304171640.GA16366@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.33.0303041123210.992-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Mar 2003, Jean Tourrilhes wrote:

> On Tue, Mar 04, 2003 at 08:35:05AM -0600, Patrick Mochel wrote:
> > 
> > This patch is completley untested, but it should work. 
> 
> 	I think you are hitting the nail on the head, various people
> are doing many "obvious" changes all over the place without bothering
> to check them, resulting in non functional code.
> 	That's not the way I want to work, and that's why I won't
> commit the new Wireless Extensions stuff until I can really test it.

Whoa, calm down. 

The patch was meant essentially for Dominik only, so he could verify that
it worked with his new PCMCIA code. The only reason the patch is untested
is because I don't have the hardware in question.

The reason the patch was unwritten in the first place is because, as I
mentioned in the previous email, no one has used this feature. Dominik
followed the usage model exactly, and the feature was simple, and
predefined. That's the only reason it was obvious, and sent in the first
place.

Surely you're sore that your code has required some modifications since
Dominik has started working on PCMCIA, and I'm sure that no harm was
intended. It's had some bumps, but IMO, he's done a great job, and the 
result is a vast improvement. The least you could is give the guy some 
slack, instead of whining about your own inconveniences. 

Thanks,

	-pat

