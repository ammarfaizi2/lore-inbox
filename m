Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135860AbRDZU5R>; Thu, 26 Apr 2001 16:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136010AbRDZU5I>; Thu, 26 Apr 2001 16:57:08 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11443 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135956AbRDZU46>;
	Thu, 26 Apr 2001 16:56:58 -0400
Date: Thu, 26 Apr 2001 16:55:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.LNX.3.95.1010426163144.20158A-100000@chaos.analogic.com>
Message-ID: <Pine.GSO.4.21.0104261651110.15385-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Apr 2001, Richard B. Johnson wrote:

> The disk image, raw.bin, does NOT contain the image of the floppy.
> Most of boot stuff added by lilo is missing. It will eventually
> get there, but it's not there now, even though the floppy was
> un-mounted!

I doubt that you can reproduce that on anything remotely recent.
All buffers are flushed when last user closes device.

