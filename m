Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311603AbSCTOq1>; Wed, 20 Mar 2002 09:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311607AbSCTOqR>; Wed, 20 Mar 2002 09:46:17 -0500
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:56015
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S311603AbSCTOp7>; Wed, 20 Mar 2002 09:45:59 -0500
Date: Wed, 20 Mar 2002 09:45:54 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zlib double-free bug
In-Reply-To: <3C985A46.D3C73301@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0203200943230.3615-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Helge Hafting wrote:

> Nicolas Pitre wrote:
> 
> > > Removable media?
> > 
> > Most if not all removable media are not ment to be used with JFFS2.
> 
> Nothing is _meant_ to be exploited either.  Someone could
> create a cdrom with jffs2 (linux don't demand that cd's use iso9660)

But JFFS2 demands to be used with AN MTD device, not a block device.  And
most MTD device, if not all of them, on which JFFS2 is used aren't
removable.


Nicolas

