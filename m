Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265282AbUBPBlc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 20:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265284AbUBPBlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 20:41:32 -0500
Received: from stinkfoot.org ([65.75.25.34]:402 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S265282AbUBPBlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 20:41:04 -0500
Message-ID: <40301FA7.2050403@stinkfoot.org>
Date: Sun, 15 Feb 2004 20:40:55 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Adaptec 39230 Broken?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Posted to mlist.linux.scsi with no response]

I've gotten lots of these messages recently on 2.6.2 and 2.6.1 during 
heavy usage.  The system is a my Supermicro-X5DPL-IGM-0, the card is a 
39320 with both channels
populated, 2x2.4 Xeon, 3G of RAM. (lspci -vv and other info at bottom). 
  This always seems to occur during heavy network usage.  I'm beginning 
to worry that I'm losting data here-

Apologies for the huge post.

thanks,

Ethan

Feb 15 20:24:42 spicymeatball kernel: scsi1: PCI error Interrupt
Feb 15 20:24:42 spicymeatball kernel: scsi0: PCI error Interrupt
Feb 15 20:24:42 spicymeatball kernel: >>>>>>>>>>>>>>>>>> Dump Card State 
Begins <<<<<<<<<<<<<<<<<
Feb 15 20:24:42 spicymeatball kernel: scsi0: Dumping Card State at 
program address 0x36 Mode 0x11
Feb 15 20:24:42 spicymeatball kernel: >>>>>>>>>>>>>>>>>> Dump Card State 
Begins <<<<<<<<<<<<<<<<<
Feb 15 20:24:42 spicymeatball kernel: scsi1: Dumping Card State at 
program address 0x24e Mode 0x0
Feb 15 20:24:42 spicymeatball kernel: Card was paused
Feb 15 20:24:42 spicymeatball kernel: HS_MAILBOX[0x0]Card was paused
Feb 15 20:24:42 spicymeatball kernel: HS_MAILBOX[0x0] INTCTL[0xc0] 
INTCTL[0xc0]:(SWTMINTEN:(SWTMINTEN|SWTMINTMASK)
Feb 15 20:24:42 spicymeatball kernel: |SWTMINTMASK)
Feb 15 20:24:42 spicymeatball kernel: SEQINTSTAT[0x0] 
SAVED_MODE[0x11]SEQINTSTAT[0x0] SAVED_MODE[0x11] DFFSTAT[0x31] 
DFFSTAT[0x1]:(CURRFIFO_1|FIFO0FREE|FIFO1FREE)
Feb 15 20:24:42 spicymeatball kernel: :(CURRFIFO_1)
Feb 15 20:24:42 spicymeatball kernel: SCSISIGI[0x0]:(P_DATAOUT) 
SCSISIGI[0x24]SCSIPHASE[0x0]:(P_DATAOUT_DT|BSYI) 
SCSIPHASE[0x1]SCSIBUS[0x0]:(DATA_OUT_PHASE)
Feb 15 20:24:42 spicymeatball kernel:
Feb 15 20:24:42 spicymeatball kernel: 
SCSIBUS[0xd6]LASTPHASE[0x1]:(P_DATAOUT|P_BUSFREE) SCSISEQ0[0x0] 
LASTPHASE[0x1]
Feb 15 20:24:42 spicymeatball kernel: :(P_DATAOUT|P_BUSFREE)
Feb 15 20:24:42 spicymeatball kernel: 
SCSISEQ1[0x12]:(ENAUTOATNP|ENRSELI) SEQCTL0[0x10]SCSISEQ0[0x0] 
SCSISEQ1[0x12]:(FASTMODE)
Feb 15 20:24:42 spicymeatball kernel: :(ENAUTOATNPSEQINTCTL[0x0] 
SEQ_FLAGS[0x0]|ENRSELI)
Feb 15 20:24:42 spicymeatball kernel:  SEQCTL0[0x10]:(FASTMODE) 
SEQINTCTL[0x2e]SEQ_FLAGS2[0x0] 
SSTAT0[0x0]:(INTMASK1|INTMASK2|SCS_SEQ_INT1M0|INT1_CONTEXT)
Feb 15 20:24:42 spicymeatball kernel:
Feb 15 20:24:42 spicymeatball kernel: SEQ_FLAGS[0x0] 
SEQ_FLAGS2[0x0]SSTAT1[0x8]:(BUSFREE)  SSTAT2[0x0] SSTAT3[0x0]SSTAT0[0x0] 
SSTAT1[0x19] PERRDIAG[0x8]:(REQINIT|BUSFREE|PHASEMIS)
Feb 15 20:24:42 spicymeatball kernel: :(AIPERR)
Feb 15 20:24:42 spicymeatball kernel: SSTAT2[0x0] 
SSTAT3[0x0]SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO) LQISTAT0[0x0] 
PERRDIAG[0x0]
Feb 15 20:24:42 spicymeatball kernel:  SIMODE1[0xa4]LQISTAT1[0x0] 
LQISTAT2[0x0]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO)
Feb 15 20:24:42 spicymeatball kernel:  LQOSTAT0[0x0]LQISTAT0[0x0] 
LQISTAT1[0x0] LQOSTAT1[0x0] LQISTAT2[0x0]
Feb 15 20:24:42 spicymeatball kernel:  LQOSTAT2[0x1]:(LQOSTOP0)
Feb 15 20:24:42 spicymeatball kernel: LQOSTAT0[0x0]
Feb 15 20:24:42 spicymeatball kernel: LQOSTAT1[0x0]
Feb 15 20:24:42 spicymeatball kernel: SCB Count = 116 CMDS_PENDING = 0 
LASTSCB 0x45 CURRSCB 0x45 NEXTSCB 0xff40
Feb 15 20:24:42 spicymeatball kernel: LQOSTAT2[0x81]:(LQOSTOP0)
Feb 15 20:24:42 spicymeatball kernel: qinstart = 7069 qinfifonext = 7069
Feb 15 20:24:42 spicymeatball kernel: QINFIFO:
Feb 15 20:24:42 spicymeatball kernel: SCB Count = 200 CMDS_PENDING = 4 
LASTSCB 0x1c CURRSCB 0x1c NEXTSCB 0xff80
Feb 15 20:24:42 spicymeatball kernel:
Feb 15 20:24:42 spicymeatball kernel: WAITING_TID_QUEUES:
Feb 15 20:24:42 spicymeatball kernel: qinstart = 37238 qinfifonext = 37238
Feb 15 20:24:42 spicymeatball kernel: QINFIFO:Pending list:
Feb 15 20:24:42 spicymeatball kernel: Total 0
Feb 15 20:24:42 spicymeatball kernel: Kernel Free SCB list: 69 82 83 100
Feb 15 20:24:42 spicymeatball kernel: WAITING_TID_QUEUES:
Feb 15 20:24:42 spicymeatball kernel: 7 4 80 76 70 68 81 54 74 85 65 67 
66 106 95 78 24 84 77 114 6 75 64 87 63 12 55 1 20 60 43 62 11 88 73 90 
105 71 48 51 15 14 91 42 10 44 36 59 5 9 58 89 2 28 72 96 45 92 33 30 
111 50 115 21 32 99 108 86 38 16 25 13 35 26 0 53 22 41 29 37 56 17 31 
110 46 19 8 104 102 27 34 18 49 23 97 79 61 109 57 93 39 3 98 94 101 107 
40 47 103 52 113 112
Feb 15 20:24:42 spicymeatball kernel: Sequencer Complete DMA-inprog list:
Feb 15 20:24:42 spicymeatball kernel: Sequencer Complete list:
Feb 15 20:24:42 spicymeatball kernel: Sequencer DMA-Up and Complete 
list: Pending list:
Feb 15 20:24:42 spicymeatball kernel: Sequencer On QFreeze and Complete 
list:
Feb 15 20:24:42 spicymeatball kernel:
Feb 15 20:24:42 spicymeatball kernel:  28 FIFO_USE[0x0] SCB_CONTROL[0x60]
Feb 15 20:24:42 spicymeatball kernel: scsi0: FIFO0 Free, LONGJMP == 
0x80ff, SCB 0x45
Feb 15 20:24:42 spicymeatball kernel: 
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS) 

