Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129778AbQL0UYY>; Wed, 27 Dec 2000 15:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130120AbQL0UYE>; Wed, 27 Dec 2000 15:24:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:59723 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129778AbQL0UYC>; Wed, 27 Dec 2000 15:24:02 -0500
Date: Wed, 27 Dec 2000 20:53:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Todd M. Roy" <toddroy@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lvm 0.8 to 0.9 conversion?
Message-ID: <20001227205336.A10446@athlon.random>
In-Reply-To: <3A45192F.8C149F93@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A45192F.8C149F93@softhome.net>; from toddroy@softhome.net on Sat, Dec 23, 2000 at 04:29:19PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 23, 2000 at 04:29:19PM -0500, Todd M. Roy wrote:
> group is visible, and you just told meit should be, then I can just
> copy volumes over under test13-pre3 and destroy and recreate the
> first volume group.

Is it possible you had a snapshot in the volume group when you started
lvm 0.9 the first time? snapshots are not persistent on pre3 so it doesn't make
sense to left them before rebooting the kernel, and maybe lvmtools 0.9 doesn't
cope correctly with non persistent snapshot created by 0.8 driver (trivial to
temporarly workaround, just delete any snapshot volume before using 0.9 lvm :).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
