Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVJNQSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVJNQSD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 12:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVJNQSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 12:18:03 -0400
Received: from laska.dorms.spbu.ru ([195.19.252.72]:47745 "EHLO
	laska.dorms.spbu.ru") by vger.kernel.org with ESMTP
	id S1750770AbVJNQSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 12:18:00 -0400
From: Mikhail Kshevetskiy <kl@laska.dorms.spbu.ru>
Message-Id: <200510141617.j9EGHsi4021092@laska.dorms.spbu.ru>
Date: Fri, 14 Oct 2005 20:17:54 +0400
To: linux-kernel@vger.kernel.org
Subject: Reiser4 mounting problem on ARM
User-Agent: nail 11.24 7/14/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The module loaded without errors, but during mounting the following
messages appear in dmesg

[99002.467987] d_cursor_hash_table: 256 buckets
[99003.150054] z_hash_table: 8192 buckets
[99003.154205] z_hash_table: 8192 buckets
[99003.158538] j_hash_table: 16384 buckets
[99003.162811] loading reiser4 bitmap......done (31 jiffies)
[99003.428894] reiser4[mount(2029)]: parse_node40 (fs/reiser4/plugin/node/node40.c:673)[nikita-494]:
[99003.438323] code: -2 at fs/reiser4/search.c:1225
[99003.443237] WARNING: Wrong level found in node: 2 != 24
[99003.448913] reiser4[mount(2029)]: key_warning (fs/reiser4/plugin/file_plugin_common.c:489)[nikita-717]:
[99003.458801] code: -5 at fs/reiser4/plugin/node/node40.c:684
[99003.464752] WARNING: Error for inode 42 (-5)
[99003.469268] for key: (29:1:0:0:2a:0)[stat data]

Thanks,
Mikhail Kshevetskiy
