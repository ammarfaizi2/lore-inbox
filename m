Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130516AbRAHWoD>; Mon, 8 Jan 2001 17:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131342AbRAHWnx>; Mon, 8 Jan 2001 17:43:53 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:55335 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130516AbRAHWnr>; Mon, 8 Jan 2001 17:43:47 -0500
Date: Mon, 8 Jan 2001 23:43:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Todd M. Roy" <troy@holstein.com>
Cc: toddroy@softhome.net, linux-kernel@vger.kernel.org
Subject: Re: lvm 0.8 to 0.9 conversion?
Message-ID: <20010108234339.F27646@athlon.random>
In-Reply-To: <3A45192F.8C149F93@softhome.net> <20001227205336.A10446@athlon.random> <200101081918.f08JIrT06681@pcx4168.holstein.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101081918.f08JIrT06681@pcx4168.holstein.com>; from troy@holstein.com on Mon, Jan 08, 2001 at 07:18:53PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 07:18:53PM +0000, Todd M. Roy wrote:
> 
> I've been on vacation....
> 
> Nope, no snapshots.
> 
> Well, I couldn't get my orginal volume group visible under both
> lvm 0.8 and 0.9.  I don't know why.  So I grabbed a big empty hard disk,
> created a new volume group that was visible under both, dded all the logical
> volumes over to it, updated fstab  and removed the offending vg.  I've yet to
> recreate the original vg, copy stuff back and remove the new drive.
> I should point out that the offending vg was relatively ancient, I think I
> created it when 0.7 was king under some something like 2.2.14.  Now I'm 
> running 2.4.0-ac4 and all works well.

Good. You may consider to also apply this kernel-driver bugfix for
online extent/reduce of the VG and other assorted fixes:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.0ac2/lvm-fix-1

I sumbitted them to Heinz a few days ago so that he can merge them with Linus.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
