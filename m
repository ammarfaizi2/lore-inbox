Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263005AbVDLV5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbVDLV5x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVDLVy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:54:28 -0400
Received: from mail.shareable.org ([81.29.64.88]:40096 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262551AbVDLVwb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:52:31 -0400
Date: Tue, 12 Apr 2005 22:52:20 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>,
       Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050412215220.GA23321@mail.shareable.org>
References: <3S8oN-So-19@gated-at.bofh.it> <3S8oN-So-21@gated-at.bofh.it> <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it> <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org> <20050412144529.GE10995@mail.shareable.org> <Pine.LNX.4.60.0504122117010.26320@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0504122117010.26320@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> > That said, I would _usually_ prefer that when I enter a tgz, that I
> > see all component files having the same uid/gid/permissions as the tgz
> > file itself - the same as I'd see if I entered a zip file.
> 
> As you say _usually_, even you admit that sometimes you would want the 
> real owner/permissions to be shown.  And that is the point Miklos is 
> trying to make I believe: it should be configurable not hard set to only 
> one which is what I understand HCH wants.
> 
> There are uses for both.  For example today I was updating the tar ball 
> which is used to create the var file system for a new chroot.  I certainly 
> want to see corretly setup owner/permissions when I look into that tar 
> ball using a FUSE fs...

If I'm updating a var filesystem for a new chroot, I'd need the
ability to chmod and chown things in that filesystem.  Does that work
as an ordinary user?

-- Jamie
