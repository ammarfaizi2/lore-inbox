Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285878AbSAGTmJ>; Mon, 7 Jan 2002 14:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285940AbSAGTl7>; Mon, 7 Jan 2002 14:41:59 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:50604 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S285878AbSAGTls>;
	Mon, 7 Jan 2002 14:41:48 -0500
Date: Mon, 7 Jan 2002 14:41:44 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dave Jones <davej@suse.de>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>, Patrick Mochel <mochel@osdl.org>,
        Paul Jakma <paulj@alphyra.ie>, linux-kernel@vger.kernel.org
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <Pine.LNX.4.33.0201072024340.16327-100000@Appserv.suse.de>
Message-ID: <Pine.GSO.4.21.0201071440060.6842-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Jan 2002, Dave Jones wrote:

> On Mon, 7 Jan 2002, Richard Gooch wrote:
> 
> > It still eludes me why a new device FS was developed when devfs
> > already has the mechanisms that are needed.
> 
> For one, driverfs can be made mandatory. Sure we could do the same for
> devfs, but there are probably an army of people who don't want
> a mandatory devfs.

... for another, there's an old saying about doing one thing and doing
it well.  Devfs is _not_ following that.