Feb 15 20:24:42 spicymeatball kernel: :(TAG_ENB|DISCENB) 
SEQINTSRC[0x0]SCB_SCSIID[0x67] DFCNTRL[0x0]
Feb 15 20:24:42 spicymeatball kernel: 102 FIFO_USE[0x0] 
DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
Feb 15 20:24:42 spicymeatball kernel: 
SG_CACHE_SHADOW[0x2]:(LAST_SEGSCB_CONTROL[0x60]) 
SG_STATE[0x0]:(TAG_ENB|DISCENB)  SCB_SCSIID[0x67]DFFSXFRCTL[0x0]
Feb 15 20:24:42 spicymeatball kernel: SOFFCNT[0x0] MDFFSTAT[0x5]:(FIFOFREE
Feb 15 20:24:42 spicymeatball kernel:  55 FIFO_USE[0x0] |DLZERO) 
SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x67] SHADDR = 0x00, 
SHCNT = 0x0
Feb 15 20:24:42 spicymeatball kernel:  46 FIFO_USE[0x0]
Feb 15 20:24:42 spicymeatball kernel: 
SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x67]
Feb 15 20:24:42 spicymeatball kernel: Total 4
Feb 15 20:24:42 spicymeatball kernel: HADDR = 0x00, HCNT = 0x0 
CCSGCTL[0x10]Kernel Free SCB list: 73 131 64 3 33 7 26 185 129 24 22 36 
113 16 90 112 20 27 9 88 60 121 94 19 122 58 71 89 43 15 51 41 44 1 34 
107 52 123 0 29 91 115 39 57 127 67 98 75 65 38 93 59 18 130 181 14 72 
106 176 4 97 128 6 96 174 168 163 158 152 154 156 162 161 160 166 164 
170 140 68 50 157 159 153 155 148 149 150 151 144 145 146 147 142 143 
136 138 139 132 133 134 135 42 40 62 172 141 109 117 137 186 69 187 77 
180 125 12 182 54 183 119 126 177 79 178 111 179 99 173 48 175 49 169 10 
171 85 165 84 167 8 120 81 2 66 23 56 82 13 25 70 118 32 35 76 87 116 
110 61 30 78 21 108 53 92 17 86 74 104 31 11 101 83 63 100 45 103 124 5 
105 114 95 184 80 198 199 192 193 194 195 191 188 189 190 197 37 47 196
Feb 15 20:24:42 spicymeatball kernel: Sequencer Complete DMA-inprog 
list: :(SG_CACHE_AVAIL
Feb 15 20:24:42 spicymeatball kernel: Sequencer Complete list: )
Feb 15 20:24:42 spicymeatball kernel: Sequencer DMA-Up and Complete list:
Feb 15 20:24:42 spicymeatball kernel: scsi0: FIFO1 Free, LONGJMP == 
0x8292, SCB 0x45
Feb 15 20:24:42 spicymeatball kernel:
Feb 15 20:24:42 spicymeatball kernel: Sequencer On QFreeze and Complete 
list:
Feb 15 20:24:42 spicymeatball kernel: 
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS) 

