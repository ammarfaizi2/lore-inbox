Return-Path: <linux-kernel-owner+w=401wt.eu-S1751410AbXAUTOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbXAUTOx (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 14:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbXAUTOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 14:14:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4217 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751419AbXAUTNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 14:13:51 -0500
Date: Sun, 21 Jan 2007 20:13:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: [-mm patch] remove one remaining "#define BCM_TSO 1"
Message-ID: <20070121191357.GQ9093@stusta.de>
References: <20070111222627.66bb75ab.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070111222627.66bb75ab.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 10:26:27PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.20-rc3-mm1:
>...
>  git-netdev-all.patch
>...
>  git trees
>...

Since it's no longer used, this "#define BCM_TSO 1" can now be removed.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.20-rc4-mm1/drivers/net/bnx2.c.old	2007-01-21 18:25:52.000000000 +0100
+++ linux-2.6.20-rc4-mm1/drivers/net/bnx2.c	2007-01-21 18:25:58.000000000 +0100
@@ -42,7 +42,6 @@
 #include <net/ip.h>
 #include <net/tcp.h>
 #include <net/checksum.h>
-#define BCM_TSO 1
 #include <linux/workqueue.h>
 #include <linux/crc32.h>
 #include <linux/prefetch.h>

