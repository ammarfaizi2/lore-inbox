Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130026AbRALAm0>; Thu, 11 Jan 2001 19:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131310AbRALAmQ>; Thu, 11 Jan 2001 19:42:16 -0500
Received: from d-dialin-1397.addcom.de ([62.96.164.205]:22001 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130026AbRALAl7>; Thu, 11 Jan 2001 19:41:59 -0500
Date: Fri, 12 Jan 2001 01:35:14 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix nfs as module on 2.4.0-pre2
Message-ID: <Pine.LNX.4.30.0101120132570.1288-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Obvious, I guess.

--Kai

diff -ur linux-2.4.1-pre2/net/sunrpc/sunrpc_syms.c linux-2.4.1-pre2-makefixes-3/net/sunrpc/sunrpc_syms.c
--- linux-2.4.1-pre2/net/sunrpc/sunrpc_syms.c	Sat Apr 22 01:08:52 2000
+++ linux-2.4.1-pre2-makefixes-3/net/sunrpc/sunrpc_syms.c	Fri Jan 12 01:00:40 2001
@@ -35,6 +35,7 @@
 EXPORT_SYMBOL(rpciod_down);
 EXPORT_SYMBOL(rpciod_up);
 EXPORT_SYMBOL(rpc_new_task);
+EXPORT_SYMBOL(rpc_release_task);
 EXPORT_SYMBOL(rpc_wake_up_status);

 /* RPC client functions */



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
