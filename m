Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283314AbRLILLK>; Sun, 9 Dec 2001 06:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283316AbRLILK7>; Sun, 9 Dec 2001 06:10:59 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:44562 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S283314AbRLILKk>; Sun, 9 Dec 2001 06:10:40 -0500
Date: Sat, 8 Dec 2001 23:38:17 +0100
From: Pavel Machek <pavel@suse.cz>
To: Cory Bell <cory.bell@usa.net>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
        Andrew Grover <andrew.grover@intel.com>,
        John Clemens <john@deater.net>
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Message-ID: <20011208233816.A118@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0112070925280.851-100000@segfault.osdlab.org> <1007760235.10687.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1007760235.10687.0.camel@localhost.localdomain>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Could I get your comments on a patch against 2.4.16-stock? I'm trying to
> figure out the best way to automagically work around the bug, and this
> is the best I've come up with so far. I need more DMI data from other HP
> 5400 series AMD/ALi laptops with the problem to come up with the most
> accurate matches - right now it's tied to my machine type and BIOS
> version.

Yep. Patch looks reasonable.

I have same problem on HP Omnibook xe3, and yes, your previous patch
fixed it (as I wrote you). Here's DMI output

DMI 2.2 present.
29 structures occupying 935 bytes.
DMI table at 0x000DC010.
BIOS Vendor: Phoenix Technologies LTD
BIOS Version:  GD.M1.08
BIOS Release: 09/27/2001
System Vendor: Hewlett-Packard.
Product Name: HP OmniBook PC         .
Version HP OmniBook XE3 GD           .
Serial Number T*********.
Board Vendor: Hewlett-Packard.
Board Name: N/A.
Board Version: OmniBook N32N-736.
Asset Tag: No Asset Tag.

But... my maestro3 still does not work properly. Does yours? Or you
have another soundcard?
								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
