Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132462AbQKSPUS>; Sun, 19 Nov 2000 10:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132484AbQKSPT5>; Sun, 19 Nov 2000 10:19:57 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:21689 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132483AbQKSPTw>;
	Sun, 19 Nov 2000 10:19:52 -0500
Date: Sun, 19 Nov 2000 09:49:50 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: David Lang <david.lang@digitalinsight.com>
cc: kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
In-Reply-To: <Pine.LNX.4.21.0011190707340.22457-100000@dlang.diginsite.com>
Message-ID: <Pine.GSO.4.21.0011190944330.22734-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Nov 2000, David Lang wrote:

> there is a rootkit kernel module out there that, if loaded onto your
> system, can make it almost impossible to detect that your system has been
> compramised. with module support disabled this isn't possible.

Yes, it is. Easily. If you've got root you can modify the kernel image and
reboot the bloody thing. And no, marking it immutable will not help. Open
the raw device and modify relevant blocks.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
