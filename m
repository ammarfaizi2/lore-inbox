Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270015AbRHEUr7>; Sun, 5 Aug 2001 16:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270013AbRHEUrt>; Sun, 5 Aug 2001 16:47:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:12774 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270012AbRHEUrg>;
	Sun, 5 Aug 2001 16:47:36 -0400
Date: Sun, 5 Aug 2001 16:47:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] initramfs patch (2.4.8-pre3)
In-Reply-To: <Pine.LNX.4.21.0108052135510.855-100000@pppg_penguin.linux.bogus>
Message-ID: <Pine.GSO.4.21.0108051640360.12846-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Aug 2001, Ken Moffat wrote:

> Small problem, though
> 
> request_module[ramfs]: Root fs not mounted
> Kernel panic. Can't create rootfs
> 
> Obviously I've not been paying attention. I ran "make oldconfig" and
> didn't see any new options that were needed, so I didn't consider altering
> my current config settings. Which one is it I need, please ? 

RAMFS ;-) Actually, I probably ought to replace tristate ... CONFIG_RAMFS
with define_bool CONFIG_RAMFS y in fs/Config.in.

