Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261905AbSJIRyn>; Wed, 9 Oct 2002 13:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSJIRym>; Wed, 9 Oct 2002 13:54:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:8889 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261905AbSJIRyZ>;
	Wed, 9 Oct 2002 13:54:25 -0400
Date: Wed, 9 Oct 2002 14:00:05 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210091050330.7355-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0210091358100.8980-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Oct 2002, Linus Torvalds wrote:

> 
> On Wed, 9 Oct 2002, Alexander Viro wrote:
> > 
> > Sorry, no.  Which partition is the backing store for this filesystem is
> > question to some filesystem drivers.  Not even every fs driver that
> > happens to use block devices - some of them use more than one (e.g
> > for journal).
> > 
> > IOW, it's not a partition property.
> 
> I didn't say it was a partition. I said it was a _filesystem_ property.  
> And yes, it can be a list of multiple partitions - the same way LVM is a
> list of _multiple_ partitions.
> 
> The point being that a partition is a real entity, and should have a node 
> of its own - so that you can point to it (and "node" may of course be 
> "subdirectory" if you want to have multiple things associated with it). 

OK, call me dense, but what things are associated with partition aside of the
fact that it exists?

