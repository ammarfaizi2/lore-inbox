Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVCHDIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVCHDIg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 22:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVCGU1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:27:19 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:2737 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261754AbVCGUM3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:12:29 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [??/many] list of files to be sent in a next couple of e-mails with small description
In-Reply-To: <11102278521318@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:32 +0300
Message-Id: <11102278521366@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


announce - asynchronous crypto layer announce
files - file with this cruft
bench - acrypto benchmark vs cryptoloop vs dm_crypt
iok.c - userspace application which uses ioctl based acrypto access
ucon_crypto.c - userspace application which uses direct process' VMA access
acrypto_Kconfig.patch - acrypto kernel config file
acrypto_Makefile.patch - acrypto make file
acrypto_acrypto.h.patch - base definition used in acrypto and it's users
acrypto_async_provider.c.patch - asynchronous crypto provider [AES CBC mode only] - sync crypto based
acrypto_crypto_conn.c.patch - kernel connector's backend - allows statistic fetching
acrypto_crypto_conn.h.patch - definitions for kernel connector's subsystem
acrypto_crypto_def.h.patch - various acrypto definitions like crypto modes, types of operation and so on...
acrypto_crypto_dev.c.patch - main crypto device add/remove routings
acrypto_crypto_lb.c.patch - crypto load balancer's subsystem and main crypto session queues watcher
acrypto_crypto_lb.h.patch - definitions for crypto load balancer processing
acrypto_crypto_main.c.patch - main routings - session allocations/deallocations and so on...
acrypto_crypto_route.h.patch - crypto routing subsystem
acrypto_crypto_stat.c.patch - acrypto statistic helpers
acrypto_crypto_stat.h.patch - acrypto statistic helpers declarations
acrypto_crypto_user.c.patch - base userspace/kernelspace acrypto helpers
acrypto_crypto_user.h.patch - above declarations
acrypto_crypto_user_direct.c.patch - direct process' VMA access helpers
acrypto_crypto_user_direct.h.patch - above declarations
acrypto_crypto_user_ioctl.c.patch - ioctl based userspace access
acrypto_crypto_user_ioctl.h.patch - above declarations
acrypto_simple_lb.c.patch - simple load balancer
alpha arm arm26 cris frv h8300 i386 ia64 m32r m68k
m68knommu mips parisc ppc ppc64 s390 sh sh64 sparc
sparc64 um v850 x86_64 - small patches to enable acrypto config menu

bd.patch - asynchronous block device
ubd.c - userspace utility to configure asynchronous block device
bind unbind - simple scripts to show ubd usage

