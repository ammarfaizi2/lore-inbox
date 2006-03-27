Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWC0Xk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWC0Xk4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWC0Xk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:40:56 -0500
Received: from xenotime.net ([66.160.160.81]:15587 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751154AbWC0Xk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:40:56 -0500
Date: Mon, 27 Mar 2006 15:43:10 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: XFS: 2.6.16-git13 warning??
Message-Id: <20060327154310.c5776847.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fs/xfs/linux-2.6/xfs_ioctl32.c:114: warning: initialization from incompatible pointer type

	vnode_t		*vp = vn_to_inode(inode);

vn_to_inode() wants a vnode, not an inode.

should that be vn_from_inode(inode) ??

thanks,
---
~Randy
