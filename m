Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318260AbSHKKMk>; Sun, 11 Aug 2002 06:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318274AbSHKKMj>; Sun, 11 Aug 2002 06:12:39 -0400
Received: from ns.suse.de ([213.95.15.193]:21522 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318260AbSHKKMb>;
	Sun, 11 Aug 2002 06:12:31 -0400
To: Ivan Gyurdiev <ivangurdiev@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.31
References: <200208100551.46142.ivangurdiev@attbi.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 11 Aug 2002 12:16:16 +0200
In-Reply-To: Ivan Gyurdiev's message of "11 Aug 2002 11:47:58 +0200"
Message-ID: <p73r8h5itu7.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Gyurdiev <ivangurdiev@attbi.com> writes:
> 
> drivers/built-in.o: In function `parport_pc_probe_port':
> drivers/built-in.o(.text+0x2dbf6): undefined reference to `request_dma'
> drivers/built-in.o(.text+0x2dc98): undefined reference to `free_dma'
> drivers/built-in.o: In function `parport_pc_unregister_port':
> drivers/built-in.o(.text+0x2df94): undefined reference to `free_dma'
> drivers/built-in.o(.data+0x4c20): undefined reference to `request_dma'
> drivers/built-in.o(.data+0x4c24): undefined reference to `free_dma'
> make: *** [vmlinux] Error 1

make oldconfig and recompiling should fix that.

-Andi