Feb 15 20:24:42 spicymeatball kernel: SEQINTSRC[0x0] 
DFCNTRL[0x4]:(DIRECTION)
Feb 15 20:24:42 spicymeatball kernel: scsi1: FIFO0 Active, LONGJMP == 
0x80ff, SCB 0x2e
Feb 15 20:24:42 spicymeatball kernel: 
DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
Feb 15 20:24:42 spicymeatball kernel: 
SG_CACHE_SHADOW[0x2]SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS) 

Feb 15 20:24:42 spicymeatball kernel: :(LAST_SEG) 
SG_STATE[0x0]SEQINTSRC[0x20]:(SAVEPTRS) DFCNTRL[0x0] DFFSXFRCTL[0x0]
Feb 15 20:24:42 spicymeatball kernel: DFSTATUS[0x89]SOFFCNT[0x0] 
MDFFSTAT[0x5]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
Feb 15 20:24:42 spicymeatball kernel: :(FIFOFREE|DLZERO) 
SG_CACHE_SHADOW[0x50] SG_STATE[0x0] DFFSXFRCTL[0x0]
Feb 15 20:24:42 spicymeatball kernel: SOFFCNT[0x68]SHADDR = 0x00, SHCNT 
= 0x0
Feb 15 20:24:42 spicymeatball kernel:  MDFFSTAT[0xc]:(DLZERO|SHVALID) 
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]:(SG_CACHE_AVAIL)
Feb 15 20:24:42 spicymeatball kernel: LQIN: SHADDR = 0x040257600, SHCNT 
= 0xa00 0x55 0x0
Feb 15 20:24:42 spicymeatball kernel: 0x0 0x45 0x0 0x0 0x0 0x0 HADDR = 
0x00, HCNT = 0x0 0x0 0x0 CCSGCTL[0x88]0x0 :(CCSGENACK|CCSGDONE) 0x0 0x0
Feb 15 20:24:42 spicymeatball kernel: scsi1: FIFO1 Active, LONGJMP == 
0x272, SCB 0x2e
Feb 15 20:24:42 spicymeatball kernel: 0x0 0x0 SEQIMODE[0x3f]0x0 0x0 
:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS)
Feb 15 20:24:42 spicymeatball kernel: 0x0 SEQINTSRC[0x0] 
DFCNTRL[0x2c]0x0 :(DIRECTION|HDMAEN|SCSIEN)
Feb 15 20:24:42 spicymeatball kernel: 0x0 DFSTATUS[0x2]:(FIFOFULL) 
SG_CACHE_SHADOW[0x50]
Feb 15 20:24:42 spicymeatball kernel:  SG_STATE[0x6]scsi0: LQISTATE = 
0x0, LQOSTATE = 0x0, OPTIONMODE = 0x42
Feb 15 20:24:42 spicymeatball kernel: :(LOADING_NEEDED|FETCH_INPROG)
Feb 15 20:24:42 spicymeatball kernel: DFFSXFRCTL[0x0]scsi0: OS_SPACE_CNT 
= 0x20 MAXCMDCNT = 0x1
Feb 15 20:24:42 spicymeatball kernel:
Feb 15 20:24:42 spicymeatball kernel:  SIMODE0[0xc]SOFFCNT[0x68] 
MDFFSTAT[0xa]:(ENOVERRUN|ENIOERR)
Feb 15 20:24:42 spicymeatball kernel: :(DATAINFIFOCCSCBCTL[0x0]|SHVALID)
Feb 15 20:24:42 spicymeatball kernel:
Feb 15 20:24:42 spicymeatball kernel: scsi0: REG0 == 0x60, SINDEX = 
0x111, DINDEX = 0x10c
Feb 15 20:24:42 spicymeatball kernel: SHADDR = 0x040257800, SHCNT = 
0x800 scsi0: SCBPTR == 0x45, SCB_NEXT == 0xff00, SCB_NEXT2 == 0xff33
Feb 15 20:24:42 spicymeatball kernel: HADDR = 0x04020e000, HCNT = 0x1000
Feb 15 20:24:42 spicymeatball kernel: 
CCSGCTL[0x98]:(CCSGENACK|SG_CACHE_AVAIL|CCSGDONE)
Feb 15 20:24:42 spicymeatball kernel: LQIN: CDB 2a 0 0 80 10 d4
Feb 15 20:24:42 spicymeatball kernel: STACK:0x5  0x240x0  0x1340x0 0x2e 
  0x1340x0 0x0  0x00x0  0x2790x0 0x0  0x25b0x0 0x0  0xa10x0  0x360x0 0x0 
