Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbSJLRmK>; Sat, 12 Oct 2002 13:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSJLRmJ>; Sat, 12 Oct 2002 13:42:09 -0400
Received: from im2.mail.tds.net ([216.170.230.92]:38802 "EHLO im2.sec.tds.net")
	by vger.kernel.org with ESMTP id <S261309AbSJLRmH>;
	Sat, 12 Oct 2002 13:42:07 -0400
Date: Sat, 12 Oct 2002 13:47:51 -0400 (EDT)
From: Jon Portnoy <portnoy@tellink.net>
X-X-Sender: portnoy@localhost.localdomain
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.42
In-Reply-To: <20021012111140.GA22536@pegasys.ws>
Message-ID: <Pine.LNX.4.44.0210121346550.6310-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.42; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.5.42/kernel/fs/ext3/ext3.o
depmod:         generic_file_aio_read
depmod:         generic_file_aio_write
depmod: *** Unresolved symbols in /lib/modules/2.5.42/kernel/fs/nfs/nfs.o
depmod:         generic_file_aio_read
depmod:         generic_file_aio_write
depmod: *** Unresolved symbols in 
/lib/modules/2.5.42/kernel/fs/nfsd/nfsd.o
depmod:         auth_domain_find
depmod:         cache_fresh
depmod:         unix_domain_find
depmod:         auth_domain_put
depmod:         cache_flush
depmod:         cache_unregister
depmod:         add_hex
depmod:         cache_check
depmod:         svcauth_unix_purge
depmod:         get_word
depmod:         cache_clean
depmod:         cache_register
depmod:         auth_unix_lookup
depmod:         auth_unix_add_addr
depmod:         cache_init
depmod:         auth_unix_forget_old
depmod:         add_word

