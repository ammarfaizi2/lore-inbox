Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUAQOyM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 09:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266049AbUAQOyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 09:54:12 -0500
Received: from heavymos.kumin.ne.jp ([61.114.158.133]:58059 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP id S266048AbUAQOyK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 09:54:10 -0500
Message-Id: <200401171453.AA00009@prism.kumin.ne.jp>
Date: Sat, 17 Jan 2004 23:53:41 +0900
To: linux-kernel@vger.kernel.org
Cc: <tao@acc.umu.se>
Subject: linux-2.0.40-rc7
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
In-Reply-To: <200303041229.AA00001@prism.kumin.ne.jp>
References: <200303041229.AA00001@prism.kumin.ne.jp>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I update linux-2.0.40-rc7 from 2.0.40-rc6.
But compile error occured.

=====

ialloc.c: In function `ext2_new_inode':
ialloc.c:302: warning: `bh2' might be used uninitialized in this function
ialloc.c:452: warning: `bh' might be used uninitialized in this function
skbuff.c: In function `skb_copy_grow':
skbuff.c:960: structure has no member named `priority'
skbuff.c:960: structure has no member named `priority'
skbuff.c:962: structure has no member named `dst'
skbuff.c:962: warning: implicit declaration of function `dst_clone'
skbuff.c:962: structure has no member named `dst'
skbuff.c:964: structure has no member named `nh'
skbuff.c:964: structure has no member named `nh'
skbuff.c:966: structure has no member named `cb'
skbuff.c:966: structure has no member named `cb'
skbuff.c:966: structure has no member named `cb'
skbuff.c:966: structure has no member named `cb'
skbuff.c:966: structure has no member named `cb'
skbuff.c:966: structure has no member named `cb'
skbuff.c:966: structure has no member named `cb'
skbuff.c:968: structure has no member named `is_clone'
skbuff.c:969: warning: implicit declaration of function `atomic_set'
skbuff.c:973: structure has no member named `security'
skbuff.c:973: structure has no member named `security'
skbuff.c: In function `skb_pad':
skbuff.c:991: too few arguments to function `kfree_skb'
make[3]: *** [skbuff.o] Error 1
make[2]: *** [first_rule] Error 2
make[1]: *** [sub_dirs] Error 2
make: *** [linuxsubdirs] Error 2

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
