Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270674AbTGUUok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 16:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270688AbTGUUok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 16:44:40 -0400
Received: from ns2.eclipse.net.uk ([212.104.129.133]:45575 "EHLO
	smtp2.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S270674AbTGUUoh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 16:44:37 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: linux-kernel@vger.kernel.org
Subject: Re: how to use "ATAPI:" protocol for IDE CD/RWs??
Date: Mon, 21 Jul 2003 21:59:35 +0100
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.53.0307200606120.17848@localhost.localdomain> <20030720222854.GI26422@fs.tum.de> <20030721144930.GG12516@suse.de>
In-Reply-To: <20030721144930.GG12516@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200307212159.37669.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 Jul 2003 15:49, Jens Axboe wrote:
> On Mon, Jul 21 2003, Adrian Bunk wrote:
> > On Sun, Jul 20, 2003 at 12:26:53PM +0200, Rudo Thomas wrote:
> > > Take a look at
> > > http://www.codemonkey.org.uk/post-halloween-2.5.txt
> > >
> > > Excerpt:
> > >
> > > CD Recording.
> > > ~~~~~~~~~~~~
> > > - Jens Axboe added the ability to use DMA for writing CDs on
> > >   ATAPI devices. Writing CDs should be much faster than it
> > >   was in 2.4, and also less prone to buffer underruns and the like.
> > > - Updated cdrecord in rpm and tar.gz can be found at
> > >   *.kernel.org/pub/linux/kernel/people/axboe/tools/
> > >...
> >
> > @Dave:
> > What about writing "You need cdrecord >= 2.0 for this." instead?
>
> We already cleared this with Joerg some weeks ago, I'm sure the next
> version of the post-halloween document will reflect reality. You need
> 1.11a38 or newer.

However I get this rather unhelpful warning from my installed copy of 
cdrecord.

# cdrecord -prcap dev=/dev/hdc
Cdrecord 2.01a16 (i686-pc-linux-gnu) Copyright (C) 1995-2003 Jörg Schilling
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'

The only other writing programme I'd be interested in at the moment is cdrdao.  
This definitely doesn't like non-SCSI devices, unless there is an updated 
version of this one too that I don't know about.

-- 
Ian.

