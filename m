Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310750AbSCHJLV>; Fri, 8 Mar 2002 04:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310751AbSCHJLC>; Fri, 8 Mar 2002 04:11:02 -0500
Received: from tassadar.physics.auth.gr ([155.207.123.25]:49544 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S310750AbSCHJKp>; Fri, 8 Mar 2002 04:10:45 -0500
Date: Fri, 8 Mar 2002 11:10:43 +0200 (EET)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: linux-kernel@vger.kernel.org
Subject: strange message from swapper , 2.4.18-ac2 + bridge-nf-0.0.6-against-2.4.18.diff
Message-ID: <Pine.LNX.4.44.0203081100260.31976-100000@tassadar.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello ,

Yesterday i got those messages in my linux bridge logfile . Apart from
them , the box continues to operate normally . The box was not doing
anything at all at this moment .

Mar  7 14:21:30 none kernel:
Mar  7 14:21:30 none kernel: Pid: 0, comm:              swapper
Mar  7 14:21:30 none kernel: EIP: 0010:[default_idle+35/40] CPU: 0 EFLAGS: 00000246    Not tainted
Mar  7 14:21:30 none kernel: EAX: 00000000 EBX: c0252000 ECX: c10e2260 EDX: c10e2260
Mar  7 14:21:30 none kernel: ESI: c0105150 EDI: ffffe000 EBP: 0008e000 DS: 0018 ES: 0018
Mar  7 14:21:30 none kernel: CR0: 8005003b CR2: 0804cf54 CR3: 017c4000 CR4: 00000010
Mar  7 14:21:30 none kernel: Call Trace: [cpu_idle+63/84] [rest_init+0/40] [rest_init+39/40]
Mar  7 14:21:30 none kernel:
Mar  7 14:21:30 none kernel: Pid: 0, comm:              swapper
Mar  7 14:21:30 none kernel: EIP: 0010:[default_idle+35/40] CPU: 0 EFLAGS: 00000246    Not tainted
Mar  7 14:21:30 none kernel: EAX: 00000000 EBX: c0252000 ECX: c10e6260 EDX: c10e6260
Mar  7 14:21:30 none kernel: ESI: c0105150 EDI: ffffe000 EBP: 0008e000 DS: 0018 ES: 0018
Mar  7 14:21:30 none kernel: CR0: 8005003b CR2: 080bd000 CR3: 01cba000 CR4: 00000010
Mar  7 14:21:30 none kernel: Call Trace: [cpu_idle+63/84] [rest_init+0/40] [rest_init+39/40]
Mar  7 14:21:31 none kernel:
Mar  7 14:21:31 none kernel: Pid: 0, comm:              swapper
Mar  7 14:21:31 none kernel: EIP: 0010:[default_idle+35/40] CPU: 0 EFLAGS: 00000246    Not tainted
Mar  7 14:21:31 none kernel: EAX: 00000000 EBX: c0252000 ECX: c10e6260 EDX: c10e6260
Mar  7 14:21:31 none kernel: ESI: c0105150 EDI: ffffe000 EBP: 0008e000 DS: 0018 ES: 0018
Mar  7 14:21:31 none kernel: CR0: 8005003b CR2: 080bd000 CR3: 01cba000 CR4: 00000010
Mar  7 14:21:31 none kernel: Call Trace: [cpu_idle+63/84] [rest_init+0/40] [rest_init+39/40]


Linux none 2.4.18-ac2 #1 Thu Feb 28 22:42:29 EET 2002 i586 unknown

The distribution is slackware 8 .

 Kind regards
--
=============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle Univercity of Thessaloniki , Greece
=============================================================================