0x2 0x0 0x0 0x0 0x2 0x0
Feb 15 20:24:42 spicymeatball kernel:
Feb 15 20:24:42 spicymeatball kernel: <<<<<<<<<<<<<<<<< Dump Card State 
Ends >>>>>>>>>>>>>>>>>>
Feb 15 20:24:42 spicymeatball kernel: scsi1: LQISTATE = 0x27, LQOSTATE = 
0x0, OPTIONMODE = 0x42
Feb 15 20:24:42 spicymeatball kernel: scsi0: Host Status: Failed(0)
Feb 15 20:24:42 spicymeatball kernel: DevQ(0:5:0): scsi1: OS_SPACE_CNT = 
0x20 MAXCMDCNT = 0x1
Feb 15 20:24:42 spicymeatball kernel:
Feb 15 20:24:42 spicymeatball kernel: 0 waiting
Feb 15 20:24:42 spicymeatball kernel: SIMODE0[0xc]:(ENOVERRUN|ENIOERR)
Feb 15 20:24:42 spicymeatball kernel: CCSCBCTL[0x0]DevQ(0:6:0): 0 waiting
Feb 15 20:24:42 spicymeatball kernel:
Feb 15 20:24:42 spicymeatball kernel: scsi1: REG0 == 0xf00d, SINDEX = 
0x133, DINDEX = 0x10e
Feb 15 20:24:42 spicymeatball kernel: scsi0: Address or Write Phase 
Parity Error Detected in TARG.
Feb 15 20:24:42 spicymeatball kernel: scsi1: SCBPTR == 0x2e, SCB_NEXT == 
0x37, SCB_NEXT2 == 0xffb4
Feb 15 20:24:42 spicymeatball kernel: CDB 0 2 0 0 60 89
Feb 15 20:24:42 spicymeatball kernel: STACK: 0x1d 0x134 0x134 0x0 0x272 
0x25b 0xa2 0x39
Feb 15 20:24:42 spicymeatball kernel: <<<<<<<<<<<<<<<<< Dump Card State 
Ends >>>>>>>>>>>>>>>>>>
Feb 15 20:24:42 spicymeatball kernel: scsi1: Host Status: Failed(0)
Feb 15 20:24:42 spicymeatball kernel: DevQ(0:5:0): 0 waiting
Feb 15 20:24:42 spicymeatball kernel: DevQ(0:6:0): 0 waiting
Feb 15 20:24:42 spicymeatball kernel: scsi1: Address or Write Phase 
Parity Error Detected in TARG.
Feb 15 20:24:44 spicymeatball kernel: scsi0: PCI error Interrupt
Feb 15 20:24:44 spicymeatball kernel: scsi1: PCI error Interrupt
Feb 15 20:24:44 spicymeatball kernel: >>>>>>>>>>>>>>>>>> Dump Card State 
Begins <<<<<<<<<<<<<<<<<
Feb 15 20:24:44 spicymeatball kernel: scsi1: Dumping Card State at 
program address 0x1d3 Mode 0x11
Feb 15 20:24:44 spicymeatball kernel: >>>>>>>>>>>>>>>>>> Dump Card State 
Begins <<<<<<<<<<<<<<<<<
Feb 15 20:24:44 spicymeatball kernel: scsi0: Dumping Card State at 
program address 0x13 Mode 0x33
Feb 15 20:24:44 spicymeatball kernel: Card was paused
Feb 15 20:24:44 spicymeatball kernel: HS_MAILBOX[0x0] 
INTCTL[0xc0]:(SWTMINTEN|SWTMINTMASK)
Feb 15 20:24:44 spicymeatball kernel: SEQINTSTAT[0x0] SAVED_MODE[0x11] 
DFFSTAT[0x31]:(CURRFIFO_1|FIFO0FREE|FIFO1FREE)
Feb 15 20:24:44 spicymeatball kernel: SCSISIGI[0x0]:(P_DATAOUT) 
SCSIPHASE[0x0]Card was paused
Feb 15 20:24:44 spicymeatball kernel:  SCSIBUS[0x0]
Feb 15 20:24:44 spicymeatball kernel: 
LASTPHASE[0x1]HS_MAILBOX[0x0]:(P_DATAOUT|P_BUSFREE) SCSISEQ0[0x0]
Feb 15 20:24:44 spicymeatball kernel: 
SCSISEQ1[0x12]:(ENAUTOATNP|ENRSELI) SEQCTL0[0x10]:(FASTMODE ) 
INTCTL[0xc0]:(SWTMINTEN
Feb 15 20:24:44 spicymeatball kernel: SEQINTCTL[0x0] SEQ_FLAGS[0x0] 
SEQ_FLAGS2[0x0] SSTAT0[0x0]
Feb 15 20:24:44 spicymeatball kernel: SSTAT1[0x8]:(BUSFREE) SSTAT2[0x0] 
|SWTMINTMASKSSTAT3[0x0] PERRDIAG[0x8]:(AIPERR)
Feb 15 20:24:44 spicymeatball kernel: 
SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO) LQISTAT0[0x0] )
Feb 15 20:24:44 spicymeatball kernel: LQISTAT1[0x0] LQISTAT2[0x0] 
LQOSTAT0[0x0] LQOSTAT1[0x0]
Feb 15 20:24:44 spicymeatball kernel: SEQINTSTAT[0x0]
Feb 15 20:24:44 spicymeatball kernel: LQOSTAT2[0x1]:(LQOSTOP0)
Feb 15 20:24:44 spicymeatball kernel:  SAVED_MODE[0x11]
Feb 15 20:24:44 spicymeatball kernel: SCB Count = 116 CMDS_PENDING = 0 
LASTSCB 0x52 CURRSCB 0x52 NEXTSCB 0xff40
Feb 15 20:24:44 spicymeatball kernel:  qinstart = 7071 qinfifonext = 7071
Feb 15 20:24:44 spicymeatball kernel: QINFIFO:DFFSTAT[0x1]
Feb 15 20:24:44 spicymeatball kernel: WAITING_TID_QUEUES:
Feb 15 20:24:44 spicymeatball kernel: :(CURRFIFO_1)
Feb 15 20:24:44 spicymeatball kernel: Pending list:
Feb 15 20:24:44 spicymeatball kernel: Total 0
Feb 15 20:24:44 spicymeatball kernel: Kernel Free SCB list: 82 69 
SCSISIGI[0x24]83 :(P_DATAOUT_DT100 7 4 |BSYI) SCSIPHASE[0x1]80 76 70 
:(DATA_OUT_PHASE68 ) 81 54 74 85 65 67 66 106 95 78 24 84 77
Feb 15 20:24:44 spicymeatball kernel: SCSIBUS[0x52]114 
LASTPHASE[0x1]:(P_DATAOUT|P_BUSFREE6 75 )
Feb 15 20:24:44 spicymeatball kernel: 64 87 63 12 55 1 20 60 43 62 11 88 
73 90 105 71 48 51 15 14 91 42 10 44 36 59 5 9 58 SCSISEQ0[0x0]89 2 28 
72 96 45 92 33 30 111 50 115 21 32 99 108 86 38 16 25 13 35 26 0  53 22 
SCSISEQ1[0x12]:(ENAUTOATNP|ENRSELI)
Feb 15 20:24:44 spicymeatball kernel: 41 29 37 56 17 31 110 
SEQCTL0[0x10]46 :(FASTMODE) 19 SEQINTCTL[0x8]8 104 102 27 34 18 
:(SCS_SEQ_INT1M0) 49 23 97 79
Feb 15 20:24:44 spicymeatball kernel: SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0]61 
109  SSTAT0[0x0]57 93 39 3 98 94 101 107 40 47 103 52 113 112
Feb 15 20:24:44 spicymeatball kernel: Sequencer Complete DMA-inprog list:
Feb 15 20:24:44 spicymeatball kernel: Sequencer Complete list:
Feb 15 20:24:44 spicymeatball kernel: Sequencer DMA-Up and Complete list:
Feb 15 20:24:44 spicymeatball kernel: Sequencer On QFreeze and Complete 
list:
Feb 15 20:24:44 spicymeatball kernel:  SSTAT1[0x19]:(REQINIT
Feb 15 20:24:44 spicymeatball kernel: scsi0: FIFO0 Free, LONGJMP == 
0x80ff, SCB 0x52
Feb 15 20:24:44 spicymeatball kernel: 
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS) 

