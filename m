Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275150AbRIYSf5>; Tue, 25 Sep 2001 14:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275148AbRIYSfi>; Tue, 25 Sep 2001 14:35:38 -0400
Received: from [209.202.108.240] ([209.202.108.240]:21255 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S275149AbRIYSf2>; Tue, 25 Sep 2001 14:35:28 -0400
Date: Tue, 25 Sep 2001 14:35:38 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: all files are executable in vfat
In-Reply-To: <Pine.LNX.4.30.0109251323510.17451-100000@waste.org>
Message-ID: <Pine.LNX.4.33.0109251434040.21994-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Oliver Xymoron wrote:

> On Tue, 25 Sep 2001, Alexander Viro wrote:
>
> > On Tue, 25 Sep 2001, William Scott Lockwood III wrote:
> >
> > > dmask?
> >
> > Umm... That makes sense.
>
> Don't know if you already did this with umask, but {umask dmask uid gid}
> probably make sense as per-mountpoint options rather than VFAT-specific
> ones.

Not for filesystems that store permission info, e.g., ext2, ISO9660+RockRidge,
etc.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>


