Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262632AbSJBWJX>; Wed, 2 Oct 2002 18:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262635AbSJBWJX>; Wed, 2 Oct 2002 18:09:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52160 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262632AbSJBWJV>;
	Wed, 2 Oct 2002 18:09:21 -0400
Date: Wed, 2 Oct 2002 18:14:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Kevin Corry <corryk@us.ibm.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: EVMS Submission for 2.5
In-Reply-To: <02100216332002.18102@boiler>
Message-ID: <Pine.GSO.4.21.0210021812590.9782-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Oct 2002, Kevin Corry wrote:

> On behalf of the EVMS team, I'd like to submit the Enterprise Volume
> Management System for inclusion in the 2.5 Linux kernel tree.
> 
> To make this as simple as possible for you, there is a Bitkeeper
> tree available with the latest EVMS source code, located at:
> http://evms.bkbits.net/linux-2.5
> This tree is sync'd with the linux-2.5 tree on linux.bkbits.net
> as of about noon today (Oct 2).
 
> - Add a function, walk_gendisk(), to drivers/block/genhd.c to allow
>   EVMS to get information about the disks on the system from the
>   gendisk list in a safe manner.

Consider that one vetoed.  Linus, please do _not_ apply until that
stuff is resolved - it conflicts with a bunch of cleanups we'll
need.

