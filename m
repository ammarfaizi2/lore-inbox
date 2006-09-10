Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWIJV4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWIJV4f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 17:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWIJV4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 17:56:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:19680 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751022AbWIJVSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 17:18:35 -0400
X-Authenticated: #222744
From: "Dieter Ferdinand" <dieter.ferdinand@gmx.de>
To: linux-kernel@vger.kernel.org
Date: Sun, 10 Sep 2006 23:18:30 +1
MIME-Version: 1.0
Subject: PROBLEM: total system crash
Reply-to: Dieter.Ferdinand@gmx.de
Message-ID: <45049D46.5225.57F41B4A@dieter.ferdinand.gmx.de>
X-mailer: Pegasus Mail for Windows (4.31, DE v4.31 R1)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
i have some big problems with kernel 2.4.32.

i use asterisk as pbx with an avm b1-card and capi on a dual p3-500 
system. this system crash always if i make a call from isdn to asterisk and 
from asterisk to isdn dependently which end hangs up first.

i test same on an other system with an avm fritz-card without problem.
the test on a system with single cpu is in planning.

the next problem makes more problems and i need this driver.
i use adaptec scsi-controllers (aha 2940 and other models with the same 
driver) in all my scsi-systems.

after some problems with the scsi-system, the system hangs total.
i have only the log at the end of the mail and here are some informations 
missing.

this system crash thre time today with the same error. after booting with 
kernel 2.6.16.27 i get a message soft-lookup detected and system hangs.
the system is very much swapping at this moment.

this system is a pentium 266 with an ide-harddisk for linux and two scsi-
harddisks for backup und data. i use this system for testing new kernels and 
software.

it looks that i have this problem only on heavy load and many paging-
requests.

if you need more informations, i think, i can reproduce this errors every time 
if i start some programs which makes a high system load.

but i don't know, how i can catch informations, which you need, to solve this 
problem.
i can setup a remote-login to the system for you without access to my other 
system-resources.

the next problem is with kernel 2.4 and 2.6. i have some older pentium dual-
systems with intel hx-chipset. on this systems, both kernel crash after some 
time, i think the most time on heavy system load. kernel 2.2 works fine with 
this systems.

i can accecpt, that a scsi-device is deaktivated, if there are some errors, but 
i can't accecpt, that the system crash and hangs.

goodby

