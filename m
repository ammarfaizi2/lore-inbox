Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266364AbUGBFRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266364AbUGBFRi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 01:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266484AbUGBFRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 01:17:37 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:13750 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S266459AbUGBFRe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 01:17:34 -0400
Message-ID: <40E4EF82.9000803@blue-labs.org>
Date: Fri, 02 Jul 2004 01:15:46 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040627
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.6.7 reiserfs superblock stuff
Content-Type: multipart/mixed;
 boundary="------------090106060508010901050806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090106060508010901050806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is copied by hand, some translation errors may exist and some 
content is missing.

__find_get_block+227
__getblk+31
do_journal_end+600
do_journal_begin_r+54
pdflush+0
reiserfs_sync_fs+273
sync_supers+466
wb_kupdate+53
thread_return+41
pdflush+0
__pdflush+1175
pdflush+28
wb+kupdate+0
kthread+136
keventd_create_kthread+0
child_rip+8
keventd_create_kthread+0
pdflush+0
pdflush+0
child_rip+0

Code: 4c 39 6b 20 75 08 49 89 df ff 43 08 eb 4e 8b 5b 10 48 39

RIP: __find_get_block_slow+304

fs/buffer.c:514 spin_lock (fs/inode.c: 000001003fef6800) already locked 
by fs/buffer.c/514


Opteron 64bit, reiserfs / partition.

David


--------------090106060508010901050806
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------090106060508010901050806--