Feb 15 20:24:44 spicymeatball kernel: SEQINTSRC[0x0] DFCNTRL[0x0] 
DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
Feb 15 20:24:44 spicymeatball kernel: SG_CACHE_SHADOW[0x2]:(LAST_SEG) 
SG_STATE[0x0] |BUSFREEDFFSXFRCTL[0x0]
Feb 15 20:24:44 spicymeatball kernel: SOFFCNT[0x0] 
MDFFSTAT[0x5]:(FIFOFREE|DLZERO) |PHASEMIS)
Feb 15 20:24:44 spicymeatball kernel: SSTAT2[0x0]SHADDR = 0x00, SHCNT = 
0x0
Feb 15 20:24:44 spicymeatball kernel: SSTAT3[0x0] PERRDIAG[0x0] 
SIMODE1[0xa4]HADDR = 0x00, HCNT = 0x0 
CCSGCTL[0x10]:(ENSCSIPERR|ENSCSIRST:(SG_CACHE_AVAIL|ENSELTIMO) )
Feb 15 20:24:44 spicymeatball kernel: LQISTAT0[0x0]
Feb 15 20:24:44 spicymeatball kernel: scsi0: FIFO1 Free, LONGJMP == 
0x8292, SCB 0x52
Feb 15 20:24:44 spicymeatball kernel: 
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS) 

