Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbVAFJZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbVAFJZT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 04:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbVAFJZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 04:25:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:52454 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262790AbVAFJZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 04:25:14 -0500
Date: Thu, 6 Jan 2005 01:24:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2
Message-Id: <20050106012458.66ea7812.akpm@osdl.org>
In-Reply-To: <41DD00DA.4070307@eyal.emu.id.au>
References: <20050106002240.00ac4611.akpm@osdl.org>
	<41DD00DA.4070307@eyal.emu.id.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
>
> scripts/Makefile.clean:10: fs/umsdos/Makefile: No such file or directory
>  make[2]: *** No rule to make target `fs/umsdos/Makefile'.  Stop.

--- 25/fs/Makefile~remove-umsdos-from-tree-fix	2005-01-06 01:24:17.694520824 -0800
+++ 25-akpm/fs/Makefile	2005-01-06 01:24:21.234982592 -0800
@@ -59,7 +59,6 @@ obj-$(CONFIG_HUGETLBFS)		+= hugetlbfs/
 obj-$(CONFIG_CODA_FS)		+= coda/
 obj-$(CONFIG_MINIX_FS)		+= minix/
 obj-$(CONFIG_FAT_FS)		+= fat/
-obj-$(CONFIG_UMSDOS_FS)		+= umsdos/
 obj-$(CONFIG_MSDOS_FS)		+= msdos/
 obj-$(CONFIG_VFAT_FS)		+= vfat/
 obj-$(CONFIG_BFS_FS)		+= bfs/
_

