Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130646AbRBETM2>; Mon, 5 Feb 2001 14:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135620AbRBETMJ>; Mon, 5 Feb 2001 14:12:09 -0500
Received: from hps.aoe.vt.edu ([128.173.191.43]:44194 "EHLO hermes.aoe.vt.edu")
	by vger.kernel.org with ESMTP id <S130646AbRBETLx>;
	Mon, 5 Feb 2001 14:11:53 -0500
Date: Mon, 5 Feb 2001 14:11:11 -0500 (EST)
From: Josh Durham <jmd@aoe.vt.edu>
To: Samuel Flory <sflory@valinux.com>
cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] NFS and reiserfs
In-Reply-To: <3A7EF9CF.8C5EE1C@valinux.com>
Message-ID: <Pine.LNX.4.21.0102051410440.22045-100000@hermes.aoe.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any problems with NFSv3?  I had tons of issues, but NFSv2 seems to work
just fine.  It was with SGI clients.

- Josh

On Mon, 5 Feb 2001, Samuel Flory wrote:

> Dirk Mueller wrote:
> > 
> > On Mon, 05 Feb 2001, Grahame Jordan wrote:
> > 
> > > Should I convert all of my NFS filesystems to ext2 or is there another
> > > option?
> > 
> > If you use kernel 2.4.x: there are patches for NFS support.
> > 
> 
>   You can also try the rpms below.  They seem to work for me, but your
> results may vary.  If you really want to be able to gracefully recover
> you need to force sync on all of your exports.
> 
> http://ftp.valinux.com/pub/people/flory/2.4.1/
> 
> 
> The patch is here:
> ftp://ftp.namesys.com/pub/reiserfs-for-2.4/linux-2.4.0-reiserfs-3.6.25-nfs.diff
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
