Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbUL1NwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbUL1NwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 08:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbUL1NwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 08:52:06 -0500
Received: from [143.247.20.203] ([143.247.20.203]:61356 "EHLO
	cgx-mail.capitalgenomix.com") by vger.kernel.org with ESMTP
	id S261227AbUL1NwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 08:52:02 -0500
Message-ID: <41D16500.9070903@capitalgenomix.com>
Date: Tue, 28 Dec 2004 08:52:00 -0500
From: "Fao, Sean" <sean.fao@capitalgenomix.com>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Filesystem/kernel bug?
References: <41D02F54.8070107@capitalgenomix.com>
In-Reply-To: <41D02F54.8070107@capitalgenomix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update:

I found these events --and many similar-- in my log file.

Dec 26 17:55:43 cgx-mail ReiserFS: warning: is_tree_node: node level 0 
does not match to the expected one 1
Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-5150: 
search_by_key: invalid format found in block 13706028. Fsck?
Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-13070: 
reiserfs_read_locked_inode: i/o failure occurred trying to find stat 
data of [30749 74887 0x0 SD]
Dec 26 17:55:43 cgx-mail ReiserFS: warning: is_tree_node: node level 0 
does not match to the expected one 1
Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-5150: 
search_by_key: invalid format found in block 13706028. Fsck?
Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-13070: 
reiserfs_read_locked_inode: i/o failure occurred trying to find stat 
data of [30749 74888 0x0 SD]
Dec 26 17:55:43 cgx-mail ReiserFS: warning: is_tree_node: node level 0 
does not match to the expected one 1
Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-5150: 
search_by_key: invalid format found in block 13706028. Fsck?
Dec 26 17:55:43 cgx-mail ReiserFS: sda3: warning: vs-13070: 
reiserfs_read_locked_inode: i/o failure occurred trying to find stat 
data of [30749 74888 0x0 SD]

Does this shed any new light?  Does it look like I might have a 
corrupted file system?

Thanks again,

-- 
Sean
