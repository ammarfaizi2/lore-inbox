Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286184AbSAGT7T>; Mon, 7 Jan 2002 14:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286187AbSAGT7A>; Mon, 7 Jan 2002 14:59:00 -0500
Received: from florence.ie.alphyra.com ([193.120.224.170]:61083 "EHLO
	florence.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S286184AbSAGT6r>; Mon, 7 Jan 2002 14:58:47 -0500
Date: Mon, 7 Jan 2002 19:58:25 +0000 (GMT)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: <paulj@dunlop.dub.ie.alphyra.com>
To: Dave Jones <davej@suse.de>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>, Patrick Mochel <mochel@osdl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <Pine.LNX.4.33.0201072024340.16327-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0201071954050.27372-100000@dunlop.dub.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Dave Jones wrote:

> For one, driverfs can be made mandatory. Sure we could do the same for
> devfs, but there are probably an army of people who don't want
> a mandatory devfs.

but devfs internally is a driver API for registering stuff. it can be
made mandatory without requiring the user-side interface, ie /dev dir,
to be mandatory.

(indeed, i dont mount devfs on /dev).

obviously devfs must also be made to pass Al's goodness-o-meter.  :)

in terms of the kernel interface it'd be daft to have multiple device
registration interfaces.

--paulj

