Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290664AbSARK5d>; Fri, 18 Jan 2002 05:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290663AbSARK5X>; Fri, 18 Jan 2002 05:57:23 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:7618 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290664AbSARK5M>;
	Fri, 18 Jan 2002 05:57:12 -0500
Date: Fri, 18 Jan 2002 05:57:10 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Guillaume Boissiere <boissiere@mediaone.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 18, 2002
In-Reply-To: <3C477B7F.22875.11D4078A@localhost>
Message-ID: <Pine.GSO.4.21.0201180546310.296-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 18 Jan 2002, Guillaume Boissiere wrote:

> o Merged     New scheduler for improved scalability        (Ingo Molnar, Davide Libenzi)
> o Merged     Rewrite of the block IO (bio) layer           (Jens Axboe)
> o Merged     New kernel device structure (kdev_t)          (Linus Torvalds, etc)
> o Merged     Initial support for USB 2.0                   (David Brownell, Greg Kroah-Hartman, 

Merged: Per-process namespaces, late-boot cleanups.
Ready: switch to ->get_super() as primary file_system_type method.
Ready: ->getattr() handling and changes of ->setattr()/->permission()
prototypes.
Pending: proper UFS fixes, ext2 cleanups and locking
changes.
Pending: per-mountpoint read-only, union-mounts and unionfs.
Pending: lifting limitations on mount(2)
In progress: killing kdev_t for block devices (switch to struct block_device *)
Started: UMSDOS rewrite (the damn thing blocks struct inode trimming)
Planned: new mount API.

