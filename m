Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbTJFS3S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTJFS3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:29:17 -0400
Received: from mail3-126.ewetel.de ([212.6.122.126]:10904 "EHLO
	mail3.ewetel.de") by vger.kernel.org with ESMTP id S262310AbTJFS3D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:29:03 -0400
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
In-Reply-To: <DsvX.3yN.1@gated-at.bofh.it>
References: <Dnwo.1ew.15@gated-at.bofh.it> <DnPL.3XB.11@gated-at.bofh.it> <DsvX.3yN.1@gated-at.bofh.it>
Date: Mon, 6 Oct 2003 20:28:46 +0200
Message-Id: <E1A6a6A-0000qT-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Oct 2003 03:40:05 +0200, you wrote in linux.kernel:

> A much more obvious example than the SCM one is a device driver or a module.
> That's so cut and dried it isn't even open to debate in the eyes of the 
> law.  It's a hard and fast boundary, the GPL can't cross it no matter what
> people think or want (on either side).

Huh? How is a driver an independent work under the definition you gave?
I can't take the Linux kernel out and insert the driver into another
kernel and have it still work. Only the opposite is true - the kernel
would run without the driver, and therefore the kernel is not a derived
work of the driver and can't be subject to license terms of the driver.

The kernel doesn't have a defined interface for drivers. It changes a
lot at least during a development series. A driver is not independent from
the kernel running under it because it has to be changed quite often to
adapt to the changing internal kernel interfaces.

You can't even change the Linux kernel version you're using and have the
same driver still work for you. So by your definition, a driver is at
least in part a derived work of the kernel.

Now, if the driver has an internal abstraction layer that seperates the
kernel side of things from the real work the driver does, I would agree
that only the abstraction layer is a derived work and has to be GPL'd,
not the rest of the driver.

Most drivers don't work that way because of the additional overhead.

-- 
Ciao,
Pascal
