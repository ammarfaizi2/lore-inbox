Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbSKFA5X>; Tue, 5 Nov 2002 19:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbSKFA5X>; Tue, 5 Nov 2002 19:57:23 -0500
Received: from air-2.osdl.org ([65.172.181.6]:2197 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265246AbSKFA5W>;
	Tue, 5 Nov 2002 19:57:22 -0500
Date: Tue, 5 Nov 2002 16:59:28 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Miles Lane <miles.lane@attbi.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Unresolved symbols in char/raw.o (blkdev_ioctl) and fs/binfmt_aout.o
 (ptrace_notify)
In-Reply-To: <1036543157.1162.17.camel@bellybutton>
Message-ID: <Pine.LNX.4.33L2.0211051659040.21048-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Nov 2002, Miles Lane wrote:

|
| if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.46; fi
| depmod: *** Unresolved symbols in
| /lib/modules/2.5.46/kernel/drivers/char/raw.o
| depmod:         blkdev_ioctl
| depmod: *** Unresolved symbols in
| /lib/modules/2.5.46/kernel/fs/binfmt_aout.o
| depmod:         ptrace_notify

Patches for both of these have already appeared on lkml.

-- 
~Randy
location: NPP-4E

