Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263026AbSKRQoL>; Mon, 18 Nov 2002 11:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbSKRQoK>; Mon, 18 Nov 2002 11:44:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10258 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263026AbSKRQoG>;
	Mon, 18 Nov 2002 11:44:06 -0500
Date: Mon, 18 Nov 2002 16:51:06 +0000
From: Matthew Wilcox <willy@debian.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove sched.h from sctp/sm.h
Message-ID: <20021118165106.L7530@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This header file doesn't need sched.h

diff -urpNX dontdiff linux-2.5.48/include/net/sctp/sm.h linux-2.5.48-header/include/net/sctp/sm.h
--- linux-2.5.48/include/net/sctp/sm.h	2002-11-17 23:29:44.000000000 -0500
+++ linux-2.5.48-header/include/net/sctp/sm.h	2002-11-18 10:17:33.000000000 -0500
@@ -53,7 +53,6 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
-#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/in.h>
 #include <net/sctp/command.h>

-- 
Revolutions do not require corporate support.