Feb 15 20:24:44 spicymeatball kernel: SEQINTSRC[0x0] 
DFCNTRL[0x4]:(DIRECTION) DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
Feb 15 20:24:44 spicymeatball kernel: SG_CACHE_SHADOW[0x2]:(LAST_SEG) 
SG_STATE[0x0] DFFSXFRCTL[0x0]
Feb 15 20:24:44 spicymeatball kernel: LQISTAT1[0x0] SOFFCNT[0x0] 
LQISTAT2[0x0]MDFFSTAT[0x5]:(FIFOFREE|DLZERO)  LQOSTAT0[0x0]
Feb 15 20:24:44 spicymeatball kernel: SHADDR = 0x00, SHCNT = 0x0
Feb 15 20:24:44 spicymeatball kernel: LQOSTAT1[0x0] 
LQOSTAT2[0x81]:(LQOSTOP0HADDR = 0x00, HCNT = 0x0 
CCSGCTL[0x10]:(SG_CACHE_AVAIL)
Feb 15 20:24:44 spicymeatball kernel: LQIN: 0x55 0x0 )
Feb 15 20:24:44 spicymeatball kernel: 0x0 0x52 0x0 0x0 0x0
Feb 15 20:24:44 spicymeatball kernel: SCB Count = 200 CMDS_PENDING = 9 
LASTSCB 0x40 CURRSCB 0x40 NEXTSCB 0xff80
Feb 15 20:24:44 spicymeatball kernel: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
qinstart = 37380 qinfifonext = 37380
Feb 15 20:24:44 spicymeatball kernel: QINFIFO:0x0 0x0 0x0 0x0
Feb 15 20:24:44 spicymeatball kernel: WAITING_TID_QUEUES:
Feb 15 20:24:44 spicymeatball kernel: 0x0 0x0
Feb 15 20:24:44 spicymeatball kernel: Pending list:scsi0: LQISTATE = 
0x0, LQOSTATE = 0x0, OPTIONMODE = 0x42
Feb 15 20:24:44 spicymeatball kernel: scsi0: OS_SPACE_CNT = 0x20 
MAXCMDCNT = 0x1
Feb 15 20:24:44 spicymeatball kernel:
Feb 15 20:24:44 spicymeatball kernel: SIMODE0[0xc]:(ENOVERRUN|ENIOERR)
Feb 15 20:24:44 spicymeatball kernel: CCSCBCTL[0x0]
Feb 15 20:24:44 spicymeatball kernel:
Feb 15 20:24:44 spicymeatball kernel:  64 FIFO_USE[0x0] scsi0: REG0 == 
0x45, SINDEX = 0x133, DINDEX = 0x10c
Feb 15 20:24:44 spicymeatball kernel: SCB_CONTROL[0x60]:(TAG_ENBscsi0: 
SCBPTR == 0x52, SCB_NEXT == 0xffc0, SCB_NEXT2 == 0xffb4
Feb 15 20:24:44 spicymeatball kernel: |DISCENB) SCB_SCSIID[0x57] CDB 2a 
0 0 80 8 68
Feb 15 20:24:44 spicymeatball kernel: STACK: 0x134
Feb 15 20:24:44 spicymeatball kernel: 131 FIFO_USE[0x0] 
0x134SCB_CONTROL[0x60] 0x0 0x279 0x279:(TAG_ENB 0x25b 0x39|DISCENB) 
0x1SCB_SCSIID[0x57]
Feb 15 20:24:44 spicymeatball kernel:  73 FIFO_USE[0x0]
Feb 15 20:24:44 spicymeatball kernel: <<<<<<<<<<<<<<<<< Dump Card State 
Ends >>>>>>>>>>>>>>>>>>
Feb 15 20:24:44 spicymeatball kernel: 
SCB_CONTROL[0x60]:(TAG_ENB|DISCENBscsi0: Host Status: Failed(0)
Feb 15 20:24:44 spicymeatball kernel: DevQ(0:5:0): 0 waiting
Feb 15 20:24:44 spicymeatball kernel: ) SCB_SCSIID[0x57]DevQ(0:6:0): 0 
waiting
Feb 15 20:24:44 spicymeatball kernel:
Feb 15 20:24:44 spicymeatball kernel:  55 FIFO_USE[0x0] 
SCB_CONTROL[0x60]:(TAG_ENB|DISCENBscsi0: Address or Write Phase Parity 
Error Detected in TARG.
Feb 15 20:24:44 spicymeatball kernel: ) SCB_SCSIID[0x57]
Feb 15 20:24:44 spicymeatball kernel: 102 FIFO_USE[0x0] 
SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
Feb 15 20:24:44 spicymeatball kernel:   7 FIFO_USE[0x0] 
SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
Feb 15 20:24:44 spicymeatball kernel:   3 FIFO_USE[0x0] 
SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
Feb 15 20:24:44 spicymeatball kernel:  33 FIFO_USE[0x0] 
SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
Feb 15 20:24:44 spicymeatball kernel:  46 FIFO_USE[0x0] 
SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
Feb 15 20:24:44 spicymeatball kernel: Total 9
Feb 15 20:24:44 spicymeatball kernel: Kernel Free SCB list: 28 26 185 
129 24 22 36 113 16 90 112 20 27 9 88 60 121 94 19 122 58 71 89 43 15 51 
41 44 1 34 107 52 123 0 29 91 115 39 57 127 67 98 75 65 38 93 59 18 130 
181 14 72 106 176 4 97 128 6 96 174 168 163 158 152 154 156 162 161 160 
166 164 170 140 68 50 157 159 153 155 148 149 150 151 144 145 146 147 
142 143 136 138 139 132 133 134 135 42 40 62 172 141 109 117 137 186 69 
187 77 180 125 12 182 54 183 119 126 177 79 178 111 179 99 173 48 175 49 
169 10 171 85 165 84 167 8 120 81 2 66 23 56 82 13 25 70 118 32 35 76 87 
116 110 61 30 78 21 108 53 92 17 86 74 104 31 11 101 83 63 100 45 103 
124 5 105 114 95 184 80 198 199 192 193 194 195 191 188 189 190 197 37 
47 196
Feb 15 20:24:44 spicymeatball kernel: Sequencer Complete DMA-inprog list:
Feb 15 20:24:44 spicymeatball kernel: Sequencer Complete list:
Feb 15 20:24:44 spicymeatball kernel: Sequencer DMA-Up and Complete list:
Feb 15 20:24:44 spicymeatball kernel: Sequencer On QFreeze and Complete 
list:
Feb 15 20:24:44 spicymeatball kernel:
Feb 15 20:24:44 spicymeatball kernel: scsi1: FIFO0 Active, LONGJMP == 
0x80ff, SCB 0x2e
Feb 15 20:24:44 spicymeatball kernel: 
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS) 

