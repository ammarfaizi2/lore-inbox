Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131236AbQK2Mca>; Wed, 29 Nov 2000 07:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131246AbQK2McU>; Wed, 29 Nov 2000 07:32:20 -0500
Received: from [62.172.234.2] ([62.172.234.2]:8340 "EHLO localhost.localdomain")
        by vger.kernel.org with ESMTP id <S131236AbQK2McH>;
        Wed, 29 Nov 2000 07:32:07 -0500
Date: Wed, 29 Nov 2000 12:01:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andries Brouwer <aeb@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
In-Reply-To: <20001128223721.B11055@veritas.com>
Message-ID: <Pine.LNX.4.21.0011291147170.4021-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000, Andries Brouwer wrote:
> On Tue, Nov 28, 2000 at 03:04:31PM +0100, Rogier Wolff wrote:
> 
> > Ok, so if you read the standard carefully you get a bogus result. 
> 
> Why bogus? Things could have been otherwise, but the important
> part is that all Unices do things the same way.

Yes, and I think you'll have difficulty, Andries, finding
any other Unices which interpret the standard as you and
Linux do: Solaris, HP-UX, UnixWare and OpenServer all allow
writing to a device node (or FIFO) on read-only filesystem.

Hugh

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
