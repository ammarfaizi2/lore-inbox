Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbTH3RKg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 13:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbTH3RKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 13:10:36 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:53704 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261732AbTH3RKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 13:10:34 -0400
Message-ID: <3F50D986.6080707@namesys.com>
Date: Sat, 30 Aug 2003 21:06:14 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: erik@hensema.net
CC: linux-kernel@vger.kernel.org, Nikita Danilov <god@laputa.namesys.com>
Subject: Re: First impressions of reiserfs4
References: <slrnbl12sv.i4g.erik@bender.home.hensema.net>
In-Reply-To: <slrnbl12sv.i4g.erik@bender.home.hensema.net>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Hensema wrote:

>Currently I'm testing reiserfs4 on my otherwise vanilla 2.6.0-test4
>machine.
>
>At first I tried building reiser4 as a module. The kernel failed to link
>due to an unresolved symbol: sys_reiser4
>
compile without sys_reiser4 and not as a module, the config is fixed in 
what will be the next snapshot

>I tried commenting sys_reiser4 out from entry.S. Now the kernel linked
>fine.
>
>However, I can't insert the module due to unexported symbols:
>
>reiser4: Unknown symbol balance_dirty_pages
>reiser4: Unknown symbol max_sane_readahead
>reiser4: Unknown symbol generic_sync_sb_inodes
>reiser4: Unknown symbol truncate_mapping_pages_range
>reiser4: Unknown symbol wakeup_kswapd
>reiser4: Unknown symbol balance_dirty_pages_ratelimited
>reiser4: Unknown symbol inodes_stat
>reiser4: Unknown symbol nr_free_pagecache_pages
>reiser4: Unknown symbol destroy_inode
>
>So, I tried linking reiser4 directly into the kernel. No problems there.
>
>As we speak I'm building Mozilla Firebird from source of a 20 GB reiser4
>partition. If something interesting comes up, this list will be the first
>to know :-)
>
>I've currently got only one small problem: df can't handle the data from
>the kernel it seems. I also got this problem on NFS mounted partitions:
>
fixed in what will be the next snapshot

>
>df: `/reiser4': Value too large for defined data type
>df: `/home': Value too large for defined data type
>
>  
>
thanks for your patience.

nikita, when are you releasing the next snapshot, with the improved 
performance and bug fixes

-- 
Hans


