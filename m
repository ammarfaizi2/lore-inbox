Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129806AbRAKUYk>; Thu, 11 Jan 2001 15:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130871AbRAKUY3>; Thu, 11 Jan 2001 15:24:29 -0500
Received: from zeus.kernel.org ([209.10.41.242]:60635 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130695AbRAKUYS>;
	Thu, 11 Jan 2001 15:24:18 -0500
Date: Thu, 11 Jan 2001 14:32:55 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange umount problem in latest 2.4.0 kernels
In-Reply-To: <3A5E0886.4389692E@Hell.WH8.TU-Dresden.De>
Message-ID: <Pine.GSO.4.21.0101111428240.17363-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Jan 2001, Udo A. Steinberg wrote:

> > /dev/hdb1: Inode 522901, i_blocks is 64, should be 8. FIXED

> umount: none busy - remounted read-only
 
> The "none" bit puzzles me the most. /etc/fstab and /etc/mtab
> look perfectly ok.
> 
> Has anyone got an idea? Everything worked well with 2.4.0 and
> Alan's tree up to -ac4, didn't try ac5, and ac6 is what messes
> up now.

Try to revert to -ac4 fs/super.c and see if it helps

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
