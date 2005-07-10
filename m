Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVGJWyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVGJWyU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVGJTij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:38:39 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50908 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262021AbVGJTgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:17 -0400
Date: Sun, 10 Jul 2005 19:36:17 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 69/82] remove linux/version.h from fs/ocfs2/
Message-ID: <20050710193617.69.NcFdfI4100.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

Signed-off-by: Olaf Hering <olh@suse.de>

fs/ocfs2/dlmglue.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/fs/ocfs2/dlmglue.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/fs/ocfs2/dlmglue.c
+++ linux-2.6.13-rc2-mm1/fs/ocfs2/dlmglue.c
@@ -23,7 +23,6 @@
* Boston, MA 021110-1307, USA.
*/

-#include <linux/version.h>
#include <linux/types.h>
#include <linux/slab.h>
#include <linux/highmem.h>
