Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131240AbQKNURC>; Tue, 14 Nov 2000 15:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131245AbQKNUQw>; Tue, 14 Nov 2000 15:16:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:20986 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131240AbQKNUQj>;
	Tue, 14 Nov 2000 15:16:39 -0500
Date: Tue, 14 Nov 2000 14:46:37 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Juan <piernas@ditec.um.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: Addressing logically the buffer cache
In-Reply-To: <3A1198FD.FB50B05E@ditec.um.es>
Message-ID: <Pine.GSO.4.21.0011141445450.5482-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Nov 2000, Juan wrote:

> Hi!.
> 
> Is there any patch or project to address logically the buffer cache?.
> Now, you use three parameters to find a buffer in cache: device, block
> number, and block size. But, what about if I want to find a buffer using
> a super block, an inode number, and a block number within the file
> specified by the inode number.

What's wrong with using the pagecache and per-page buffer_heads?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
