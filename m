Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbSLEQZm>; Thu, 5 Dec 2002 11:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSLEQZm>; Thu, 5 Dec 2002 11:25:42 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:12048 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261559AbSLEQZi>;
	Thu, 5 Dec 2002 11:25:38 -0500
Date: Thu, 5 Dec 2002 08:33:01 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.50
Message-ID: <20021205163300.GC2865@kroah.com>
References: <20021205163152.GA2865@kroah.com> <20021205163234.GB2865@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021205163234.GB2865@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.797.131.2, 2002/11/30 00:59:35-08:00, greg@kroah.com

LSM: add #include <linux/security.h> to fs/hugetlbfs/inode.c

Thanks to venom@sns.it for pointing this out.


diff -Nru a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
--- a/fs/hugetlbfs/inode.c	Thu Dec  5 01:19:25 2002
+++ b/fs/hugetlbfs/inode.c	Thu Dec  5 01:19:25 2002
@@ -23,6 +23,7 @@
 #include <linux/pagevec.h>
 #include <linux/quotaops.h>
 #include <linux/dnotify.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
