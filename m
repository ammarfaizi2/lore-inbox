Return-Path: <linux-kernel-owner+w=401wt.eu-S964983AbXATAds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbXATAds (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 19:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932869AbXATAds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 19:33:48 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:52971 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932807AbXATAdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 19:33:47 -0500
Message-ID: <45B163E4.1040507@student.ltu.se>
Date: Sat, 20 Jan 2007 01:35:49 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: ebiederm@xmission.com, akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl.h: Comment out unused constants
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comment out unused constants in include/linux/sysctl.h.

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
---
Compile-tested with allyes and allmod under i386.


diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 81480e6..c8d2cb7 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -91,10 +91,10 @@ enum
 {
 	KERN_OSTYPE=1,		/* string: system version */
 	KERN_OSRELEASE=2,	/* string: system release */
-	KERN_OSREV=3,		/* int: system revision */
+/*	KERN_OSREV=3,*/		/* int: system revision */
 	KERN_VERSION=4,		/* string: compile time info */
-	KERN_SECUREMASK=5,	/* struct: maximum rights mask */
-	KERN_PROF=6,		/* table: profiling information */
+/*	KERN_SECUREMASK=5,*/	/* struct: maximum rights mask */
+/*	KERN_PROF=6,*/		/* table: profiling information */
 	KERN_NODENAME=7,
 	KERN_DOMAINNAME=8,
 
@@ -105,22 +105,22 @@ enum
 	KERN_SPARC_REBOOT=21,	/* reboot command on Sparc */
 	KERN_CTLALTDEL=22,	/* int: allow ctl-alt-del to reboot */
 	KERN_PRINTK=23,		/* struct: control printk logging parameters */
-	KERN_NAMETRANS=24,	/* Name translation */
-	KERN_PPC_HTABRECLAIM=25, /* turn htab reclaimation on/off on PPC */
-	KERN_PPC_ZEROPAGED=26,	/* turn idle page zeroing on/off on PPC */
+/*	KERN_NAMETRANS=24,*/	/* Name translation */
+/*	KERN_PPC_HTABRECLAIM=25,*/ /* turn htab reclaimation on/off on PPC */
+/*	KERN_PPC_ZEROPAGED=26,*/ /* turn idle page zeroing on/off on PPC */
 	KERN_PPC_POWERSAVE_NAP=27, /* use nap mode for power saving */
 	KERN_MODPROBE=28,
 	KERN_SG_BIG_BUFF=29,
 	KERN_ACCT=30,		/* BSD process accounting parameters */
 	KERN_PPC_L2CR=31,	/* l2cr register on PPC */
 
-	KERN_RTSIGNR=32,	/* Number of rt sigs queued */
-	KERN_RTSIGMAX=33,	/* Max queuable */
+/*	KERN_RTSIGNR=32,*/	/* Number of rt sigs queued */
+/*	KERN_RTSIGMAX=33,*/	/* Max queuable */
 	
 	KERN_SHMMAX=34,         /* long: Maximum shared memory segment */
 	KERN_MSGMAX=35,         /* int: Maximum size of a messege */
 	KERN_MSGMNB=36,         /* int: Maximum message queue size */
-	KERN_MSGPOOL=37,        /* int: Maximum system message pool size */
+/*	KERN_MSGPOOL=37,*/	/* int: Maximum system message pool size */
 	KERN_SYSRQ=38,		/* int: Sysreq enable */
 	KERN_MAX_THREADS=39,	/* int: Maximum nr of threads in the system */
  	KERN_RANDOM=40,		/* Random driver */
@@ -131,7 +131,7 @@ enum
  	KERN_SHMMNI=45,		/* int: shm array identifiers */
 	KERN_OVERFLOWUID=46,	/* int: overflow UID */
 	KERN_OVERFLOWGID=47,	/* int: overflow GID */
-	KERN_SHMPATH=48,	/* string: path to shm fs */
+/*	KERN_SHMPATH=48,*/	/* string: path to shm fs */
 	KERN_HOTPLUG=49,	/* string: path to uevent helper (deprecated) */
 	KERN_IEEE_EMULATION_WARNINGS=50, /* int: unimplemented ieee instructions */
 	KERN_S390_USER_DEBUG_LOGGING=51,  /* int: dumps of user faults */
@@ -167,15 +167,15 @@ enum
 /* CTL_VM names: */
 enum
 {
-	VM_UNUSED1=1,		/* was: struct: Set vm swapping control */
-	VM_UNUSED2=2,		/* was; int: Linear or sqrt() swapout for hogs */
-	VM_UNUSED3=3,		/* was: struct: Set free page thresholds */
-	VM_UNUSED4=4,		/* Spare */
+/*	VM_UNUSED1=1,*/		/* was: struct: Set vm swapping control */
+/*	VM_UNUSED2=2,*/		/* was; int: Linear or sqrt() swapout for hogs */
+/*	VM_UNUSED3=3,*/		/* was: struct: Set free page thresholds */
+/*	VM_UNUSED4=4,*/		/* Spare */
 	VM_OVERCOMMIT_MEMORY=5,	/* Turn off the virtual memory safety limit */
-	VM_UNUSED5=6,		/* was: struct: Set buffer memory thresholds */
-	VM_UNUSED7=7,		/* was: struct: Set cache memory thresholds */
-	VM_UNUSED8=8,		/* was: struct: Control kswapd behaviour */
-	VM_UNUSED9=9,		/* was: struct: Set page table cache parameters */
+/*	VM_UNUSED5=6,*/		/* was: struct: Set buffer memory thresholds */
+/*	VM_UNUSED7=7,*/		/* was: struct: Set cache memory thresholds */
+/*	VM_UNUSED8=8,*/		/* was: struct: Control kswapd behaviour */
+/*	VM_UNUSED9=9,*/		/* was: struct: Set page table cache parameters */
 	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
 	VM_DIRTY_BACKGROUND=11,	/* dirty_background_ratio */
 	VM_DIRTY_RATIO=12,	/* dirty_ratio */
@@ -183,7 +183,7 @@ enum
 	VM_DIRTY_EXPIRE_CS=14,	/* dirty_expire_centisecs */
 	VM_NR_PDFLUSH_THREADS=15, /* nr_pdflush_threads */
 	VM_OVERCOMMIT_RATIO=16, /* percent of RAM to allow overcommit in */
-	VM_PAGEBUF=17,		/* struct: Control pagebuf parameters */
+/*	VM_PAGEBUF=17,*/	/* struct: Control pagebuf parameters */
 	VM_HUGETLB_PAGES=18,	/* int: Number of available Huge Pages */
 	VM_SWAPPINESS=19,	/* Tendency to steal mapped memory */
 	VM_LOWMEM_RESERVE_RATIO=20,/* reservation ratio for lower memory zones */
@@ -194,7 +194,7 @@ enum
 	VM_HUGETLB_GROUP=25,	/* permitted hugetlb group */
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
-	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+/*	VM_SWAP_TOKEN_TIMEOUT=28,*/ /* default time for token time out */
 	VM_DROP_PAGECACHE=29,	/* int: nuke lots of pagecache */
 	VM_PERCPU_PAGELIST_FRACTION=30,/* int: fraction of pages in each percpu_pagelist */
 	VM_ZONE_RECLAIM_MODE=31, /* reclaim local zone memory before going off node */
@@ -210,7 +210,7 @@ enum
 {
 	NET_CORE=1,
 	NET_ETHER=2,
-	NET_802=3,
+/*	NET_802=3,*/
 	NET_UNIX=4,
 	NET_IPV4=5,
 	NET_IPX=6,
@@ -223,7 +223,7 @@ enum
 	NET_X25=13,
 	NET_TR=14,
 	NET_DECNET=15,
-	NET_ECONET=16,
+/*	NET_ECONET=16,*/
 	NET_SCTP=17,
 	NET_LLC=18,
 	NET_NETFILTER=19,
@@ -265,16 +265,16 @@ enum
 	NET_CORE_RMEM_DEFAULT=4,
 /* was	NET_CORE_DESTROY_DELAY */
 	NET_CORE_MAX_BACKLOG=6,
-	NET_CORE_FASTROUTE=7,
+/*	NET_CORE_FASTROUTE=7,*/
 	NET_CORE_MSG_COST=8,
 	NET_CORE_MSG_BURST=9,
 	NET_CORE_OPTMEM_MAX=10,
-	NET_CORE_HOT_LIST_LENGTH=11,
-	NET_CORE_DIVERT_VERSION=12,
-	NET_CORE_NO_CONG_THRESH=13,
-	NET_CORE_NO_CONG=14,
-	NET_CORE_LO_CONG=15,
-	NET_CORE_MOD_CONG=16,
+/*	NET_CORE_HOT_LIST_LENGTH=11,*/
+/*	NET_CORE_DIVERT_VERSION=12,*/
+/*	NET_CORE_NO_CONG_THRESH=13,*/
+/*	NET_CORE_NO_CONG=14,*/
+/*	NET_CORE_LO_CONG=15,*/
+/*	NET_CORE_MOD_CONG=16,*/
 	NET_CORE_DEV_WEIGHT=17,
 	NET_CORE_SOMAXCONN=18,
 	NET_CORE_BUDGET=19,
@@ -290,8 +290,8 @@ enum
 
 enum
 {
-	NET_UNIX_DESTROY_DELAY=1,
-	NET_UNIX_DELETE_DELAY=2,
+/*	NET_UNIX_DESTROY_DELAY=1,*/
+/*	NET_UNIX_DELETE_DELAY=2,*/
 	NET_UNIX_MAX_DGRAM_QLEN=3,
 };
 
@@ -342,7 +342,7 @@ enum
 	NET_IPV4_CONF=16,
 	NET_IPV4_NEIGH=17,
 	NET_IPV4_ROUTE=18,
-	NET_IPV4_FIB_HASH=19,
+/*	NET_IPV4_FIB_HASH=19,*/
 	NET_IPV4_NETFILTER=20,
 
 	NET_IPV4_TCP_TIMESTAMPS=33,
@@ -350,36 +350,36 @@ enum
 	NET_IPV4_TCP_SACK=35,
 	NET_IPV4_TCP_RETRANS_COLLAPSE=36,
 	NET_IPV4_DEFAULT_TTL=37,
-	NET_IPV4_AUTOCONFIG=38,
+/*	NET_IPV4_AUTOCONFIG=38,*/
 	NET_IPV4_NO_PMTU_DISC=39,
 	NET_IPV4_TCP_SYN_RETRIES=40,
 	NET_IPV4_IPFRAG_HIGH_THRESH=41,
 	NET_IPV4_IPFRAG_LOW_THRESH=42,
 	NET_IPV4_IPFRAG_TIME=43,
-	NET_IPV4_TCP_MAX_KA_PROBES=44,
+/*	NET_IPV4_TCP_MAX_KA_PROBES=44,*/
 	NET_IPV4_TCP_KEEPALIVE_TIME=45,
 	NET_IPV4_TCP_KEEPALIVE_PROBES=46,
 	NET_IPV4_TCP_RETRIES1=47,
 	NET_IPV4_TCP_RETRIES2=48,
 	NET_IPV4_TCP_FIN_TIMEOUT=49,
-	NET_IPV4_IP_MASQ_DEBUG=50,
+/*	NET_IPV4_IP_MASQ_DEBUG=50,*/
 	NET_TCP_SYNCOOKIES=51,
 	NET_TCP_STDURG=52,
 	NET_TCP_RFC1337=53,
-	NET_TCP_SYN_TAILDROP=54,
+/*	NET_TCP_SYN_TAILDROP=54,*/
 	NET_TCP_MAX_SYN_BACKLOG=55,
 	NET_IPV4_LOCAL_PORT_RANGE=56,
 	NET_IPV4_ICMP_ECHO_IGNORE_ALL=57,
 	NET_IPV4_ICMP_ECHO_IGNORE_BROADCASTS=58,
-	NET_IPV4_ICMP_SOURCEQUENCH_RATE=59,
-	NET_IPV4_ICMP_DESTUNREACH_RATE=60,
-	NET_IPV4_ICMP_TIMEEXCEED_RATE=61,
-	NET_IPV4_ICMP_PARAMPROB_RATE=62,
-	NET_IPV4_ICMP_ECHOREPLY_RATE=63,
+/*	NET_IPV4_ICMP_SOURCEQUENCH_RATE=59,*/
+/*	NET_IPV4_ICMP_DESTUNREACH_RATE=60,*/
+/*	NET_IPV4_ICMP_TIMEEXCEED_RATE=61,*/
+/*	NET_IPV4_ICMP_PARAMPROB_RATE=62,*/
+/*	NET_IPV4_ICMP_ECHOREPLY_RATE=63,*/
 	NET_IPV4_ICMP_IGNORE_BOGUS_ERROR_RESPONSES=64,
 	NET_IPV4_IGMP_MAX_MEMBERSHIPS=65,
 	NET_TCP_TW_RECYCLE=66,
-	NET_IPV4_ALWAYS_DEFRAG=67,
+/*	NET_IPV4_ALWAYS_DEFRAG=67,*/
 	NET_IPV4_TCP_KEEPALIVE_INTVL=68,
 	NET_IPV4_INET_PEER_THRESHOLD=69,
 	NET_IPV4_INET_PEER_MINTTL=70,
@@ -409,10 +409,10 @@ enum
 	NET_IPV4_IPFRAG_SECRET_INTERVAL=94,
 	NET_IPV4_IGMP_MAX_MSF=96,
 	NET_TCP_NO_METRICS_SAVE=97,
-	NET_TCP_DEFAULT_WIN_SCALE=105,
+/*	NET_TCP_DEFAULT_WIN_SCALE=105,*/
 	NET_TCP_MODERATE_RCVBUF=106,
 	NET_TCP_TSO_WIN_DIVISOR=107,
-	NET_TCP_BIC_BETA=108,
+/*	NET_TCP_BIC_BETA=108,*/
 	NET_IPV4_ICMP_ERRORS_USE_INBOUND_IFADDR=109,
 	NET_TCP_CONG_CONTROL=110,
 	NET_TCP_ABC=111,
@@ -609,7 +609,7 @@ enum {
 /* /proc/sys/net/ipx */
 enum {
 	NET_IPX_PPROP_BROADCASTING=1,
-	NET_IPX_FORWARDING=2
+/*	NET_IPX_FORWARDING=2*/
 };
 
 /* /proc/sys/net/llc */
@@ -619,9 +619,11 @@ enum {
 };
 
 /* /proc/sys/net/llc/llc2 */
+#if 0
 enum {
 	NET_LLC2_TIMEOUT=1,
 };
+#endif
 
 /* /proc/sys/net/llc/station */
 enum {
@@ -710,7 +712,7 @@ enum
 
 /* /proc/sys/net/decnet/ */
 enum {
-	NET_DECNET_NODE_TYPE = 1,
+/*	NET_DECNET_NODE_TYPE = 1,*/
 	NET_DECNET_NODE_ADDRESS = 2,
 	NET_DECNET_NODE_NAME = 3,
 	NET_DECNET_DEFAULT_DEVICE = 4,
@@ -742,12 +744,12 @@ enum {
 /* /proc/sys/net/decnet/conf/<dev>/ */
 enum {
 	NET_DECNET_CONF_DEV_PRIORITY = 1,
-	NET_DECNET_CONF_DEV_T1 = 2,
+/*	NET_DECNET_CONF_DEV_T1 = 2,*/
 	NET_DECNET_CONF_DEV_T2 = 3,
 	NET_DECNET_CONF_DEV_T3 = 4,
 	NET_DECNET_CONF_DEV_FORWARDING = 5,
-	NET_DECNET_CONF_DEV_BLKSIZE = 6,
-	NET_DECNET_CONF_DEV_STATE = 7
+/*	NET_DECNET_CONF_DEV_BLKSIZE = 6,*/
+/*	NET_DECNET_CONF_DEV_STATE = 7*/
 };
 
 /* /proc/sys/net/sctp */
@@ -784,14 +786,14 @@ enum
 {
 	FS_NRINODE=1,	/* int:current number of allocated inodes */
 	FS_STATINODE=2,
-	FS_MAXINODE=3,	/* int:maximum number of inodes that can be allocated */
-	FS_NRDQUOT=4,	/* int:current number of allocated dquots */
-	FS_MAXDQUOT=5,	/* int:maximum number of dquots that can be allocated */
+/*	FS_MAXINODE=3,*//* int:maximum number of inodes that can be allocated */
+/*	FS_NRDQUOT=4,*/	/* int:current number of allocated dquots */
+/*	FS_MAXDQUOT=5,*//* int:maximum number of dquots that can be allocated */
 	FS_NRFILE=6,	/* int:current number of allocated filedescriptors */
 	FS_MAXFILE=7,	/* int:maximum number of filedescriptors that can be allocated */
 	FS_DENTRY=8,
-	FS_NRSUPER=9,	/* int:current number of allocated super_blocks */
-	FS_MAXSUPER=10,	/* int:maximum number of super_blocks that can be allocated */
+/*	FS_NRSUPER=9,*/	/* int:current number of allocated super_blocks */
+/*	FS_MAXSUPER=10,*//* int:maximum number of super_blocks that can be allocated */
 	FS_OVERFLOWUID=11,	/* int: overflow UID */
 	FS_OVERFLOWGID=12,	/* int: overflow GID */
 	FS_LEASES=13,	/* int: leases enabled */
@@ -822,7 +824,7 @@ enum {
 /* CTL_DEV names: */
 enum {
 	DEV_CDROM=1,
-	DEV_HWMON=2,
+/*	DEV_HWMON=2,*/
 	DEV_PARPORT=3,
 	DEV_RAID=4,
 	DEV_MAC_HID=5,
@@ -880,12 +882,12 @@ enum {
 
 /* /proc/sys/dev/mac_hid */
 enum {
-	DEV_MAC_HID_KEYBOARD_SENDS_LINUX_KEYCODES=1,
-	DEV_MAC_HID_KEYBOARD_LOCK_KEYCODES=2,
+/*	DEV_MAC_HID_KEYBOARD_SENDS_LINUX_KEYCODES=1,*/
+/*	DEV_MAC_HID_KEYBOARD_LOCK_KEYCODES=2,*/
 	DEV_MAC_HID_MOUSE_BUTTON_EMULATION=3,
 	DEV_MAC_HID_MOUSE_BUTTON2_KEYCODE=4,
 	DEV_MAC_HID_MOUSE_BUTTON3_KEYCODE=5,
-	DEV_MAC_HID_ADB_MOUSE_SENDS_KEYCODES=6
+/*	DEV_MAC_HID_ADB_MOUSE_SENDS_KEYCODES=6*/
 };
 
 /* /proc/sys/dev/scsi */
@@ -899,6 +901,7 @@ enum {
 };
 
 /* /proc/sys/abi */
+#if 0
 enum
 {
 	ABI_DEFHANDLER_COFF=1,	/* default handler for coff binaries */
@@ -908,6 +911,7 @@ enum
 	ABI_TRACE=5,		/* tracing flags */
 	ABI_FAKE_UTSNAME=6,	/* fake target utsname information */
 };
+#endif
 
 #ifdef __KERNEL__
 #include <linux/list.h>

