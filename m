Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310296AbSCBDXd>; Fri, 1 Mar 2002 22:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310298AbSCBDXY>; Fri, 1 Mar 2002 22:23:24 -0500
Received: from [210.214.0.152] ([210.214.0.152]:3713 "EHLO partha.home.net")
	by vger.kernel.org with ESMTP id <S310296AbSCBDXQ>;
	Fri, 1 Mar 2002 22:23:16 -0500
Message-ID: <3C80945C.4CDBB229@yahoo.com>
Date: Sat, 02 Mar 2002 08:59:08 +0000
From: Bhasker C V <spssjp@yahoo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem compiling lvm with kernel 2.5.5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

 there is a problem compiling lvm and raid modules ( either as module or internal to kernel )
for kernel version 2.5.5

 the error is as follows
lvm.c:240: warning: `struct bio' declared inside parameter list
lvm.c:240: warning: its scope is only this definition or declaration, which is probably not what you want.
lvm.c:266: warning: `struct bio' declared inside parameter list
lvm.c:272: parse error before `userlv_t'
lvm.c:273: parse error before `userlv_t'
lvm.c:275: parse error before `userlv_t'
lvm.c:295: warning: `struct bio' declared inside parameter list
lvm.c:311: parse error before `LVM_RELEASE_NAME'
lvm.c:363: unknown field `owner' specified in initializer
lvm.c:363: warning: initialization from incompatible pointer type
lvm.c:364: field `open' already initialized
lvm.c:365: field `release' already initialized
lvm.c:365: warning: initialization from incompatible pointer type
lvm.c:366: field `ioctl' already initialized
--- snipped ----

However older ( k 2.4.7-10) lvm compiles fine except that i am not able to load it into the kernel at runtime ( version mismatch and if i do a force insmod then it shows unresolved symbol

lvm.o: unresolved symbol lvm_hash_link
lvm.o: unresolved symbol lvm_snapshot_fill_COW_page
lvm.o: unresolved symbol lvm_snapshot_alloc
lvm.o: unresolved symbol lvm_drop_snapshot
lvm.o: unresolved symbol lvm_init_fs
lvm.o: unresolved symbol lvm_snapshot_release
lvm.o: unresolved symbol lvm_fs_remove_vg
lvm.o: unresolved symbol lvm_fin_fs
lvm.o: unresolved symbol lvm_snapshot_remap_block
lvm.o: unresolved symbol gendisk_head
lvm.o: unresolved symbol lvm_fs_remove_lv
lvm.o: unresolved symbol lvm_write_COW_table_block
lvm.o: unresolved symbol lvm_fs_remove_pv
lvm.o: unresolved symbol lvm_fs_create_vg
lvm.o: unresolved symbol lvm_fs_create_lv
lvm.o: unresolved symbol lvm_snapshot_COW
lvm.o: unresolved symbol lvm_get_blksize
lvm.o: unresolved symbol lvm_snapshot_alloc_hash_table
lvm.o: unresolved symbol lvm_fs_create_pv
lvm.o: unresolved symbol hardsect_size



--
Bye,
Bhasker C V
Web: http://spssjp.8m.com

If you want to feel rich, just count all the things you have that money can't buy



