Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSFEJx7>; Wed, 5 Jun 2002 05:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSFEJx6>; Wed, 5 Jun 2002 05:53:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:42072 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S313867AbSFEJx5>;
	Wed, 5 Jun 2002 05:53:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hans-Christian Armingeon <linux.johnny@gmx.net>
To: Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [rfc] "laptop mode"
Date: Wed, 5 Jun 2002 13:41:28 +0200
X-Mailer: KMail [version 1.4]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CFD453A.B6A43522@zip.com.au> <20020604233124.GA18668@turbolinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206051340.47261.root@johnny>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 5. Juni 2002 01:31 schrieb Andreas Dilger:
> [...]
> Just FYI, this is probably an optimally bad choice for the default disk
> spinup interval, as many laptops spindown timers in the same ballpark.
> I would say 15-20 minutes or more, unless there is a huge amount of
> VM pressure or something.  Otherwise, you will quickly have a dead
> laptop harddrive from the overly-frequent spinup/down cycles.
>
What parts of the filesystem needs to be accessed very often? I think, that placing var on a ramdisk, that is mirrored on the hd and is synced every 30 minutes, would be a good solution.
I think, that we should add a sysrq key to save the ramdisk to the disk. Is there a similar project, that loads an image into a ramdisk at mount, and writes it back at unmount?

> Yes, minutae, I know.  Otherwise a nice idea.
>
> Cheers, Andreas

Johnny


