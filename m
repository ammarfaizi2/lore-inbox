Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264841AbRF1XJD>; Thu, 28 Jun 2001 19:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264848AbRF1XIx>; Thu, 28 Jun 2001 19:08:53 -0400
Received: from Expansa.sns.it ([192.167.206.189]:60944 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S264841AbRF1XIp>;
	Thu, 28 Jun 2001 19:08:45 -0400
Date: Fri, 29 Jun 2001 01:08:41 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Yaacov Akiba Slama <slamaya@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Announcing Journaled File System (JFS) release 1.0.0 available
In-Reply-To: <3B3B9DD2.1030103@yahoo.com>
Message-ID: <Pine.LNX.4.33.0106290056350.27056-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Jun 2001, Yaacov Akiba Slama wrote:

> Hi,
>  From what I understand from Linus's mail to lkml, there is a difference
> between JFS and XFS:
> JFS doesn't require any modifications to existing code, its only an
> addition.
> XFS on the contrary is far more intrusive.
> So it seems that even if JFS is less complete than XFS (no ACL, quotas
> for instance), and even if it is less robust (I don't know if it is, I
It is not less complete nor less robust, it's a different technology and a
totally different approach.
Remember XFS was designed thinking to a kind of HW totally different from
PC, and so was for jfs. But somehow JFS is a better choice if you
do not have the last fastest CPU, and the last fastest scsi disk.
> only used so far XFS and ext3 -with success), its inclusion in current
> kernel is a lot easier and I don't see any (technical) reason for not
> including it.
I hope it will happen as soon.
ReiserFS is a good FS, probably is the best journaled FS you could find
out here, but how many memories with
the old dear jfs! And I have some pentium classic for non critical use
that would be so happy with it.
> I don't think ext3 will have difficulties to be included in the kernel
> because a) the guys working on it are lk veterans and b) Redhat (VA
> also) is already including it in its kernels (rawhide AND 7.1 update).
agree.
> So I only hope that the smart guys at SGI find a way to prepare the
> patches the way Linus loves because now the file
> "patch-2.4.5-xfs-1.0.1-core" (which contains the modifs to the kernel
> and not the new files) is about 174090 bytes which is a lot.
mmm.
I doubt it will be easy.
I should check better, but i think it requires eavy changes to VFS.

oh, by the way.
On a 8 processor origin 2000, with a not so eavy I/O, I usually see
1 processor
totally used just for journaling. (different HW, different Unix ....)

Luigi


