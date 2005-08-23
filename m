Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVHWT2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVHWT2g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 15:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVHWT2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 15:28:36 -0400
Received: from mail03.solnet.ch ([212.101.4.137]:20684 "EHLO mail03.solnet.ch")
	by vger.kernel.org with ESMTP id S932329AbVHWT2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 15:28:35 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc6-mm2 - complete list of warnings gcc 4.0.1
Date: Tue, 23 Aug 2005 21:25:33 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>
References: <20050822213021.1beda4d5.akpm@osdl.org> <200508231903.36127.damir.perisa@solnet.ch>
In-Reply-To: <200508231903.36127.damir.perisa@solnet.ch>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?utf-8?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/iP?=
 =?utf-8?q?Ov8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B2=7C?=
 =?utf-8?q?l6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?utf-8?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?utf-8?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1177191.FTDbIfKLdq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508232125.36846.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1177191.FTDbIfKLdq
Content-Type: multipart/mixed;
  boundary="Boundary-01=_tg3CDIxlTTv4pX8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_tg3CDIxlTTv4pX8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

just in case somebody is interested in cleaning code or reducing=20
warnings... i disabled the broken net/s2io.o (see my other email in same=20
thread) and recompiled using build-log for output of compile process.=20
grepping for warnings, i found 677 occurances (see attachement).

greetings,
Damir

Le Tuesday 23 August 2005 19:03, Damir Perisa a =E9crit=A0:
| i'm compiling 2.6.13-rc6-mm2 atm and noticed that xfs is having lots of
| warnings while compiling. recently i switched to gcc 4.0.1 - maybe it's
| because of this.

=2D-=20
"Don't blame me. I didn't do it!"

	-- Krusty Gets Busted

--Boundary-01=_tg3CDIxlTTv4pX8
Content-Type: text/plain;
  charset="iso-8859-1";
  name="build-log-2.6.13-rc6-mm2-warnings"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="build-log-2.6.13-rc6-mm2-warnings"

