Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbTDXCSu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 22:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTDXCSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 22:18:50 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:57865
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S264432AbTDXCSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 22:18:48 -0400
Date: Wed, 23 Apr 2003 19:27:19 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Andrew Morton <akpm@digeo.com>
cc: Andries Brouwer <aebr@win.tue.nl>, B.Zolnierkiewicz@elka.pw.edu.pl,
       alan@lxorguk.ukuu.org.uk, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.67-ac2 direct-IO for IDE taskfile ioctl (0/4)
In-Reply-To: <20030423162041.1b7ee5b3.akpm@digeo.com>
Message-ID: <Pine.LNX.4.10.10304231924430.2033-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does Task Management Command set help?
For those who speak FibreChannel, this has meaning.

I can be used as a means to test the depth of the protocol support for a
family of drives.  This is what www.linuxdiskcert.org was to be about, and
maybe Jens will be able to make it happen.  As I will be transfering the
domain th Jens this summer.

On Wed, 23 Apr 2003, Andrew Morton wrote:

> Andries Brouwer <aebr@win.tue.nl> wrote:
> >
> > On Wed, Apr 23, 2003 at 03:35:00PM -0700, Andrew Morton wrote:
> > 
> > > What is special about the IDE ioctl approach?
> > 
> > Usually one wants to use the standard commands for I/O.
> > But if the purpose is to talk to the drive (set password,
> > set native max, eject, change ZIP drive from big floppy
> > mode to removable disk mode, etc. etc.) then one needs
> > a means to execute IDE commands "by hand".
> 
> Yes, but none of these are performance-critical and they don't involve
> large amnounts of data.  A copy is OK.
> 
> If all the rework against bio_map_user() and friends is needed for other
> reasons then fine.  But it doesn't seem to be needed for the IDE taskfile
> ioctl.
> 

Andre Hedrick
LAD Storage Consulting Group

