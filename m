Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286925AbSASSnf>; Sat, 19 Jan 2002 13:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286934AbSASSnZ>; Sat, 19 Jan 2002 13:43:25 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:28861 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S286925AbSASSnO>; Sat, 19 Jan 2002 13:43:14 -0500
Date: Sat, 19 Jan 2002 20:43:00 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 18, 2002
Message-ID: <20020119184259.GE135220@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <3C477B7F.22875.11D4078A@localhost> <Pine.GSO.4.21.0201180546310.296-100000@weyl.math.psu.edu> <3C488E84.A1453ED2@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C488E84.A1453ED2@zip.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> Merged: Per-process namespaces, late-boot cleanups.
> Ready: switch to ->get_super() as primary file_system_type method.
> Ready: ->getattr() handling and changes of ->setattr()/->permission()
> prototypes.
> Pending: proper UFS fixes, ext2 cleanups and locking
> changes.
> Pending: per-mountpoint read-only, union-mounts and unionfs.
> Pending: lifting limitations on mount(2)
> In progress: killing kdev_t for block devices (switch to struct block_device *)
> Started: UMSDOS rewrite (the damn thing blocks struct inode trimming)
> Planned: new mount API.

All this seems very neat. One question: what about forced umount / forced
remount readonly stuff? Any plans on that?


-- v --

v@iki.fi
