Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271688AbTGREU1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 00:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271689AbTGREU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 00:20:26 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:36579 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S271688AbTGREU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 00:20:26 -0400
Date: Thu, 17 Jul 2003 21:35:15 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: torvalds@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] trivial net/sunrpc/xprt.c #include
Message-ID: <20030717213515.A32026@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	code using this moved to xdr.c in 2.5.74

--- linux-2.6.0-test1/net/sunrpc/xprt.c.orig	Thu Jul 17 21:33:00 2003
+++ linux-2.6.0-test1/net/sunrpc/xprt.c	Thu Jul 17 21:33:05 2003
@@ -66,8 +66,6 @@
 #include <net/udp.h>
 #include <net/tcp.h>
 
-#include <asm/uaccess.h>
-
 /*
  * Local variables
  */
