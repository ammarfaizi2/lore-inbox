Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262673AbSJBXRQ>; Wed, 2 Oct 2002 19:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262678AbSJBXRP>; Wed, 2 Oct 2002 19:17:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:23776 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262673AbSJBXRP>;
	Wed, 2 Oct 2002 19:17:15 -0400
Date: Wed, 2 Oct 2002 19:22:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lars Marowsky-Bree <lmb@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
In-Reply-To: <20021002231456.GA3000@clusterfs.com>
Message-ID: <Pine.GSO.4.21.0210021922200.13480-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Oct 2002, Andreas Dilger wrote:

> On Oct 02, 2002  23:46 +0100, Alan Cox wrote:
> > Absolutely - taking the core EVMS(say the core code and the bits to do
> > LVM1) and polishing them up to be good clean citizens without code
> > duplication and other weirdness would be a superb start for EVMS as a
> > merge candidate. The rest can follow a piece at a time once the core is
> > right if EVMS is the right path
> 
> I actually see EVMS as the "VFS for disk devices".  It is a very good
> way to at allow dynamic disk device allocation, and could relatively
> easily be modified to use all of the "legacy" disk major devices and
> export only real partitions (one per minor).
> 
> You could have thousands of disks and partitions without the current
> limitations on major/minor device mapping.
> 
> This was one of the things that Linus was pushing for when 2.5 started.

... and you don't need EVMS for that.

