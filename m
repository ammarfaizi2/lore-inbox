Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbTLJOUh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 09:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbTLJOUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 09:20:37 -0500
Received: from fmx1.freemail.hu ([195.228.242.221]:61571 "HELO
	fmx1.freemail.hu") by vger.kernel.org with SMTP id S263142AbTLJOUg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 09:20:36 -0500
Date: Wed, 10 Dec 2003 15:20:24 +0100 (CET)
From: Max Payne <"max..payne"@freemail.hu>
Subject: Re: [2.6.0-test11] reiserfs io failures
To: linux-kernel@vger.kernel.org
cc: lkml@kcore.org
Message-ID: <freemail.20031110152024.4445@fm3.freemail.hu>
X-Originating-IP: [195.56.253.245]
X-HTTP-User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've got exactly same message on my machines with vanilla
2.6.0-test11 kernel. On my IBM notebook and my desktop. Is
this reiserfs bug?  reiserfsck --rebuild-tree /dev/hdaX
resolved the problem. But very distressing. Any idea?

Thanks:

Max

| is_leaf: free space seems wrong: level=1, nr_items=41, 
free_space=65224 rdkey 
| vs-5150: search_by_key: invalid format found in block
283191. Fsck?
| vs-13070: reiserfs_read_locked_inode: i/o failure occurred
trying to find stat data of [11 12795 0x0 SD]
| is_leaf: free space seems wrong: level=1, nr_items=41,
free_space=65224 rdkey 
| vs-5150: search_by_key: invalid format found in block
283191. Fsck?
| vs-13070: reiserfs_read_locked_inode: i/o failure occurred
trying to find stat data of [11 12798 0x0 SD]


