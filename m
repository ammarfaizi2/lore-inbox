Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263949AbTEFSJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263964AbTEFSJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:09:50 -0400
Received: from pat.uio.no ([129.240.130.16]:42912 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263949AbTEFSJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:09:49 -0400
Date: Tue, 6 May 2003 20:22:20 +0200 (MEST)
From: Peder Stray <peder@ifi.uio.no>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: linux-kernel@vger.kernel.org
Subject: Re: Files truncate on vfat filesystem
In-Reply-To: <87k7d4t1ay.fsf@devron.myhome.or.jp>
Message-ID: <Pine.SOL.4.51.0305062018090.25815@tyrfing.ifi.uio.no>
References: <wa1ade0gkl3.fsf@tyrfing.ifi.uio.no> <87k7d4t1ay.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, OGAWA Hirofumi wrote:

> Peder Stray <peder@ifi.uio.no> writes:
>
> > I have a 250GB usb-storage disk i use to transport large files between
> > work and home, I uses vfat (since I haven't found any other good
> > filesystems that don't require me to either be root or have all files
> > worldreadable). Anyways...
>
> What partition size do you use? And does that FAT use what logical
> sector size?  The directory entry pointer may be overflowed...

250GB partition, FAT32 LBA (partition type 0x0c i think).

The problem is verry inconsistent as i said earlier, so the number of
files in a directory doesn't seem to matter, nor do the depth in the
directory structure. Some files i manage to copy yo the disk, some files i
don't... I havent managed to find any pattern in what files this affects.

-- 
  Peder Stray
