Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbQKSSz5>; Sun, 19 Nov 2000 13:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129136AbQKSSzs>; Sun, 19 Nov 2000 13:55:48 -0500
Received: from einhorn.colt.in-berlin.de ([213.61.118.8]:51980 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id <S129227AbQKSSzj>; Sun, 19 Nov 2000 13:55:39 -0500
Date: Sun, 19 Nov 2000 18:36:25 +0100 (CET)
From: Gerd Knorr <kraxel@bytesex.org>
To: David Lang <david.lang@digitalinsight.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
In-Reply-To: <Pine.LNX.4.21.0011190707340.22457-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.21.0011191831340.711-100000@bogomips.masq.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2000, David Lang wrote:

> there is a rootkit kernel module out there that, if loaded onto your
> system, can make it almost impossible to detect that your system has been
> compramised. with module support disabled this isn't possible.

Wrong.  I've seen messages on bugtraq saying it is possible to "load"
modules into the kernel by patching /dev/kmem.  Even for loading modules
custom modules the normal way the attacker needs root priviliges (unless
you have a world-writeable /lib/modules...).  If this is the case it is
too late anyway...

  Gerd

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
