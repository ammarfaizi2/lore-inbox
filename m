Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWHLRDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWHLRDj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWHLRCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:02:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:16434 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964917AbWHLRCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:02:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=PO3uA16Qp/wPzygtGvkUzk4aYFUynJivzXqc5dfzbrGaL07+lTG7bZYHmav/WdU/TxOwxPUxHqh6QbWIRBG8eLpOGS2R3S01LHnO8BKkXiwVvvcCT557TEoJGRfFiIbUb0eHJw3WGUmRj40APi/xrPPObp/ucKgNhJNr+Twy02c=
Message-ID: <44DE09CA.6020808@gmail.com>
Date: Sat, 12 Aug 2006 19:03:06 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH 10/10] fs/jffs2/jffs2_fs_i.h Removal of old code
References: <44DE05FC.2090001@gmail.com>
In-Reply-To: <44DE05FC.2090001@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/fs/jffs2/jffs2_fs_i.h linux-work/fs/jffs2/jffs2_fs_i.h
--- linux-work-clean/fs/jffs2/jffs2_fs_i.h	2006-08-12 01:51:17.000000000 +0200
+++ linux-work/fs/jffs2/jffs2_fs_i.h	2006-08-12 17:53:04.000000000 +0200
@@ -42,10 +42,8 @@ struct jffs2_inode_info {
 	uint16_t flags;
 	uint8_t usercompr;
 #if !defined (__ECOS)
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,2)
 	struct inode vfs_inode;
 #endif
-#endif
 #ifdef CONFIG_JFFS2_FS_POSIX_ACL
 	struct posix_acl *i_acl_access;
 	struct posix_acl *i_acl_default;

