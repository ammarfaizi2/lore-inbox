Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289741AbSBJUyM>; Sun, 10 Feb 2002 15:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289748AbSBJUyC>; Sun, 10 Feb 2002 15:54:02 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:42514 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S289741AbSBJUxq>; Sun, 10 Feb 2002 15:53:46 -0500
Subject: 2.5.4-pre5 -- Loads of errors compiling raid5.c
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 10 Feb 2002 12:50:35 -0800
Message-Id: <1013374235.29598.12.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_LVM=m

In file included from raid5.c:23:
/usr/src/linux/include/linux/raid/raid5.h:218: parse error before
`md_wait_queue_head_t'
/usr/src/linux/include/linux/raid/raid5.h:218: warning: no semicolon at
end of struct or union
/usr/src/linux/include/linux/raid/raid5.h:222: parse error before
`device_lock'
/usr/src/linux/include/linux/raid/raid5.h:222: warning: type defaults to
`int' in declaration of `device_lock'
/usr/src/linux/include/linux/raid/raid5.h:222: warning: data definition
has no type or storage class
/usr/src/linux/include/linux/raid/raid5.h:226: parse error before `}'
raid5.c: In function `__release_stripe':
raid5.c:67: dereferencing pointer to incomplete type
...
raid5.c: In function `release_stripe':
raid5.c:94: dereferencing pointer to incomplete type
raid5.c:96: dereferencing pointer to incomplete type
raid5.c: In function `insert_hash':
raid5.c:113: dereferencing pointer to incomplete type
raid5.c:113: dereferencing pointer to incomplete type
raid5.c:117: dereferencing pointer to incomplete type
raid5.c: In function `get_free_stripe':
raid5.c:131: dereferencing pointer to incomplete type
raid5.c:132: dereferencing pointer to incomplete type
raid5.c:134: dereferencing pointer to incomplete type
raid5.c:138: dereferencing pointer to incomplete type
raid5.c:129: warning: `first' might be used uninitialized in this
function
raid5.c: In function `init_stripe':
raid5.c:189: dereferencing pointer to incomplete type
raid5.c:196: dereferencing pointer to incomplete type
raid5.c:202: dereferencing pointer to incomplete type
raid5.c: In function `shrink_stripe_cache':
raid5.c:226: dereferencing pointer to incomplete type
raid5.c:227: dereferencing pointer to incomplete type
raid5.c:231: dereferencing pointer to incomplete type
raid5.c: In function `__find_stripe':
raid5.c:240: dereferencing pointer to incomplete type
raid5.c:242: dereferencing pointer to incomplete type
raid5.c:242: dereferencing pointer to incomplete type
raid5.c:238: warning: `sh' might be used uninitialized in this function
raid5.c: In function `get_active_stripe':
raid5.c:255: warning: implicit declaration of function
`md_spin_lock_irq'
raid5.c:255: dereferencing pointer to incomplete type
...
raid5.c:329: warning: implicit declaration of function
`md_spin_unlock_irq'
raid5.c:329: dereferencing pointer to incomplete type
raid5.c: In function `grow_stripes':
raid5.c:345: dereferencing pointer to incomplete type
raid5.c:346: dereferencing pointer to incomplete type
raid5.c:352: dereferencing pointer to incomplete type
raid5.c: In function `shrink_stripes':
raid5.c:364: dereferencing pointer to incomplete type
raid5.c:366: dereferencing pointer to incomplete type
raid5.c:371: dereferencing pointer to incomplete type
raid5.c:373: dereferencing pointer to incomplete type
raid5.c: In function `raid5_end_read_request':
raid5.c:382: dereferencing pointer to incomplete type
raid5.c:397: dereferencing pointer to incomplete type
raid5.c:408: structure has no member named `b_reqnext'
raid5.c:409: structure has no member named `b_reqnext'
raid5.c:412: dereferencing pointer to incomplete type
raid5.c:421: dereferencing pointer to incomplete type
raid5.c: In function `raid5_end_write_request':
raid5.c:440: dereferencing pointer to incomplete type
raid5.c:453: warning: implicit declaration of function
`md_spin_lock_irqsave'
raid5.c:453: dereferencing pointer to incomplete type
raid5.c:455: dereferencing pointer to incomplete type
raid5.c:459: warning: implicit declaration of function
`md_spin_unlock_irqrestore'
raid5.c:459: dereferencing pointer to incomplete type
raid5.c: In function `raid5_build_block':
raid5.c:471: dereferencing pointer to incomplete type
raid5.c: In function `raid5_error':
raid5.c:490: dereferencing pointer to incomplete type
raid5.c:490: warning: value computed is not used
raid5.c:490: dereferencing pointer to incomplete type
...
raid5.c:485: warning: `disk' might be used uninitialized in this
function
raid5.c: In function `raid5_compute_sector':
raid5.c:557: dereferencing pointer to incomplete type
raid5.c:580: dereferencing pointer to incomplete type
raid5.c:582: dereferencing pointer to incomplete type
raid5.c:583: case label not within a switch statement
raid5.c:587: break statement not within loop or switch
raid5.c:588: case label not within a switch statement
raid5.c:592: break statement not within loop or switch
raid5.c:593: case label not within a switch statement
raid5.c:596: break statement not within loop or switch
raid5.c:597: case label not within a switch statement
raid5.c:600: break statement not within loop or switch
raid5.c:601: default label not within a switch statement
raid5.c:602: dereferencing pointer to incomplete type
raid5.c: In function `compute_block':
raid5.c:664: dereferencing pointer to incomplete type
raid5.c: In function `compute_parity':
raid5.c:692: dereferencing pointer to incomplete type
raid5.c:712: structure has no member named `b_reqnext'
raid5.c:713: structure has no member named `b_reqnext'
raid5.c:724: structure has no member named `b_reqnext'
raid5.c:725: structure has no member named `b_reqnext'
raid5.c: In function `add_stripe_bh':
raid5.c:784: dereferencing pointer to incomplete type
raid5.c:785: structure has no member named `b_reqnext'
raid5.c:792: structure has no member named `b_reqnext'
raid5.c:795: dereferencing pointer to incomplete type
raid5.c: In function `handle_stripe':
raid5.c:826: dereferencing pointer to incomplete type
raid5.c:852: dereferencing pointer to incomplete type
raid5.c:855: dereferencing pointer to incomplete type
raid5.c:861: structure has no member named `b_reqnext'
raid5.c:862: structure has no member named `b_reqnext'
raid5.c:876: dereferencing pointer to incomplete type
raid5.c:891: structure has no member named `b_reqnext'
raid5.c:892: structure has no member named `b_reqnext'
raid5.c:896: dereferencing pointer to incomplete type
raid5.c:897: dereferencing pointer to incomplete type
raid5.c:900: structure has no member named `b_reqnext'
raid5.c:901: structure has no member named `b_reqnext'
raid5.c:904: dereferencing pointer to incomplete type
raid5.c:909: dereferencing pointer to incomplete type
raid5.c:919: dereferencing pointer to incomplete type
raid5.c:926: dereferencing pointer to incomplete type
raid5.c:934: structure has no member named `b_reqnext'
raid5.c:935: structure has no member named `b_reqnext'
raid5.c:958: dereferencing pointer to incomplete type
raid5.c:964: structure has no member named `b_reqnext'
raid5.c:973: dereferencing pointer to incomplete type
...
raid5.c:1118: structure has no member named `b_reqnext'
raid5.c:1119: structure has no member named `b_reqnext'
raid5.c:1123: structure has no member named `b_reqnext'
raid5.c:1124: structure has no member named `b_reqnext'
raid5.c:1130: dereferencing pointer to incomplete type
raid5.c:1136: dereferencing pointer to incomplete type
raid5.c:1137: dereferencing pointer to incomplete type
raid5.c:1145: structure has no member named `b_rdev'
raid5.c:1146: structure has no member named `b_rsector'
raid5.c:1147: warning: passing arg 1 of `generic_make_request' makes
pointer from integer without a cast
raid5.c:1147: too many arguments to function `generic_make_request'
raid5.c: In function `raid5_activate_delayed':
raid5.c:1158: dereferencing pointer to incomplete type
...
raid5.c: In function `raid5_unplug_device':
raid5.c:1176: dereferencing pointer to incomplete type
...
raid5.c: In function `raid5_plug_device':
raid5.c:1188: dereferencing pointer to incomplete type
...
raid5.c: In function `raid5_make_request':
raid5.c:1200: dereferencing pointer to incomplete type
raid5.c:1213: structure has no member named `b_rsector'
raid5.c: In function `raid5_sync_request':
raid5.c:1235: dereferencing pointer to incomplete type
raid5.c:1240: dereferencing pointer to incomplete type
raid5.c: In function `raid5d':
raid5.c:1274: dereferencing pointer to incomplete type
...
raid5.c:1287: warning: `first' might be used uninitialized in this
function
raid5.c: In function `raid5syncd':
raid5.c:1328: dereferencing pointer to incomplete type
...
raid5.c: In function `raid5_run':
raid5.c:1364: sizeof applied to an incomplete type
raid5.c:1367: dereferencing pointer to incomplete type
...
raid5.c:1370: warning: implicit declaration of function
`md__get_free_pages'
raid5.c:1372: dereferencing pointer to incomplete type
...
raid5.c:1374: `MD_SPIN_LOCK_UNLOCKED' undeclared (first use in this
function)
raid5.c:1374: (Each undeclared identifier is reported only once
raid5.c:1374: for each function it appears in.)
raid5.c:1375: warning: implicit declaration of function
`md_init_waitqueue_head'raid5.c:1375: dereferencing pointer to
incomplete type
raid5.c:1376: dereferencing pointer to incomplete type
...
raid5.c:1390: warning: assignment from incompatible pointer type
raid5.c:1390: dereferencing pointer to incomplete type
raid5.c:1390: dereferencing pointer to incomplete type
raid5.c:1390: warning: left-hand operand of comma expression has no
effect
raid5.c:1398: dereferencing pointer to incomplete type
...
raid5.c: In function `raid5_stop_resync':
raid5.c:1588: dereferencing pointer to incomplete type
...
raid5.c: In function `raid5_restart_resync':
raid5.c:1606: dereferencing pointer to incomplete type
...
raid5.c: In function `raid5_stop':
raid5.c:1625: dereferencing pointer to incomplete type
...
raid5.c: In function `raid5_status':
raid5.c:1678: dereferencing pointer to incomplete type
...
raid5.c: In function `print_raid5_conf':
raid5.c:1700: dereferencing pointer to incomplete type
...
raid5.c: In function `raid5_diskop':
raid5.c:1727: dereferencing pointer to incomplete type
...
raid5.c:1719: warning: `i' might be used uninitialized in this function
raid5.c:1721: warning: `tmp' might be used uninitialized in this
function
raid5.c:1721: warning: `sdisk' might be used uninitialized in this
function
raid5.c:1721: warning: `adisk' might be used uninitialized in this
function
raid5.c: At top level:
raid5.c:1993: warning: initialization from incompatible pointer type
raid5.c:2002: warning: initialization from incompatible pointer type
raid5.c:2004: parse error before `raid5_init'
raid5.c:2005: warning: return type defaults to `int'



