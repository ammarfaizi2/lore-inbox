Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVGJWyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVGJWyY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVGJTid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:38:33 -0400
Received: from ns1.suse.de ([195.135.220.2]:20371 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262019AbVGJTgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:12 -0400
Date: Sun, 10 Jul 2005 19:36:12 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 64/82] remove linux/version.h from fs/adfs/adfs.h
Message-ID: <20050710193612.64.Gkscog3968.2247.olh@nectarine.suse.de>
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

fs/adfs/adfs.h |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/fs/adfs/adfs.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/fs/adfs/adfs.h
+++ linux-2.6.13-rc2-mm1/fs/adfs/adfs.h
@@ -12,7 +12,6 @@
#define ADFS_NDA_PUBLIC_READ	(1 << 5)
#define ADFS_NDA_PUBLIC_WRITE	(1 << 6)

-#include <linux/version.h>
#include "dir_f.h"

struct buffer_head;
