Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263603AbTJCCT4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 22:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbTJCCT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 22:19:56 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:39332 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S263603AbTJCCTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 22:19:54 -0400
Message-ID: <1065147608.3f7cdcd8dc163@dubai.stillhq.com>
Date: Fri,  3 Oct 2003 12:20:08 +1000
From: Michael Still <mikal@stillhq.com>
To: Michael Still <mikal@stillhq.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Documentation tweaks to remove build errors
References: <1065141139.3f7cc393b9e22@dubai.stillhq.com>
In-Reply-To: <1065141139.3f7cc393b9e22@dubai.stillhq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 203.17.68.210
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michael Still <mikal@stillhq.com>:

> This is a forward port of my previous patch to cset-20031002_1507.

To clarify, the patch is a forward port from test5 of patches already submitted.
The files patched are:

# arch/i386/kernel/mca.c
# drivers/block/ll_rw_blk.c
# drivers/pci/pci.c
# drivers/serial/8250.c
# drivers/serial/serial_core.c
# fs/devfs/base.c
# fs/inode.c
# fs/locks.c
# fs/super.c
# include/linux/list.h
# include/linux/skbuff.h
# kernel/kmod.c
# mm/slab.c
# net/core/dev.c
# sound/oss/via82cxxx_audio.c

The patch squelches build errors in the kernel-doc make targets by adding
documentation to arguements previously not documented, and updating the argument
names where they have changed.

Cheers,
Mikal

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
