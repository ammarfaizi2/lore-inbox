Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274636AbRJAGxz>; Mon, 1 Oct 2001 02:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274638AbRJAGxf>; Mon, 1 Oct 2001 02:53:35 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:16621 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S274636AbRJAGxd>; Mon, 1 Oct 2001 02:53:33 -0400
Date: Mon, 1 Oct 2001 07:54:01 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Reply-To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] cleanup of partition code
In-Reply-To: <Pine.GSO.4.21.0109302152260.13829-100000@weyl.math.psu.edu>
Message-ID: <Pine.SOL.3.96.1011001075038.29567C-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al,

On Sun, 30 Sep 2001, Alexander Viro wrote:
> Update:  fixed a double-free bug in amiga_partition().  After that thing
> seems to be working on Amiga disk sent by Jes (as in, "right amount
> of partitions and reasonably looking boundaries").
> 
> Patch is on ftp.math.psu.edu/pub/viro/partition-b-S11-pre1.

Just a random data point: your patch works fine here both with
msdos+extended partitions and with an LDM disk. 

I haven't tried the updated patch but as I don't have an amiga it
shouldn't make a difference on my systems anyway...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


