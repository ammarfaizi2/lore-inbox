Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289832AbSBEW4M>; Tue, 5 Feb 2002 17:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289834AbSBEW4C>; Tue, 5 Feb 2002 17:56:02 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:42769
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289832AbSBEWzv>; Tue, 5 Feb 2002 17:55:51 -0500
Date: Tue, 5 Feb 2002 14:46:35 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Patrick Mochel <mochel@osdl.org>, Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
In-Reply-To: <20020205204751.G27706@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10202051445400.6350-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2002, Russell King wrote:

> On Tue, Feb 05, 2002 at 10:43:14AM -0800, Patrick Mochel wrote:
> > I think that ide should get its own bus, as a child of the ide controller. 
> > I haven't looked at ide yet at all. But, on most modern systems, the ide 
> > controller is a function of the southbridge, so ide devices should go 
> > under that. Like what the usb stuff does now...
> 
> What about, say, a Promise PCI IDE card?  You really need to reference
> the parent PCI device when the is one.

LOL, how about ones that are quad-channel with a DEC-Bridge to slip the
local BUSS?

Cheers,


Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

