Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281450AbRLDUWN>; Tue, 4 Dec 2001 15:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283389AbRLDUUi>; Tue, 4 Dec 2001 15:20:38 -0500
Received: from leeloo.zip.com.au ([203.12.97.48]:26120 "EHLO
	mangalore.zipworld.com.au") by vger.kernel.org with ESMTP
	id <S283422AbRLDUUV>; Tue, 4 Dec 2001 15:20:21 -0500
Message-ID: <3C0D2FF4.837EEE87@zip.com.au>
Date: Tue, 04 Dec 2001 12:20:04 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <E16BJvR-0002uc-00@the-village.bc.nu>,
		<E16BJvR-0002uc-00@the-village.bc.nu> <E16BK7Y-0000Rk-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On December 4, 2001 07:04 pm, Alan Cox wrote:
> > > Single additional alloc -> twice as many allocs, two slabs, more cachelines
> > > dirty.  This was hashed out on fsdevel, though apparently not to everyone's
> > > satisfaction.
> >
> > Al Viro's NFS in generic_ip saved me something like 130K of memory.
> 
> Yes, all of these proposals would do that, by getting away from all inodes
> being the same size (basically the size of the ext2 inode).
> 

ext3 is the pig at present.  I think Andreas has half-a-patch
to move it to generic_ip.
