Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbTDPKGH (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 06:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTDPKGH 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 06:06:07 -0400
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:34090 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S264285AbTDPKGC (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 06:06:02 -0400
Date: Wed, 16 Apr 2003 12:17:53 +0200 (CEST)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre7 - aic79xx
Message-ID: <Pine.LNX.4.53.0304161212390.5122@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have new machine with aic79xx scsi controler,
(4x Intel(R) Xeon(TM) CPU 2.66GHz, 4GB RAM)
during making copy to new discs, a had lot of messages (debugg messages?).
What does this mean exactly? After it, system load was about 30-40.
It is hardware problem?

: Attempting to abort cmd f77be400
Apr 15 00:40:45 oceanic kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Apr 15 00:40:45 oceanic kernel: scsi1: Dumping Card State at program address 0x8f Mode 0x11
Apr 15 00:40:45 oceanic kernel: Card was paused
Apr 15 00:40:45 oceanic kernel: HS_MAILBOX[0x0] INTCTL[0xc0] SEQINTSTAT[0x0] SAVED_MODE[0x11] 
Apr 15 00:40:45 oceanic kernel: DFFSTAT[0x31] SCSISIGI[0xe6] SCSIPHASE[0x8] SCSIBUS[0x55] 
Apr 15 00:40:46 oceanic kernel: LASTPHASE[0x1] SCSISEQ0[0x0] SCSISEQ1[0x12] SEQCTL0[0x10] 
Apr 15 00:40:46 oceanic kernel: SEQINTCTL[0x80] SEQ_FLAGS[0xc0] SEQ_FLAGS2[0x0] SSTAT0[0x2] 
Apr 15 00:40:46 oceanic kernel: SSTAT1[0x19] SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0x8] 
Apr 15 00:40:46 oceanic kernel: SIMODE1[0xa4] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x0] 
Apr 15 00:40:46 oceanic kernel: LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0x81] 
Apr 15 00:40:46 oceanic kernel: 
Apr 15 00:40:46 oceanic kernel: SCB Count = 128 CMDS_PENDING = 79 LASTSCB 0x1b CURRSCB 0x1b NEXTSCB 0xff40
Apr 15 00:40:45 oceanic kernel: qinstart = 16326 qinfifonext = 16326
Apr 15 00:40:45 oceanic kernel: QINFIFO:
Apr 15 00:40:45 oceanic kernel: WAITING_TID_QUEUES:
Apr 15 00:40:45 oceanic kernel:        1 ( 0x1b 0x6d 0x12 0x57 0x3 0x50 0x4e )
Apr 15 00:40:45 oceanic kernel:        2 ( 0x15 0x33 0x63 0x39 0x4 )
Apr 15 00:40:45 oceanic kernel:        3 ( 0x61 )
Apr 15 00:40:45 oceanic kernel: Pending list:
Apr 15 00:40:45 oceanic kernel:  97 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x61] 
Apr 15 00:40:45 oceanic kernel:  78 SCB_CONTROL[0x60] SCB_SCSIID[0x17] SCB_TAG[0x4e] 
Apr 15 00:40:45 oceanic kernel:  80 SCB_CONTROL[0x60] SCB_SCSIID[0x17] SCB_TAG[0x50] 
Apr 15 00:40:45 oceanic kernel:   3 SCB_CONTROL[0x60] SCB_SCSIID[0x17] SCB_TAG[0x3] 
Apr 15 00:40:45 oceanic kernel:   4 SCB_CONTROL[0x60] SCB_SCSIID[0x27] SCB_TAG[0x4] 
Apr 15 00:40:45 oceanic kernel:  87 SCB_CONTROL[0x60] SCB_SCSIID[0x17] SCB_TAG[0x57] 
Apr 15 00:40:45 oceanic kernel:  57 SCB_CONTROL[0x60] SCB_SCSIID[0x27] SCB_TAG[0x39] 
Apr 15 00:40:45 oceanic kernel:  99 SCB_CONTROL[0x60] SCB_SCSIID[0x27] SCB_TAG[0x63] 
Apr 15 00:40:45 oceanic kernel:  18 SCB_CONTROL[0x60] SCB_SCSIID[0x17] SCB_TAG[0x12] 
Apr 15 00:40:45 oceanic kernel:  51 SCB_CONTROL[0x60] SCB_SCSIID[0x27] SCB_TAG[0x33] 
Apr 15 00:40:45 oceanic kernel: 109 SCB_CONTROL[0x60] SCB_SCSIID[0x17] SCB_TAG[0x6d] 
Apr 15 00:40:45 oceanic kernel:  21 SCB_CONTROL[0x60] SCB_SCSIID[0x27] SCB_TAG[0x15] 
Apr 15 00:40:45 oceanic kernel:  27 SCB_CONTROL[0x60] SCB_SCSIID[0x17] SCB_TAG[0x1b] 
Apr 15 00:40:45 oceanic kernel: 106 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x6a] 
Apr 15 00:40:45 oceanic kernel:  14 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0xe] 
Apr 15 00:40:45 oceanic kernel:  42 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x2a] 
Apr 15 00:40:45 oceanic kernel:  48 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x30] 
Apr 15 00:40:45 oceanic kernel:  58 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x3a] 
Apr 15 00:40:45 oceanic kernel:   0 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x0] 
Apr 15 00:40:45 oceanic kernel:  46 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x2e] 
Apr 15 00:40:45 oceanic kernel:   6 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x6] 
Apr 15 00:40:45 oceanic kernel:  34 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x22] 
Apr 15 00:40:45 oceanic kernel:  69 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x45] 
Apr 15 00:40:45 oceanic kernel:  61 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x3d] 
Apr 15 00:40:45 oceanic kernel: 103 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x67] 
Apr 15 00:40:45 oceanic kernel: 118 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x76] 
Apr 15 00:40:45 oceanic kernel:   2 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x2] 
Apr 15 00:40:45 oceanic kernel:  62 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x3e] 
Apr 15 00:40:45 oceanic kernel: 123 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x7b] 
Apr 15 00:40:45 oceanic kernel:  63 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x3f] 
Apr 15 00:40:45 oceanic kernel: 115 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x73] 
Apr 15 00:40:45 oceanic kernel:  79 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x4f] 
Apr 15 00:40:45 oceanic kernel: 124 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x7c] 
Apr 15 00:40:45 oceanic kernel:  84 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x54] 
Apr 15 00:40:45 oceanic kernel:  95 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x5f] 
Apr 15 00:40:45 oceanic kernel:  75 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x4b] 
Apr 15 00:40:45 oceanic kernel:  44 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x2c] 
Apr 15 00:40:45 oceanic kernel: 100 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x64] 
Apr 15 00:40:45 oceanic kernel:  10 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0xa] 
Apr 15 00:40:45 oceanic kernel:  35 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x23] 
Apr 15 00:40:45 oceanic kernel: 121 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x79] 
Apr 15 00:40:45 oceanic kernel:  73 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x49] 
Apr 15 00:40:45 oceanic kernel: 114 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x72] 
Apr 15 00:40:45 oceanic kernel:   8 SCB_CONTROL[0x64] SCB_SCSIID[0x27] SCB_TAG[0x8] 
Apr 15 00:40:45 oceanic kernel:  50 SCB_CONTROL[0x64] SCB_SCSIID[0x27] SCB_TAG[0x32] 
Apr 15 00:40:45 oceanic kernel: 120 SCB_CONTROL[0x64] SCB_SCSIID[0x27] SCB_TAG[0x78] 
Apr 15 00:40:45 oceanic kernel:  56 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x38] 
Apr 15 00:40:45 oceanic kernel:  29 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x1d] 
Apr 15 00:40:45 oceanic kernel: 107 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x6b] 
Apr 15 00:40:45 oceanic kernel:  33 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x21] 
Apr 15 00:40:45 oceanic kernel:  96 SCB_CONTROL[0x64] SCB_SCSIID[0x27] SCB_TAG[0x60] 
Apr 15 00:40:45 oceanic kernel: 113 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x71] 
Apr 15 00:40:45 oceanic kernel:  67 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x43] 
Apr 15 00:40:45 oceanic kernel: 122 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x7a] 
Apr 15 00:40:45 oceanic kernel:   5 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x5] 
Apr 15 00:40:45 oceanic kernel:  39 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x27] 
Apr 15 00:40:45 oceanic kernel:  23 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x17] 
Apr 15 00:40:45 oceanic kernel:  90 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x5a] 
Apr 15 00:40:45 oceanic kernel:  37 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x25] 
Apr 15 00:40:45 oceanic kernel:  30 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x1e] 
Apr 15 00:40:45 oceanic kernel:  24 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x18] 
Apr 15 00:40:45 oceanic kernel:  94 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x5e] 
Apr 15 00:40:45 oceanic kernel:  83 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x53] 
Apr 15 00:40:45 oceanic kernel:  76 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x4c] 
Apr 15 00:40:45 oceanic kernel:  55 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x37] 
Apr 15 00:40:45 oceanic kernel:  89 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x59] 
Apr 15 00:40:45 oceanic kernel: 126 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x7e] 
Apr 15 00:40:45 oceanic kernel: 111 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x6f] 
Apr 15 00:40:45 oceanic kernel:  53 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x35] 
Apr 15 00:40:45 oceanic kernel:  65 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x41] 
Apr 15 00:40:45 oceanic kernel: 105 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x69] 
Apr 15 00:40:45 oceanic kernel:  25 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x19] 
Apr 15 00:40:45 oceanic kernel:  64 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_TAG[0x40] 
Apr 15 00:40:45 oceanic kernel:  74 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x4a] 
Apr 15 00:40:45 oceanic kernel:  52 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x34] 
Apr 15 00:40:45 oceanic kernel:  68 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x44] 
Apr 15 00:40:45 oceanic kernel:  31 SCB_CONTROL[0x64] SCB_SCSIID[0x27] SCB_TAG[0x1f] 
Apr 15 00:40:45 oceanic kernel:  38 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x26] 
Apr 15 00:40:45 oceanic kernel:  41 SCB_CONTROL[0x64] SCB_SCSIID[0x37] SCB_TAG[0x29] 
Apr 15 00:40:45 oceanic kernel: Total 79
Apr 15 00:40:45 oceanic kernel: Kernel Free SCB list: 47 43 16 98 91 71 59 20 108 45 11 92 1 110 101 17 22 54 12 127 13 15 119 86 60 72 26 28 49 117 9 82 93 77 88 116 125 40 19 81 85 70 104 66 112 32 36 7 102 
Apr 15 00:40:45 oceanic kernel: Sequencer Complete DMA-inprog list: 
Apr 15 00:40:45 oceanic kernel: Sequencer Complete list: 
Apr 15 00:40:45 oceanic kernel: Sequencer DMA-Up and Complete list: 
Apr 15 00:40:45 oceanic kernel: 
Apr 15 00:40:45 oceanic kernel: scsi1: FIFO0 Free, LONGJMP == 0x80ff, SCB 0x40, LJSCB 0xff00
Apr 15 00:40:45 oceanic kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Apr 15 00:40:45 oceanic kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Apr 15 00:40:45 oceanic kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Apr 15 00:40:45 oceanic kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Apr 15 00:40:45 oceanic kernel: scsi1: FIFO1 Free, LONGJMP == 0x8248, SCB 0x40, LJSCB 0x40
Apr 15 00:40:45 oceanic kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x4] DFSTATUS[0x89] 
Apr 15 00:40:45 oceanic kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Apr 15 00:40:45 oceanic kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Apr 15 00:40:45 oceanic kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Apr 15 00:40:45 oceanic kernel: LQIN: 0x55 0x0 0x0 0x40 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x80 0x0 0x0 0x0 0x2 0x0 
Apr 15 00:40:45 oceanic kernel: scsi1: LQISTATE = 0x1, LQOSTATE = 0x0, OPTIONMODE = 0x42
Apr 15 00:40:45 oceanic kernel: scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1
Apr 15 00:40:45 oceanic kernel: SIMODE0[0xc] 
Apr 15 00:40:45 oceanic kernel: CCSCBCTL[0x4] 
Apr 15 00:40:45 oceanic kernel: scsi1: REG0 == 0x60, SINDEX = 0x122, DINDEX = 0x108
Apr 15 00:40:45 oceanic kernel: scsi1: SCBPTR == 0x40, SCB_NEXT == 0xff00, SCB_NEXT2 == 0xff22
Apr 15 00:40:45 oceanic kernel: CDB 0 10 0 0 88 e1
Apr 15 00:40:45 oceanic kernel: STACK: 0x2e 0x10 0x120 0x0 0x0 0x248 0x248 0x236
Apr 15 00:40:45 oceanic kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Apr 15 00:40:45 oceanic kernel: DevQ(0:0:0): 0 waiting
Apr 15 00:40:45 oceanic kernel: DevQ(0:1:0): 0 waiting
Apr 15 00:40:45 oceanic kernel: DevQ(0:2:0): 0 waiting
Apr 15 00:40:45 oceanic kernel: DevQ(0:3:0): 0 waiting
Apr 15 00:40:45 oceanic kernel: (scsi1:A:0:0): Device is disconnected, re-queuing SCB
Apr 15 00:40:45 oceanic kernel: Recovery code sleeping
Apr 15 00:40:50 oceanic kernel: Recovery code awake
Apr 15 00:40:50 oceanic kernel: Timer Expired

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
