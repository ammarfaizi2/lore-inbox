Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282082AbRKWHjv>; Fri, 23 Nov 2001 02:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282083AbRKWHjm>; Fri, 23 Nov 2001 02:39:42 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:5389 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S282082AbRKWHjb>; Fri, 23 Nov 2001 02:39:31 -0500
To: Jeff Chua <jchua@fedex.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
        Andreas Dilger <adilger@turbolabs.com>,
        Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>,
        Tyler BIRD <birdty@uvsc.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Filesize limit on SMBFS
In-Reply-To: <Pine.LNX.4.42.0111231123220.16590-100000@boston.corp.fedex.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 23 Nov 2001 16:09:56 +0900
In-Reply-To: <Pine.LNX.4.42.0111231123220.16590-100000@boston.corp.fedex.com>
Message-ID: <87lmgyezej.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua <jchua@fedex.com> writes:

> On Fri, 23 Nov 2001, Anton Altaparmakov wrote:
> 
> > You mean you have 1) a single file with size 3GiB on a large VFAT partition
> > or 2) the VFAT partition is 3GiB in itself?
> 
> Sorry, 3GB partition. But maximum size per file is only 2GB.
> 

FYI,

In the ordinary way, FAT16 is 2GiB per file, and 2GiB per partition.
FAT32 is 4GiB per file. (if sector size is 512B)

However, currently vfat of linux is 2GiB per file.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
