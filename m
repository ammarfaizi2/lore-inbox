Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317035AbSHYH6R>; Sun, 25 Aug 2002 03:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317054AbSHYH6R>; Sun, 25 Aug 2002 03:58:17 -0400
Received: from samar.sasken.com ([164.164.56.2]:48051 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S317035AbSHYH6Q>;
	Sun, 25 Aug 2002 03:58:16 -0400
Date: Sun, 25 Aug 2002 13:34:33 +0530 (IST)
From: Madhavi <madhavis@sasken.com>
To: <linux-kernel@vger.kernel.org>
Subject: unresolved symbols
Message-ID: <Pine.LNX.4.33.0208251327260.9582-100000@pcz-madhavis.sasken.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I have written a loadable kernel module for linux-2.4.19-pre10 (PPC). When
I try to do insmod, I am getting the following errors:

unresolved symbol __save_flags_ptr
unresolved symbol xmon
unresolved symbol __restore_flags
unresolved symbol __cli

When I compile the kernel without KMOD and MODEVERSIONS, I am not getting
these errors. There are some other symbols I am exporting from kernel
which seem to be getting resolved fine with and without MODVERSIONS and
KMOD.

I have included <asm/system.h> and <linux/module.h> in my files and I am
compiling the module with -D__KERNEL__ flags.

Any idea why this is happening?

regards
Madhavi.