Sep 10 09:23:12 p-266 (scsi0:A:5:0): Device is disconnected, re-queuing 
SCB
Sep 10 09:23:12 p-266 (scsi0:A:5:0): Abort Message Sent
Sep 10 09:23:12 p-266 (scsi0:A:5:0): SCB 3 - Abort Completed.
Sep 10 09:23:12 p-266 scsi0:0:5:0: Attempting to queue a TARGET RESET 
message
Sep 10 09:23:12 p-266 scsi0:0:5:0: Command not found
Sep 10 09:23:22 p-266 scsi0:0:5:0: Attempting to queue an ABORT 
message
Sep 10 09:23:22 p-266 scsi0: At time of recovery, card was not paused
Sep 10 09:23:22 p-266 scsi0: Dumping Card State while idle, at SEQADDR 
0x8
Sep 10 09:23:22 p-266 SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0] 
LASTPHASE[0x1]:(P_BUSFREE) 
Sep 10 09:23:22 p-266 SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
SBLKCTL[0x2]:(SELWIDE) 
Sep 10 09:23:22 p-266 SCSIRATE[0x0] SEQCTL[0x10]:(FASTMODE) 
SEQ_FLAGS[0xc0]:(NO_CDB_SENT|NOT_IDENTIFIED) 
Sep 10 09:23:22 p-266 SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] 
SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO) 
Sep 10 09:23:22 p-266 0 
SCB_CONTROL[0xc8]:(ULTRAENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x57] 
Sep 10 09:23:22 p-266 1 
SCB_CONTROL[0xc8]:(ULTRAENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x57] 
Sep 10 09:23:22 p-266 2 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:22 p-266 3 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:22 p-266 4 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:22 p-266 5 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:22 p-266 6 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:22 p-266 7 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:22 p-266 8 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:22 p-266 9 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:22 p-266 10 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:22 p-266 11 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:22 p-266 12 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:22 p-266 13 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:22 p-266 14 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:22 p-266 15 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:22 p-266 4 SCB_CONTROL[0x48]:(ULTRAENB|DISCENB) 
SCB_SCSIID[0x57] SCB_LUN[0x0] 
Sep 10 09:23:22 p-266 (scsi0:A:5:0): Device is disconnected, re-queuing 
SCB
Sep 10 09:23:22 p-266 (scsi0:A:5:0): Abort Message Sent
Sep 10 09:23:22 p-266 (scsi0:A:5:0): SCB 4 - Abort Completed.
Sep 10 09:23:37 p-266 scsi0:0:5:0: Attempting to queue an ABORT 
message
Sep 10 09:23:37 p-266 scsi0: At time of recovery, card was not paused
Sep 10 09:23:37 p-266 scsi0: Dumping Card State while idle, at SEQADDR 
0x8
Sep 10 09:23:37 p-266 SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0] 
LASTPHASE[0x1]:(P_BUSFREE) 
Sep 10 09:23:37 p-266 SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
SBLKCTL[0x2]:(SELWIDE) 
Sep 10 09:23:37 p-266 SCSIRATE[0x0] SEQCTL[0x10]:(FASTMODE) 
SEQ_FLAGS[0xc0]:(NO_CDB_SENT|NOT_IDENTIFIED) 
Sep 10 09:23:37 p-266 SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] 
SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO) 
Sep 10 09:23:37 p-266 0 
SCB_CONTROL[0xc8]:(ULTRAENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x57] 
Sep 10 09:23:37 p-266 1 
SCB_CONTROL[0xc8]:(ULTRAENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x57] 
Sep 10 09:23:37 p-266 2 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:37 p-266 3 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:37 p-266 4 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:37 p-266 5 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:37 p-266 6 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:37 p-266 7 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:37 p-266 8 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:37 p-266 9 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:37 p-266 10 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:37 p-266 11 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:37 p-266 12 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:37 p-266 13 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:37 p-266 14 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:37 p-266 15 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:37 p-266 3 SCB_CONTROL[0x48]:(ULTRAENB|DISCENB) 
SCB_SCSIID[0x57] SCB_LUN[0x0] 
Sep 10 09:23:37 p-266 (scsi0:A:5:0): Device is disconnected, re-queuing 
SCB
Sep 10 09:23:37 p-266 (scsi0:A:5:0): Abort Message Sent
Sep 10 09:23:37 p-266 (scsi0:A:5:0): SCB 3 - Abort Completed.
Sep 10 09:23:37 p-266 scsi: device set offline - not ready or command retry 
failed after bus reset: host 0 channel 0 id 5 lun 0
Sep 10 09:23:47 p-266 scsi0:0:5:0: Attempting to queue an ABORT 
message
Sep 10 09:23:47 p-266 scsi0: At time of recovery, card was not paused
Sep 10 09:23:47 p-266 scsi0: Dumping Card State while idle, at SEQADDR 
0x8
Sep 10 09:23:47 p-266 SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0] 
LASTPHASE[0x1]:(P_BUSFREE) 
Sep 10 09:23:47 p-266 SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
SBLKCTL[0x2]:(SELWIDE) 
Sep 10 09:23:47 p-266 SCSIRATE[0x0] SEQCTL[0x10]:(FASTMODE) 
SEQ_FLAGS[0xc0]:(NO_CDB_SENT|NOT_IDENTIFIED) 
Sep 10 09:23:47 p-266 SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] 
SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO) 
Sep 10 09:23:47 p-266 0 
SCB_CONTROL[0xc8]:(ULTRAENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x57] 
Sep 10 09:23:47 p-266 1 
SCB_CONTROL[0xc8]:(ULTRAENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x57] 
Sep 10 09:23:47 p-266 2 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:47 p-266 3 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:47 p-266 4 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:47 p-266 5 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:47 p-266 6 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:47 p-266 7 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:47 p-266 8 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:47 p-266 9 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:47 p-266 10 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:47 p-266 11 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:47 p-266 12 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:47 p-266 13 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:47 p-266 14 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:47 p-266 15 SCB_CONTROL[0x0] 
SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Sep 10 09:23:47 p-266 4 SCB_CONTROL[0x48]:(ULTRAENB|DISCENB) 
SCB_SCSIID[0x57] SCB_LUN[0x0] 
Sep 10 09:23:47 p-266 (scsi0:A:5:0): Device is disconnected, re-queuing 
SCB
Sep 10 09:23:47 p-266 (scsi0:A:5:0): Abort Message Sent
Sep 10 09:23:47 p-266 (scsi0:A:5:0): SCB 4 - Abort Completed.
Sep 10 09:23:47 p-266 scsi: device set offline - not ready or command retry 
failed after bus reset: host 0 channel 0 id 5 lun 0
Sep 10 09:23:47 p-266 SCSI disk error : host 0 channel 0 id 5 lun 0 return 
code = 30000
Sep 10 09:23:47 p-266 SCSI disk error : host 0 channel 0 id 5 lun 0 return 
code = 30000

Schau auch einmal auf meine Homepage (http://go.to/dieter-ferdinand).
Dort findest du Information zu Linux, Novell, Win95, WinNT, ...