Feb 15 20:24:44 spicymeatball kernel: SEQINTSRC[0x20]:(SAVEPTRS) 
DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
Feb 15 20:24:44 spicymeatball kernel: SG_CACHE_SHADOW[0x58] 
SG_STATE[0x0] DFFSXFRCTL[0x0]
Feb 15 20:24:44 spicymeatball kernel: SOFFCNT[0x76] 
MDFFSTAT[0xc]:(DLZERO|SHVALID) SHADDR = 0x041edb600, SHCNT = 0xa00
Feb 15 20:24:44 spicymeatball kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x0]
Feb 15 20:24:44 spicymeatball kernel: scsi1: FIFO1 Active, LONGJMP == 
0x272, SCB 0x2e
Feb 15 20:24:44 spicymeatball kernel: 
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS) 

Feb 15 20:24:44 spicymeatball kernel: SEQINTSRC[0x0] 
DFCNTRL[0x2c]:(DIRECTION|HDMAEN|SCSIEN)
Feb 15 20:24:44 spicymeatball kernel: DFSTATUS[0x2]:(FIFOFULL) 
SG_CACHE_SHADOW[0x58] SG_STATE[0x3]:(SEGS_AVAIL|LOADING_NEEDED)
Feb 15 20:24:44 spicymeatball kernel: DFFSXFRCTL[0x0] SOFFCNT[0x76] 
MDFFSTAT[0xa]:(DATAINFIFO|SHVALID)
Feb 15 20:24:44 spicymeatball kernel: SHADDR = 0x041edb800, SHCNT = 
0x800 HADDR = 0x041eda000, HCNT = 0x1000
Feb 15 20:24:44 spicymeatball kernel: CCSGCTL[0x10]:(SG_CACHE_AVAIL)
Feb 15 20:24:44 spicymeatball kernel: LQIN: 0x5 0x0 0x0 0x2e 0x0 0x0 0x0 
0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x2 0x0 0x0 0x0 0x2 0x0
Feb 15 20:24:44 spicymeatball kernel: scsi1: LQISTATE = 0x27, LQOSTATE = 
0x0, OPTIONMODE = 0x42
Feb 15 20:24:44 spicymeatball kernel: scsi1: OS_SPACE_CNT = 0x20 
MAXCMDCNT = 0x1
Feb 15 20:24:44 spicymeatball kernel: SIMODE0[0xc]:(ENOVERRUN|ENIOERR)
Feb 15 20:24:44 spicymeatball kernel: CCSCBCTL[0x4]:(CCSCBDIR)
Feb 15 20:24:44 spicymeatball kernel: scsi1: REG0 == 0x60, SINDEX = 
0x111, DINDEX = 0x10c
Feb 15 20:24:44 spicymeatball kernel: scsi1: SCBPTR == 0x2e, SCB_NEXT == 
0x21, SCB_NEXT2 == 0xffb4
Feb 15 20:24:44 spicymeatball kernel: CDB 0 4 0 0 68 8b
Feb 15 20:24:44 spicymeatball kernel: STACK: 0x24 0x134 0x134 0x0 0x272 
0x272 0xa2 0x272
Feb 15 20:24:44 spicymeatball kernel: <<<<<<<<<<<<<<<<< Dump Card State 
Ends >>>>>>>>>>>>>>>>>>
Feb 15 20:24:44 spicymeatball kernel: scsi1: Host Status: Failed(0)
Feb 15 20:24:44 spicymeatball kernel: DevQ(0:5:0): 0 waiting
Feb 15 20:24:44 spicymeatball kernel: DevQ(0:6:0): 0 waiting
Feb 15 20:24:44 spicymeatball kernel: scsi1: Address or Write Phase 
Parity Error Detected in TARG.


lspci -vv

00:00.0 Host bridge: Intel Corp. E7501 Memory Controller Hub (rev 01)
         Subsystem: Super Micro Computer Inc: Unknown device 3980
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [40] #09 [1105]

00:00.1 Class ff00: Intel Corp. E7000 Series Host RASUM Controller
(rev 01)
         Subsystem: Super Micro Computer Inc: Unknown device 3980
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:02.0 PCI bridge: Intel Corp. E7000 Series Hub Interface B
PCI-to-PCI Bridge (rev 01) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
         I/O behind bridge: 00003000-00004fff
         Memory behind bridge: fc100000-fc2fffff
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
(prog-if 00 [UHCI])
         Subsystem: Super Micro Computer Inc: Unknown device 3980
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 16
         Region 4: I/O ports at 2000 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
(prog-if 00 [UHCI])
         Subsystem: Super Micro Computer Inc: Unknown device 3980
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 19
         Region 4: I/O ports at 2020 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
(prog-if 00 [UHCI])
         Subsystem: Super Micro Computer Inc: Unknown device 3980
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin C routed to IRQ 18
         Region 4: I/O ports at 2040 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 42)
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=04, subordinate=04, sec-latency=248
         I/O behind bridge: 00005000-00005fff
         Memory behind bridge: fc300000-fdffffff
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801CA LPC Interface Controller (rev
02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801CA Ultra ATA Storage
Controller (rev 02) (prog-if 8e [Master SecP SecO PriP])
         Subsystem: Super Micro Computer Inc: Unknown device 3980
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at <ignored>
         Region 1: I/O ports at <ignored>
         Region 2: I/O ports at <unassigned>
         Region 3: I/O ports at <unassigned>
         Region 4: I/O ports at 2060 [size=16]
         Region 5: Memory at c0000000 (32-bit, non-prefetchable)
[size=1K]

00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
         Subsystem: Super Micro Computer Inc: Unknown device 3980
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin B routed to IRQ 17
         Region 4: I/O ports at 1100 [size=32]

01:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20
[IO(X)-APIC])
         Subsystem: Super Micro Computer Inc: Unknown device 3980
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at fc100000 (32-bit, non-prefetchable)
[size=4K]
         Capabilities: [50] PCI-X non-bridge device.
                 Command: DPERE- ERO- RBC=0 OST=0
                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
01:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, cache line size 10
         Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
         I/O behind bridge: 00003000-00004fff
         Memory behind bridge: fc200000-fc2fffff
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [50] PCI-X bridge device.
                 Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-,
SRD- Freq=3
                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
SCO-, SRD-
                 : Upstream: Capacity=0, Commitment Limit=0
                 : Downstream: Capacity=0, Commitment Limit=0

01:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20
[IO(X)-APIC])
         Subsystem: Super Micro Computer Inc: Unknown device 3980
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at fc101000 (32-bit, non-prefetchable)
[size=4K]
         Capabilities: [50] PCI-X non-bridge device.
                 Command: DPERE- ERO- RBC=0 OST=0
                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
01:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, cache line size 10
         Bus: primary=01, secondary=03, subordinate=03, sec-latency=64
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [50] PCI-X bridge device.
                 Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-,
SRD- Freq=2
                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
SCO-, SRD-
                 : Upstream: Capacity=0, Commitment Limit=0
                 : Downstream: Capacity=0, Commitment Limit=0

02:01.0 SCSI storage controller: Adaptec ASC-39320 U320 (rev 03)
         Subsystem: Adaptec: Unknown device 0040
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 72 (10000ns min, 6250ns max), cache line size 08
         Interrupt: pin A routed to IRQ 48
         Region 0: I/O ports at 3400 [size=256]
         Region 1: Memory at fc200000 (64-bit, non-prefetchable)
[disabled] [size=8K]
         Region 3: I/O ports at 3000 [size=256]
         Expansion ROM at <unassigned> [disabled] [size=512K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [a0] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [94]
02:01.1 SCSI storage controller: Adaptec ASC-39320 U320 (rev 03)
         Subsystem: Adaptec: Unknown device 0040
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 72 (10000ns min, 6250ns max), cache line size 08
         Interrupt: pin B routed to IRQ 49
         Region 0: I/O ports at 3c00 [size=256]
         Region 1: Memory at fc202000 (64-bit, non-prefetchable)
[disabled] [size=8K]
         Region 3: I/O ports at 3800 [size=256]
         Expansion ROM at <unassigned> [disabled] [size=512K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [a0] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [94]
02:03.0 Ethernet controller: Intel Corp. 82545EM Gigabit Ethernet
Controller (Copper) (rev 01)
         Subsystem: Intel Corp.: Unknown device 1011
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (63750ns min), cache line size 08
         Interrupt: pin A routed to IRQ 54
         Region 0: Memory at fc220000 (64-bit, non-prefetchable)
[size=128K]
         Region 4: I/O ports at 4000 [size=64]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [e4] PCI-X non-bridge device.
                 Command: DPERE- ERO+ RBC=0 OST=0
                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [f0]
Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000

04:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (rev
02)
         Subsystem: LSI Logic / Symbios Logic: Unknown device 1020
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 247 (7500ns min, 16000ns max), cache line size 20
         Interrupt: pin A routed to IRQ 16
         Region 0: I/O ports at 5000 [size=256]
         Region 1: Memory at fc303000 (32-bit, non-prefetchable)
[size=256]
         Region 2: Memory at fc300000 (32-bit, non-prefetchable)
[size=4K]
         Expansion ROM at <unassigned> [disabled] [size=128K]

04:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev
27) (prog-if 00 [VGA])
         Subsystem: ATI Technologies Inc Rage XL
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min), cache line size 08
         Interrupt: pin A routed to IRQ 21
         Region 0: Memory at fd000000 (32-bit, non-prefetchable)
[size=16M]
         Region 1: I/O ports at 5400 [size=256]
         Region 2: Memory at fc301000 (32-bit, non-prefetchable)
[size=4K]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [5c] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 10)
         Subsystem: Intel Corp. EtherExpress PRO/100 S Server Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min, 14000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 22
         Region 0: Memory at fc302000 (32-bit, non-prefetchable)
[size=4K]
         Region 1: I/O ports at 5800 [size=64]
         Region 2: Memory at fc320000 (32-bit, non-prefetchable)
[size=128K]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

           CPU0       CPU1       CPU2       CPU3
   0:    5251911          0          0          0    IO-APIC-edge
timer
   1:        888          0          0          0    IO-APIC-edge
i8042
   2:          0          0          0          0          XT-PIC
cascade
   3:      83545          0          0          0    IO-APIC-edge
serial
   8:          5          0          0          0    IO-APIC-edge  rtc
   9:          0          0          0          0   IO-APIC-level  acpi
  14:         30          0          0          0    IO-APIC-edge  ide0
  16:         47          0          0          0   IO-APIC-level
sym53c8xx
  22:     163375          0          0          0   IO-APIC-level  eth0
  48:      20437          0          0          0   IO-APIC-level
aic79xx
  49:      10913          0          0          0   IO-APIC-level
aic79xx
  54:     211321          0          0          0   IO-APIC-level  eth1
NMI:          0          0          0          0
LOC:    5251591    5251834    5251838    5251837
ERR:          0
MIS:          0