arch/i386/kernel/cpu/transmeta.c:11: warning: 'cpu_freq' may be used uninitialized in this function
arch/i386/kernel/apm.c:1186: warning: 'pm_send_all' is deprecated (declared at include/linux/pm.h:122)
arch/i386/kernel/apm.c:1240: warning: 'pm_send_all' is deprecated (declared at include/linux/pm.h:122)
arch/i386/kernel/apm.c:1361: warning: 'pm_send_all' is deprecated (declared at include/linux/pm.h:122)
kernel/resource.c:482: warning: '__check_region' is deprecated (declared at kernel/resource.c:470)
kernel/intermodule.c:178: warning: 'inter_module_register' is deprecated (declared at kernel/intermodule.c:38)
kernel/intermodule.c:179: warning: 'inter_module_unregister' is deprecated (declared at kernel/intermodule.c:78)
kernel/intermodule.c:181: warning: 'inter_module_put' is deprecated (declared at kernel/intermodule.c:159)
kernel/power/pm.c:258: warning: 'pm_register' is deprecated (declared at kernel/power/pm.c:62)
kernel/power/pm.c:259: warning: 'pm_unregister' is deprecated (declared at kernel/power/pm.c:85)
kernel/power/pm.c:260: warning: 'pm_unregister_all' is deprecated (declared at kernel/power/pm.c:114)
kernel/power/pm.c:261: warning: 'pm_send_all' is deprecated (declared at kernel/power/pm.c:233)
fs/bio.c:167: warning: 'idx' may be used uninitialized in this function
fs/9p/vfs_inode.c:1309: warning: initialization from incompatible pointer type
fs/9p/vfs_inode.c:1310: warning: initialization from incompatible pointer type
fs/configfs/symlink.c:268: warning: initialization from incompatible pointer type
fs/configfs/symlink.c:270: warning: initialization from incompatible pointer type
fs/fuse/dir.c:958: warning: initialization from incompatible pointer type
fs/fuse/dir.c:959: warning: initialization from incompatible pointer type
fs/jfs/jfs_txnmgr.c:1917: warning: 'pxd.addr2' may be used uninitialized in this function
fs/jfs/jfs_txnmgr.c:1917: warning: 'pxd.addr1' may be used uninitialized in this function
fs/jfs/jfs_txnmgr.c:1917: warning: 'pxd.len' may be used uninitialized in this function
fs/nfsd/nfsctl.c:262: warning: 'maxsize' may be used uninitialized in this function
fs/reiser4/seal.c:212:5: warning: "REISER4_DEBUG_OUTPUT" is not defined
fs/reiser4/super.c:381:5: warning: "REISER4_DEBUG_OUTPUT" is not defined
fs/reiser4/inode_ops.c:597: warning: initialization from incompatible pointer type
fs/reiser4/plugin/plugin.c:326:5: warning: "REISER4_DEBUG_OUTPUT" is not defined
fs/reiser4/plugin/cryptcompress.c:600:5: warning: "REISER4_TRACE" is not defined
fs/reiser4/plugin/node/node40.c:448:5: warning: "REISER4_STATS" is not defined
fs/reiser4/plugin/item/sde.c:21:5: warning: "REISER4_DEBUG_OUTPUT" is not defined
fs/reiser4/plugin/item/cde.c:466:5: warning: "REISER4_DEBUG_OUTPUT" is not defined
fs/reiser4/plugin/item/internal.c:213:5: warning: "REISER4_DEBUG_OUTPUT" is not defined
fs/reiser4/plugin/item/ctail.c:198:5: warning: "REISER4_DEBUG_OUTPUT" is not defined
fs/reiser4/plugin/item/item.c:353:5: warning: "REISER4_DEBUG_OUTPUT" is not defined
fs/reiser4/plugin/item/item.c:406:5: warning: "REISER4_DEBUG_OUTPUT" is not defined
fs/reiser4/plugin/item/item.c:463:5: warning: "REISER4_DEBUG_OUTPUT" is not defined
fs/reiser4/plugin/item/item.c:520:5: warning: "REISER4_DEBUG_OUTPUT" is not defined
fs/reiser4/plugin/item/item.c:681:5: warning: "REISER4_DEBUG_OUTPUT" is not defined
fs/reiser4/plugin/item/item.c:741:5: warning: "REISER4_DEBUG_OUTPUT" is not defined
fs/reiser4/plugin/dir/hashed_dir.c:1209:36: warning: "REISER4_STATS" is not defined
fs/udf/balloc.c:756: warning: 'goal_eloc.logicalBlockNum' may be used uninitialized in this function
fs/udf/super.c:1351: warning: 'ino.partitionReferenceNum' may be used uninitialized in this function
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_acl.c:445: warning: 'matched.ae_perm' may be used uninitialized in this function
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_alloc_btree.c:622: warning: 'nrec.ar_startblock' may be used uninitialized in this function
fs/xfs/xfs_alloc_btree.c:622: warning: 'nrec.ar_blockcount' may be used uninitialized in this function
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap.c:2335: warning: 'rtx' is used uninitialized in this function
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.c:2020:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.c:2534:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_dir2_sf.c:110: warning: 'parent' may be used uninitialized in this function
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_dir_leaf.c:653: warning: 'parent' may be used uninitialized in this function
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_ialloc_btree.c:750: warning: 'nrec.ir_free' is used uninitialized in this function
fs/xfs/xfs_ialloc_btree.c:750: warning: 'nrec.ir_freecount' is used uninitialized in this function
fs/xfs/xfs_ialloc_btree.c:567: warning: 'nrec.ir_startino' may be used uninitialized in this function
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_inode_item.c:342:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_inode_item.c:470:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
ipc/msg.c:333: warning: 'setbuf.qbytes' may be used uninitialized in this function
ipc/msg.c:333: warning: 'setbuf.uid' may be used uninitialized in this function
ipc/msg.c:333: warning: 'setbuf.gid' may be used uninitialized in this function
ipc/msg.c:333: warning: 'setbuf.mode' may be used uninitialized in this function
ipc/sem.c:803: warning: 'setbuf.uid' may be used uninitialized in this function
ipc/sem.c:803: warning: 'setbuf.gid' may be used uninitialized in this function
ipc/sem.c:803: warning: 'setbuf.mode' may be used uninitialized in this function
drivers/atm/zatm.c:373: warning: 'vcc' may be used uninitialized in this function
drivers/atm/nicstar.c:2125: warning: 'previous' may be used uninitialized in this function
drivers/atm/iphase.c:961: warning: 'tcnter' defined but not used
drivers/atm/iphase.c:963: warning: 'xdump' defined but not used
drivers/block/DAC960.c:2723: warning: 'ErrorStatus' may be used uninitialized in this function
drivers/block/DAC960.c:2723: warning: 'Parameter0' may be used uninitialized in this function
drivers/block/DAC960.c:2723: warning: 'Parameter1' may be used uninitialized in this function
drivers/char/agp/efficeon-agp.c:222: warning: passing argument 1 of 'virt_to_phys' makes pointer from integer without a cast
drivers/char/agp/via-agp.c:454: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/char/agp/via-agp.c:463: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/char/drm/drm_stub.c:248: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/char/mwave/mwavedd.c:450: warning: 'register_serial' is deprecated (declared at include/linux/serial.h:180)
drivers/char/mwave/mwavedd.c:526: warning: 'unregister_serial' is deprecated (declared at include/linux/serial.h:181)
drivers/char/speakup/synthlist.h:13:35: warning: "CONFIG_SPEAKUP_ACNTPC" is not defined
drivers/char/speakup/synthlist.h:16:35: warning: "CONFIG_SPEAKUP_ACNTSA" is not defined
drivers/char/speakup/synthlist.h:19:35: warning: "CONFIG_SPEAKUP_APOLLO" is not defined
drivers/char/speakup/synthlist.h:22:35: warning: "CONFIG_SPEAKUP_AUDPTR" is not defined
drivers/char/speakup/synthlist.h:25:32: warning: "CONFIG_SPEAKUP_BNS" is not defined
drivers/char/speakup/synthlist.h:28:35: warning: "CONFIG_SPEAKUP_DECEXT" is not defined
drivers/char/speakup/synthlist.h:31:35: warning: "CONFIG_SPEAKUP_DECTLK" is not defined
drivers/char/speakup/synthlist.h:34:33: warning: "CONFIG_SPEAKUP_DTLK" is not defined
drivers/char/speakup/synthlist.h:37:34: warning: "CONFIG_SPEAKUP_KEYPC" is not defined
drivers/char/speakup/synthlist.h:40:33: warning: "CONFIG_SPEAKUP_LTLK" is not defined
drivers/char/speakup/synthlist.h:43:35: warning: "CONFIG_SPEAKUP_SFTSYN" is not defined
drivers/char/speakup/synthlist.h:46:35: warning: "CONFIG_SPEAKUP_SPKOUT" is not defined
drivers/char/speakup/synthlist.h:49:34: warning: "CONFIG_SPEAKUP_TXPRT" is not defined
drivers/char/speakup/synthlist.h:13:35: warning: "CONFIG_SPEAKUP_ACNTPC" is not defined
drivers/char/speakup/synthlist.h:16:35: warning: "CONFIG_SPEAKUP_ACNTSA" is not defined
drivers/char/speakup/synthlist.h:19:35: warning: "CONFIG_SPEAKUP_APOLLO" is not defined
drivers/char/speakup/synthlist.h:22:35: warning: "CONFIG_SPEAKUP_AUDPTR" is not defined
drivers/char/speakup/synthlist.h:25:32: warning: "CONFIG_SPEAKUP_BNS" is not defined
drivers/char/speakup/synthlist.h:28:35: warning: "CONFIG_SPEAKUP_DECEXT" is not defined
drivers/char/speakup/synthlist.h:31:35: warning: "CONFIG_SPEAKUP_DECTLK" is not defined
drivers/char/speakup/synthlist.h:34:33: warning: "CONFIG_SPEAKUP_DTLK" is not defined
drivers/char/speakup/synthlist.h:37:34: warning: "CONFIG_SPEAKUP_KEYPC" is not defined
drivers/char/speakup/synthlist.h:40:33: warning: "CONFIG_SPEAKUP_LTLK" is not defined
drivers/char/speakup/synthlist.h:43:35: warning: "CONFIG_SPEAKUP_SFTSYN" is not defined
drivers/char/speakup/synthlist.h:46:35: warning: "CONFIG_SPEAKUP_SPKOUT" is not defined
drivers/char/speakup/synthlist.h:49:34: warning: "CONFIG_SPEAKUP_TXPRT" is not defined
drivers/char/speakup/synthlist.h:13:35: warning: "CONFIG_SPEAKUP_ACNTPC" is not defined
drivers/char/speakup/synthlist.h:16:35: warning: "CONFIG_SPEAKUP_ACNTSA" is not defined
drivers/char/speakup/synthlist.h:19:35: warning: "CONFIG_SPEAKUP_APOLLO" is not defined
drivers/char/speakup/synthlist.h:22:35: warning: "CONFIG_SPEAKUP_AUDPTR" is not defined
drivers/char/speakup/synthlist.h:25:32: warning: "CONFIG_SPEAKUP_BNS" is not defined
drivers/char/speakup/synthlist.h:28:35: warning: "CONFIG_SPEAKUP_DECEXT" is not defined
drivers/char/speakup/synthlist.h:31:35: warning: "CONFIG_SPEAKUP_DECTLK" is not defined
drivers/char/speakup/synthlist.h:34:33: warning: "CONFIG_SPEAKUP_DTLK" is not defined
drivers/char/speakup/synthlist.h:37:34: warning: "CONFIG_SPEAKUP_KEYPC" is not defined
drivers/char/speakup/synthlist.h:40:33: warning: "CONFIG_SPEAKUP_LTLK" is not defined
drivers/char/speakup/synthlist.h:43:35: warning: "CONFIG_SPEAKUP_SFTSYN" is not defined
drivers/char/speakup/synthlist.h:46:35: warning: "CONFIG_SPEAKUP_SPKOUT" is not defined
drivers/char/speakup/synthlist.h:49:34: warning: "CONFIG_SPEAKUP_TXPRT" is not defined
drivers/char/speakup/synthlist.h:13:35: warning: "CONFIG_SPEAKUP_ACNTPC" is not defined
drivers/char/speakup/synthlist.h:16:35: warning: "CONFIG_SPEAKUP_ACNTSA" is not defined
drivers/char/speakup/synthlist.h:19:35: warning: "CONFIG_SPEAKUP_APOLLO" is not defined
drivers/char/speakup/synthlist.h:22:35: warning: "CONFIG_SPEAKUP_AUDPTR" is not defined
drivers/char/speakup/synthlist.h:25:32: warning: "CONFIG_SPEAKUP_BNS" is not defined
drivers/char/speakup/synthlist.h:28:35: warning: "CONFIG_SPEAKUP_DECEXT" is not defined
drivers/char/speakup/synthlist.h:31:35: warning: "CONFIG_SPEAKUP_DECTLK" is not defined
drivers/char/speakup/synthlist.h:34:33: warning: "CONFIG_SPEAKUP_DTLK" is not defined
drivers/char/speakup/synthlist.h:37:34: warning: "CONFIG_SPEAKUP_KEYPC" is not defined
drivers/char/speakup/synthlist.h:40:33: warning: "CONFIG_SPEAKUP_LTLK" is not defined
drivers/char/speakup/synthlist.h:43:35: warning: "CONFIG_SPEAKUP_SFTSYN" is not defined
drivers/char/speakup/synthlist.h:46:35: warning: "CONFIG_SPEAKUP_SPKOUT" is not defined
drivers/char/speakup/synthlist.h:49:34: warning: "CONFIG_SPEAKUP_TXPRT" is not defined
drivers/char/specialix.c:343: warning: 'check_region' is deprecated (declared at include/linux/ioport.h:124)
drivers/ide/pci/cs5530.c:254: warning: ignoring return value of 'pci_set_mwi', declared with attribute warn_unused_result
drivers/ide/pci/sc1200.c:389: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/ide/pci/sc1200.c:399: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/ide/pci/sc1200.c:401: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/ide/ide-tape.c:2659: warning: ignoring return value of 'copy_from_user', declared with attribute warn_unused_result
drivers/ide/ide-tape.c:2686: warning: ignoring return value of 'copy_to_user', declared with attribute warn_unused_result
drivers/ieee1394/ohci1394.c:3555: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/input/gameport/fm801-gp.c:95: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/isdn/capi/capidrv.c:2108:3: warning: #warning FIXME: maybe a race condition the card should be removed here from global list /kkeil
drivers/isdn/hisax/config.c:636: warning: ignoring return value of 'copy_to_user', declared with attribute warn_unused_result
drivers/isdn/hisax/config.c:647: warning: ignoring return value of 'copy_to_user', declared with attribute warn_unused_result
drivers/isdn/hisax/callc.c:1781: warning: large integer implicitly truncated to unsigned type
drivers/isdn/hisax/hfc_usb.h:190: warning: 'conf_str' defined but not used
drivers/isdn/i4l/isdn_v110.c:523: warning: 'ret' may be used uninitialized in this function
drivers/isdn/i4l/isdn_common.c:1845: warning: ignoring return value of 'copy_from_user', declared with attribute warn_unused_result
drivers/isdn/i4l/isdn_ppp.c:791: warning: ignoring return value of 'copy_to_user', declared with attribute warn_unused_result
drivers/isdn/i4l/isdn_ppp.c:440: warning: 'get_filter' defined but not used
drivers/isdn/icn/icn.c:719:4: warning: #warning TODO test headroom or use skb->nb to flag ACK
drivers/isdn/pcbit/drv.c:730: warning: ignoring return value of 'copy_to_user', declared with attribute warn_unused_result
drivers/isdn/pcbit/drv.c:737: warning: ignoring return value of 'copy_to_user', declared with attribute warn_unused_result
drivers/isdn/pcbit/drv.c:739: warning: ignoring return value of 'copy_to_user', declared with attribute warn_unused_result
drivers/isdn/pcbit/drv.c:746: warning: ignoring return value of 'copy_to_user', declared with attribute warn_unused_result
drivers/isdn/pcbit/layer2.c:305: warning: 'msg' may be used uninitialized in this function
drivers/isdn/sc/shmem.c:60: warning: passing argument 1 of 'memcpy_toio' makes pointer from integer without a cast
drivers/isdn/sc/init.c:492: warning: passing argument 1 of 'readl' makes pointer from integer without a cast
drivers/isdn/sc/init.c:502: warning: passing argument 1 of 'readl' makes pointer from integer without a cast
drivers/isdn/sc/init.c:512: warning: passing argument 1 of 'readl' makes pointer from integer without a cast
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please move your driver to the new sysfs api"
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please move your driver to the new sysfs api"
drivers/media/video/bttv-driver.c:4087: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/media/video/bttv-driver.c:4090: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/media/video/cx88/cx88-video.c:1964: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/media/video/cx88/cx88-video.c:1967: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/media/video/cx88/cx88-mpeg.c:465: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/media/video/cx88/cx88-mpeg.c:468: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/message/fusion/mptbase.c:1390: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/message/fusion/mptbase.c:1413: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/message/fusion/mptbase.c:1415: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/message/fusion/mptctl.c:1737: warning: 'bufIn.len' may be used uninitialized in this function
drivers/message/fusion/mptctl.c:1738: warning: 'bufOut.len' may be used uninitialized in this function
drivers/misc/ibmasm/uart.c:57: warning: 'register_serial' is deprecated (declared at include/linux/serial.h:180)
drivers/misc/ibmasm/uart.c:71: warning: 'unregister_serial' is deprecated (declared at include/linux/serial.h:181)
drivers/net/e1000/e1000_main.c:3702: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/e1000/e1000_main.c:3703: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/e1000/e1000_main.c:3707: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/e1000/e1000_main.c:3708: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/e1000/e1000_main.c:3719: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/e1000/e1000_main.c:3720: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/e1000/e1000_main.c:3735: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/e1000/e1000_main.c:3747: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/e1000/e1000_main.c:3752: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/e1000/e1000_main.c:3753: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/irda/nsc-ircc.c:229: warning: 'pm_unregister_all' is deprecated (declared at include/linux/pm.h:117)
drivers/net/irda/nsc-ircc.c:366: warning: 'pm_register' is deprecated (declared at include/linux/pm.h:107)
drivers/net/irda/ali-ircc.c:231: warning: 'pm_unregister_all' is deprecated (declared at include/linux/pm.h:117)
drivers/net/irda/ali-ircc.c:360: warning: 'pm_register' is deprecated (declared at include/linux/pm.h:107)
drivers/net/irda/vlsi_ir.c:1761: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/irda/vlsi_ir.c:1779: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/irda/vlsi_ir.c:1805: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/sk98lin/skge.c:5160: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/sk98lin/skge.c:5165: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/sk98lin/skge.c:5178: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/sk98lin/skge.c:5180: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/net/tulip/winbond-840.c:1670: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/net/tulip/de2104x.c:2149: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/net/tulip/tulip_core.c:1759: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/tulip/tulip_core.c:1773: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/tulip/tulip_core.c:1776: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/net/wireless/ipw2100.c:6413: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/wireless/ipw2100.c:6610: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/wireless/ipw2100.c:6631: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/wireless/ipw2100.c:6632: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/net/wireless/ipw2200.c:7251: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/wireless/ipw2200.c:7264: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/wireless/ipw2200.c:7265: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/net/wireless/wavelan_cs.c:3613: warning: large integer implicitly truncated to unsigned type
drivers/net/wireless/wavelan_cs.c:3614: warning: large integer implicitly truncated to unsigned type
drivers/net/wireless/orinoco_pci.c:324: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/wireless/orinoco_pci.c:338: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/wireless/airo.c:5509: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/wireless/airo.c:5520: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/wireless/airo.c:5522: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/wireless/hostap/hostap_pci.c:419: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/wireless/hostap/hostap_pci.c:428: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/net/wireless/prism54/islpci_hotplug.c:174: warning: ignoring return value of 'pci_set_mwi', declared with attribute warn_unused_result
drivers/net/wireless/prism54/islpci_hotplug.c:293: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/net/3c59x.c:977: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/3c59x.c:980: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/3c59x.c:991: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/3c59x.c:993: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/net/3c59x.c:1599: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/3c59x.c:1602: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/net/3c59x.c:3070: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/3c59x.c:3076: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/3c59x.c:3263: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/3c59x.c:3266: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/3c59x.c:3290: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/typhoon.c:1908: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/typhoon.c:1919: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/typhoon.c:2634: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/ne2k-pci.c:664: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/ne2k-pci.c:673: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/ne2k-pci.c:675: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/net/eepro100.c:801: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/eepro100.c:976: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/eepro100.c:1926: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/eepro100.c:2056: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/eepro100.c:2067: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/eepro100.c:2292: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/eepro100.c:2302: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/eepro100.c:2304: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/net/e100.c:2549: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/e100.c:2607: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/e100.c:2609: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/e100.c:2619: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/e100.c:2622: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/e100.c:2641: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/sis900.c:2346: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/sis900.c:2361: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/natsemi.c:3222: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/net/skge.c:3268: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/skge.c:3270: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/skge.c:3280: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/skge.c:3282: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/sky2.c:2629: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/sky2.c:2631: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/sky2.c:2641: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/sky2.c:2643: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/via-velocity.c:807: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/via-velocity.c:1745: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/via-velocity.c:1753: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/via-velocity.c:1871: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/via-velocity.c:2198: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/via-velocity.c:2211: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/via-velocity.c:2822: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/via-velocity.c:2838: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/via-velocity.c:3232: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/via-velocity.c:3233: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/via-velocity.c:3238: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/via-velocity.c:3257: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/via-velocity.c:3258: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/starfire.c:848: warning: ignoring return value of 'pci_set_mwi', declared with attribute warn_unused_result
drivers/net/starfire.c:2099: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/hamachi.c:208:5: warning: "ADDRLEN" is not defined
drivers/net/hamachi.c:472:5: warning: "ADDRLEN" is not defined
drivers/net/hamachi.c:880:5: warning: "ADDRLEN" is not defined
drivers/net/hamachi.c:988:5: warning: "ADDRLEN" is not defined
drivers/net/sb1000.c:505: warning: 'st[0]' may be used uninitialized in this function
drivers/net/sb1000.c:551: warning: 'st[1]' may be used uninitialized in this function
drivers/net/sb1000.c:551: warning: 'st[2]' may be used uninitialized in this function
drivers/net/sb1000.c:551: warning: 'st[0]' may be used uninitialized in this function
drivers/net/sb1000.c:514: warning: 'st[0]' may be used uninitialized in this function
drivers/net/sb1000.c:505: warning: 'st[0]' may be used uninitialized in this function
drivers/net/sb1000.c:573: warning: 'st[1]' may be used uninitialized in this function
drivers/net/sb1000.c:573: warning: 'st[2]' may be used uninitialized in this function
drivers/net/sb1000.c:573: warning: 'st[3]' may be used uninitialized in this function
drivers/net/sb1000.c:573: warning: 'st[4]' may be used uninitialized in this function
drivers/net/sb1000.c:573: warning: 'st[0]' may be used uninitialized in this function
drivers/net/sb1000.c:514: warning: 'st[0]' may be used uninitialized in this function
drivers/net/sb1000.c:505: warning: 'st[0]' may be used uninitialized in this function
drivers/net/sb1000.c:505: warning: 'st[0]' may be used uninitialized in this function
drivers/net/sb1000.c:620: warning: 'st[1]' may be used uninitialized in this function
drivers/net/sb1000.c:620: warning: 'st[2]' may be used uninitialized in this function
drivers/net/sb1000.c:620: warning: 'st[0]' may be used uninitialized in this function
drivers/net/sb1000.c:514: warning: 'st[0]' may be used uninitialized in this function
drivers/net/sb1000.c:505: warning: 'st[0]' may be used uninitialized in this function
drivers/net/sb1000.c:514: warning: 'st[0]' may be used uninitialized in this function
drivers/net/sb1000.c:460: warning: 'st[3]' may be used uninitialized in this function
drivers/net/sb1000.c:460: warning: 'st[0]' may be used uninitialized in this function
drivers/net/sb1000.c:489: warning: 'st[1]' may be used uninitialized in this function
drivers/net/sb1000.c:489: warning: 'st[2]' may be used uninitialized in this function
drivers/net/sb1000.c:489: warning: 'st[3]' may be used uninitialized in this function
drivers/net/sb1000.c:489: warning: 'st[4]' may be used uninitialized in this function
drivers/net/sb1000.c:489: warning: 'st[0]' may be used uninitialized in this function
drivers/net/sb1000.c:527: warning: 'st[3]' may be used uninitialized in this function
drivers/net/sb1000.c:527: warning: 'st[0]' may be used uninitialized in this function
drivers/net/sb1000.c:505: warning: 'st[0]' may be used uninitialized in this function
drivers/net/sb1000.c:505: warning: 'st[0]' may be used uninitialized in this function
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please move your driver to the new sysfs api"
drivers/net/b44.c:1943: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please move your driver to the new sysfs api"
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please move your driver to the new sysfs api"
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please move your driver to the new sysfs api"
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please move your driver to the new sysfs api"
drivers/net/3c509.c:366: warning: 'pm_unregister' is deprecated (declared at include/linux/pm.h:112)
drivers/net/3c509.c:576: warning: 'pm_register' is deprecated (declared at include/linux/pm.h:107)
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please move your driver to the new sysfs api"
drivers/net/8139cp.c:1658: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/8139cp.c:1659: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/8139cp.c:1856: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/8139cp.c:1907: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/8139too.c:2591: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/8139too.c:2604: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/cs89x0.c:185: warning: 'netcard_portlist' defined but not used
drivers/net/amd8111e.c:1837: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/amd8111e.c:1838: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/amd8111e.c:1842: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/amd8111e.c:1843: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/amd8111e.c:1847: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/amd8111e.c:1859: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/net/amd8111e.c:1862: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/net/amd8111e.c:1863: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/parport/parport_serial.c:431: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/parport/parport_serial.c:439: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/parport/parport_serial.c:445: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/pcmcia/yenta_socket.c:1015: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/pcmcia/yenta_socket.c:1203: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/pcmcia/yenta_socket.c:1208: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/scsi/aic7xxx/aic79xx_osm.c:1036: warning: ignoring return value of 'scsi_add_host', declared with attribute warn_unused_result
drivers/scsi/aic7xxx/aic79xx_osm_pci.c:173: warning: ignoring return value of 'pci_set_dma_mask', declared with attribute warn_unused_result
drivers/scsi/aic7xxx/aic79xx_osm_pci.c:353: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/scsi/aic7xxx/aic7xxx_pci.c:723: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/scsi/aic7xxx/aic7xxx_pci.c:2013: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/scsi/aic7xxx/aic7xxx_osm.c:1034: warning: ignoring return value of 'scsi_add_host', declared with attribute warn_unused_result
drivers/scsi/arcmsr/arcmsr.c:238:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:249:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:270:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:298:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:397:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:425:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:599:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:620:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:647:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:676:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:745:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:750:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:791:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:821:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:860:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:933:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:960:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:989:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1051:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1098:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1112:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1152:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1222:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1226:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1237:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1249:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1261:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1273:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1297:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1321:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1348:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1418:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1462:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1483:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1511:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1540:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1573:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1589:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1696:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1729:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1902:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1949:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:1971:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:2011:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:2031:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:2113:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:2179:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:2274:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:2387:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:2403:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:2425:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:2493:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:2535:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/arcmsr/arcmsr.c:2572:5: warning: "ARCMSR_DEBUG0" is not defined
drivers/scsi/lpfc/lpfc_sli.c:2056: warning: 'iocb' may be used uninitialized in this function
drivers/scsi/lpfc/lpfc_els.c:1693: warning: 'buf_ptr' may be used uninitialized in this function
drivers/scsi/pcmcia/fdomain_stub.c:220: warning: ignoring return value of 'scsi_add_host', declared with attribute warn_unused_result
drivers/scsi/fdomain.c:425: warning: 'ports' defined but not used
drivers/scsi/fdomain.c:469: warning: 'signatures' defined but not used
drivers/scsi/fdomain.c:652: warning: 'fdomain_get_irq' defined but not used
drivers/scsi/pcmcia/nsp_cs.c:1887: warning: ignoring return value of 'scsi_add_host', declared with attribute warn_unused_result
drivers/scsi/qla2xxx/qla_os.c:1134: warning: ignoring return value of 'pci_set_consistent_dma_mask', declared with attribute warn_unused_result
drivers/scsi/qla2xxx/qla_os.c:1141: warning: ignoring return value of 'pci_set_dma_mask', declared with attribute warn_unused_result
drivers/scsi/qla2xxx/qla_os.c:1144: warning: ignoring return value of 'pci_set_dma_mask', declared with attribute warn_unused_result
drivers/scsi/sata_svw.c:106: warning: passing argument 2 of 'writeb' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:111: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:112: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:113: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:114: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:115: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:117: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:118: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:119: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:120: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:121: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:125: warning: passing argument 2 of 'writeb' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:136: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:137: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:138: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:139: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:140: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:143: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:89: warning: passing argument 1 of 'readb' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:94: warning: passing argument 2 of 'writeb' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:113: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:114: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:115: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:116: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:117: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:119: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:120: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:121: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:122: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:123: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:127: warning: passing argument 2 of 'writeb' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:138: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:139: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:140: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:141: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:142: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:145: warning: passing argument 1 of 'readb' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:254: warning: passing argument 2 of 'writel' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:255: warning: passing argument 2 of 'writel' makes pointer from integer without a cast
drivers/scsi/BusLogic.c:583: warning: 'check_region' is deprecated (declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:585: warning: 'check_region' is deprecated (declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:587: warning: 'check_region' is deprecated (declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:589: warning: 'check_region' is deprecated (declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:591: warning: 'check_region' is deprecated (declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:593: warning: 'check_region' is deprecated (declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:799: warning: 'check_region' is deprecated (declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:809: warning: 'check_region' is deprecated (declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:811: warning: 'check_region' is deprecated (declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:813: warning: 'check_region' is deprecated (declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:815: warning: 'check_region' is deprecated (declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:817: warning: 'check_region' is deprecated (declared at include/linux/ioport.h:124)
drivers/scsi/BusLogic.c:2299: warning: ignoring return value of 'scsi_add_host', declared with attribute warn_unused_result
drivers/scsi/BusLogic.c:2960: warning: 'BusLogic_AbortCommand' defined but not used
drivers/scsi/ultrastor.c:303: warning: matching constraint does not allow a register
drivers/scsi/ultrastor.c:302: warning: matching constraint does not allow a register
drivers/scsi/ultrastor.c:698: warning: matching constraint does not allow a register
drivers/scsi/ultrastor.c:698: warning: matching constraint does not allow a register
drivers/scsi/ultrastor.c:698: warning: matching constraint does not allow a register
drivers/scsi/ultrastor.c:698: warning: matching constraint does not allow a register
drivers/scsi/ultrastor.c:698: warning: matching constraint does not allow a register
drivers/scsi/ultrastor.c:698: warning: matching constraint does not allow a register
drivers/scsi/ultrastor.c:698: warning: matching constraint does not allow a register
drivers/scsi/ultrastor.c:302: warning: matching constraint does not allow a register
drivers/scsi/ultrastor.c:302: warning: matching constraint does not allow a register
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please move your driver to the new sysfs api"
drivers/scsi/aha1740.c:645: warning: ignoring return value of 'scsi_add_host', declared with attribute warn_unused_result
drivers/scsi/ips.c:7058: warning: ignoring return value of 'scsi_add_host', declared with attribute warn_unused_result
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please move your driver to the new sysfs api"
drivers/scsi/fd_mcs.c:298: warning: 'fd_mcs_setup' defined but not used
drivers/scsi/NCR5380.c:91:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:953:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2122:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2734:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2734:16: warning: "NDEBUG_ABORT" is not defined
drivers/scsi/NCR5380.c:701: warning: 'notyet_generic_proc_info' defined but not used
drivers/scsi/NCR5380.c:91:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:953:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2122:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2734:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2734:16: warning: "NDEBUG_ABORT" is not defined
drivers/scsi/NCR5380.c:701: warning: 'notyet_generic_proc_info' defined but not used
drivers/scsi/NCR53c406a.c:65:5: warning: "DEBUG" is not defined
drivers/scsi/NCR53c406a.c:610: warning: 'NCR53c406a_setup' defined but not used
drivers/scsi/ncr53c8xx.c:7622: warning: 'ncr53c8xx_setup' defined but not used
drivers/scsi/NCR5380.c:91:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:953:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2122:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2734:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2734:16: warning: "NDEBUG_ABORT" is not defined
drivers/scsi/NCR5380.c:352: warning: 'phases' defined but not used
drivers/scsi/NCR5380.c:91:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:953:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2122:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2734:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2734:16: warning: "NDEBUG_ABORT" is not defined
drivers/scsi/NCR5380.c:352: warning: 'phases' defined but not used
drivers/scsi/NCR5380.c:91:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:953:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2122:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2734:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2734:16: warning: "NDEBUG_ABORT" is not defined
drivers/scsi/NCR5380.c:626: warning: 'NCR5380_print_options' defined but not used
drivers/scsi/NCR5380.c:701: warning: 'NCR5380_proc_info' defined but not used
drivers/scsi/NCR5380.c:352: warning: 'phases' defined but not used
drivers/scsi/NCR5380.c:572: warning: 'NCR5380_probe_irq' defined but not used
drivers/scsi/NCR5380.c:91:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:953:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2122:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2734:6: warning: "NDEBUG" is not defined
drivers/scsi/NCR5380.c:2734:16: warning: "NDEBUG_ABORT" is not defined
drivers/scsi/NCR5380.c:352: warning: 'phases' defined but not used
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please move your driver to the new sysfs api"
drivers/scsi/dc395x.c:4276: warning: 'ptr' may be used uninitialized in this function
drivers/scsi/nsp32.c:2888: warning: ignoring return value of 'scsi_add_host', declared with attribute warn_unused_result
drivers/scsi/nsp32.c:3449: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/scsi/nsp32.c:3463: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/scsi/nsp32.c:3464: warning: ignoring return value of 'pci_enable_wake', declared with attribute warn_unused_result
drivers/serial/serial_core.c:2436: warning: 'uart_register_port' is deprecated (declared at drivers/serial/serial_core.c:2357)
drivers/serial/serial_core.c:2437: warning: 'uart_unregister_port' is deprecated (declared at drivers/serial/serial_core.c:2414)
drivers/serial/8250.c:2737: warning: 'register_serial' is deprecated (declared at drivers/serial/8250.c:2693)
drivers/serial/8250.c:2753: warning: 'unregister_serial' is deprecated (declared at drivers/serial/8250.c:2750)
drivers/serial/8250_pci.c:1705: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/serial/8250_pci.c:1713: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/serial/8250_pci.c:1720: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
drivers/telephony/ixj.c:3448: warning: 'blankword.high' may be used uninitialized in this function
drivers/telephony/ixj.c:3448: warning: 'blankword.low' may be used uninitialized in this function
drivers/telephony/ixj.c:4841: warning: 'bytes.high' may be used uninitialized in this function
drivers/usb/input/keyspan_remote.c:185: warning: 'message.toggle' may be used uninitialized in this function
drivers/usb/net/net1080.c:432: warning: unused variable 'net'
drivers/usb/gadget/net2280.c:2905: warning: ignoring return value of 'pci_set_mwi', declared with attribute warn_unused_result
drivers/video/savage/savagefb_driver.c:2214: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/video/savage/savagefb_driver.c:2236: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/video/savage/savagefb_driver.c:2242: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/video/i810/i810_main.c:1533: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/video/i810/i810_main.c:1547: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/video/i810/i810_main.c:1548: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
sound/core/oss/route.c:207: warning: 'src' may be used uninitialized in this function
sound/pci/atiixp_modem.c:1118: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
sound/pci/atiixp_modem.c:1128: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
sound/pci/atiixp_modem.c:1129: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
sound/pci/atiixp.c:1429: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
sound/pci/atiixp.c:1439: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
sound/pci/atiixp.c:1440: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
sound/pci/cs4281.c:1353: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
sound/pci/cs4281.c:2091: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
sound/pci/ens1370.c:1889: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
sound/pci/ens1370.c:1889: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
sound/pci/es1938.c:1410: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
sound/pci/es1968.c:2183: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
sound/pci/es1968.c:2429: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
sound/pci/intel8x0.c:2399: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
sound/pci/intel8x0m.c:1088: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
sound/pci/maestro3.c:2617: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
sound/pci/via82xx_modem.c:1018: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
sound/pci/via82xx_modem.c:1028: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
sound/pci/via82xx_modem.c:1029: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
sound/pci/via82xx.c:1980: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
sound/pci/via82xx.c:1990: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
sound/pci/via82xx.c:1991: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
sound/pci/ali5451/ali5451.c:2070: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
sound/pci/au88x0/au88x0.c:151: warning: ignoring return value of 'pci_set_dma_mask', declared with attribute warn_unused_result
sound/pci/au88x0/au88x0.c:151: warning: ignoring return value of 'pci_set_dma_mask', declared with attribute warn_unused_result
sound/pci/au88x0/au88x0.c:151: warning: ignoring return value of 'pci_set_dma_mask', declared with attribute warn_unused_result
sound/pci/cs46xx/cs46xx_lib.c:3727: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
sound/pci/hda/hda_intel.c:1235: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
sound/pci/nm256/nm256.c:1332: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
sound/pci/trident/trident_main.c:3950: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
sound/pci/ymfpci/ymfpci_main.c:2232: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
lib/zlib_inflate/inftrees.c:121: warning: 'r.base' may be used uninitialized in this function

--Boundary-01=_tg3CDIxlTTv4pX8--

--nextPart1177191.FTDbIfKLdq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDC3gwPABWKV6NProRAjNcAJ9ojTRxg2TMbYNdHDzSaN9rzo9EbgCgrjLx
rWWnqS0P7tBCVjOfkfD3XpU=
=yK4n
-----END PGP SIGNATURE-----

--nextPart1177191.FTDbIfKLdq--
