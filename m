Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261825AbTCaUPm>; Mon, 31 Mar 2003 15:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261831AbTCaUPm>; Mon, 31 Mar 2003 15:15:42 -0500
Received: from [213.196.40.44] ([213.196.40.44]:40350 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id <S261825AbTCaUPl>;
	Mon, 31 Mar 2003 15:15:41 -0500
Date: Mon, 31 Mar 2003 21:09:01 +0200 (CEST)
From: Bas Vermeulen <bvermeul@blackstar.nl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 3c59x gives HWaddr FF:FF:...
In-Reply-To: <86y92xh9wt.fsf@trasno.mitica>
Message-ID: <Pine.LNX.4.33.0303312107060.26570-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Mar 2003, Juan Quintela wrote:

> In my experience, that bug is related with acpi.  In a kernel compiled
> without acpi, the card works perfectly, in a kernel compiled with acpi
> it depend on the phase of the moon and similar things :(
> 
> The driver for some reason sets too much 1.  I have one of my machines
> conected using dhcp, and it almost never got the right address the
> first boot (a reset _usually_ fix the problem, not always).  Some
> times, only some bits are set in the mac address, I think that a
> couple of times, I have got a MAC with all FF in the address.  
> 
> Worse still is the fact, that sometimes it is not the MAC address what
> is afected, it is also the vendor ip/product id, that makes that the
> driver is not recognized by the driver module.
> 
> I have tried both, the standard driver and the 3com "official" driver,
> both have that problem.  I already informend Andrew Grover about the
> problem, but he is not sure what is happening.
> 
> Later, Juan "wondering what sane network card's are still on the market".

I've never had too many problems with one of the cheapest around,
a realtek 8139. Not sure if you want to use them in a server, but
in most of my desktops they work great.

Bas Vermeulen

-- 
"God, root, what is difference?" 
	-- Pitr, User Friendly

"God is more forgiving." 
	-- Dave Aronson

