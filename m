Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbUL1Qno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbUL1Qno (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 11:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbUL1QmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 11:42:12 -0500
Received: from apachihuilliztli.mtu.ru ([195.34.32.124]:6156 "EHLO
	Apachihuilliztli.mtu.ru") by vger.kernel.org with ESMTP
	id S261257AbUL1Q1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 11:27:32 -0500
Subject: Re: Filesystem/kernel bug?
From: Vladimir Saveliev <vs@namesys.com>
To: "Fao, Sean" <sean.fao@capitalgenomix.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <41D16500.9070903@capitalgenomix.com>
References: <41D02F54.8070107@capitalgenomix.com>
	 <41D16500.9070903@capitalgenomix.com>
Content-Type: text/plain
Message-Id: <1104251242.3568.30.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 28 Dec 2004 19:27:23 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Tue, 2004-12-28 at 16:52, Fao, Sean wrote:
> Update:
> 
> I found these events --and many similar-- in my log file.
> 
> Dec 26 17:55:43 cgx-mail ReiserFS: warning: is_tree_node: node level 0 
> does not match to the expected one 1
> Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-5150: 
> search_by_key: invalid format found in block 13706028. Fsck?
> Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-13070: 
> reiserfs_read_locked_inode: i/o failure occurred trying to find stat 
> data of [30749 74887 0x0 SD]
> Dec 26 17:55:43 cgx-mail ReiserFS: warning: is_tree_node: node level 0 
> does not match to the expected one 1
> Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-5150: 
> search_by_key: invalid format found in block 13706028. Fsck?
> Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-13070: 
> reiserfs_read_locked_inode: i/o failure occurred trying to find stat 
> data of [30749 74888 0x0 SD]
> Dec 26 17:55:43 cgx-mail ReiserFS: warning: is_tree_node: node level 0 
> does not match to the expected one 1
> Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-5150: 
> search_by_key: invalid format found in block 13706028. Fsck?
> Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-13070: 
> reiserfs_read_locked_inode: i/o failure occurred trying to find stat 
> data of [30749 74888 0x0 SD]
> 
> Does this shed any new light?  Does it look like I might have a 
> corrupted file system?
> 

Yes. Please try to reiserfsck your filesystem. Latest reiserfsck can be
obtained from
ftp://ftp.namesys.com/pub/reiserfsprogs/reiserfsprogs-3.6.19.tar.gz.

> Thanks again,

