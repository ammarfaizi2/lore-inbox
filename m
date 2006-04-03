Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751633AbWDCOr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbWDCOr1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 10:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbWDCOr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 10:47:26 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42628 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751479AbWDCOr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 10:47:26 -0400
Message-Id: <200604030521.k335LRu4018913@laptop11.inf.utfsm.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.17-rc1 compile failure
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 03 Apr 2006 01:21:27 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 03 Apr 2006 10:47:19 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It ends with:

  CC      security/selinux/xfrm.o
  security/selinux/xfrm.c: In function ‘selinux_socket_getpeer_dgram’:
  security/selinux/xfrm.c:284: error: ‘struct sec_path’ has no member named ‘x’
  security/selinux/xfrm.c: In function ‘selinux_xfrm_sock_rcv_skb’:
  security/selinux/xfrm.c:317: error: ‘struct sec_path’ has no member named ‘x’
  make[2]: *** [security/selinux/xfrm.o] Error 1
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
