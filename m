Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290960AbSBFXji>; Wed, 6 Feb 2002 18:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290953AbSBFXja>; Wed, 6 Feb 2002 18:39:30 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:45970 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290958AbSBFXjU>;
	Wed, 6 Feb 2002 18:39:20 -0500
Date: Wed, 6 Feb 2002 18:39:11 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Heinz Diehl <hd@cavy.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Warning, 2.5.3 eats filesystems
In-Reply-To: <20020206233051.GA503@chiara.cavy.de>
Message-ID: <Pine.GSO.4.21.0202061836450.22680-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Feb 2002, Heinz Diehl wrote:

> On Wed Feb 06 2002, Daniel Pittman wrote:
> 
> > > 2.5.3 managed to damage my ext2 filesystem (few lost directories);
> > > beware.
> 
> > I can confirm that there are filesystem corruption issues with 2.5.3;
> > after this message I rebooted and did a forced fsck which turned up
> > around a half dozen inodes where the block count in the inode itself was
> > too high.
> 
> Exactly the same thing here, and I bet it _is_ 2.5.3 and not a relict from
> a 2.5.3-pre patch because I switched directly from 2.4.17 to 2.5.3
> without ever using any pre patch at this machine.

Very interesting.  Which filesystems are mounted (other than ext2) and
are you been able to reproduce it on 2.5.3-pre6?

