Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129520AbQK0VDd>; Mon, 27 Nov 2000 16:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130163AbQK0VDX>; Mon, 27 Nov 2000 16:03:23 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:36532 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S129520AbQK0VDP>;
        Mon, 27 Nov 2000 16:03:15 -0500
Date: Mon, 27 Nov 2000 15:33:13 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: John Zielinski <grimr@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Anyone else kernel mounting a filesystem that has a block device?
In-Reply-To: <003301c058b0$0875cc40$6400a8c0@wlfdle1.on.wave.home.com>
Message-ID: <Pine.GSO.4.21.0011271530120.7352-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Nov 2000, John Zielinski wrote:

> I'm going to be mounting a filesystem that uses a block device from inside
> the kernel.  This mount will not be visible from userland nor can it be
> unmounted from userland.  Is anyone else doing something like this so we can
> coordinate on the changes needed to fs/super.c?

No changes needed. Check kern_mount().

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
