Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129616AbRBHDYa>; Wed, 7 Feb 2001 22:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129620AbRBHDYU>; Wed, 7 Feb 2001 22:24:20 -0500
Received: from ausxc08.us.dell.com ([143.166.99.216]:29866 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S129616AbRBHDYI>; Wed, 7 Feb 2001 22:24:08 -0500
Message-ID: <CDF99E351003D311A8B0009027457F1403BF9CA3@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: RE: aacraid 2.4.0 kernel
Date: Wed, 7 Feb 2001 21:24:00 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I haven't seen this driver, but if it uses the SCSI layer instead
> of being a "pure" block driver then I can see a slight problem
> in that currently only understand max sg entry limits and not
> total request sizes. I would rather fix this limitation then, and
> would also be interested to know if any of the (older) SCSI drivers
> have such limitations too.

Yes, it's a SCSI driver, not a block driver.  Adaptec thought it prudent to
try to fix this in their driver rather than try to change the SCSI layer in
2.4.x just now.  They expected it would be more difficult getting such a
change through validation and into the kernel in a timely manner.

-Matt


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
