Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265713AbUAKCgD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 21:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265714AbUAKCgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 21:36:02 -0500
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:27998 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265713AbUAKCgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 21:36:00 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0)
Date: Sat, 10 Jan 2004 23:35:49 +0000
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401102335.49022.murilo_pontes@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My ABNT-2 keyboard work fine with kernel 2.6.0, but I found two bugs in:
versions:
2.6.1-rc1
2.6.1-rc1-mm1
2.6.1-rc1-mm2
2.6.1-rc2
2.6.1-rc2-mm1
2.6.1-rc3
2.6.1-mm1
2.6.1-mm2


First bug:
My ABNT-2 keyboard not work "/" in console mode, but work fine in X11.
I turnaround problem with "/" near of num lock!
I has see in syslog: atkbd.c: Unknown key released (translated set 2, code 
0x7a on isa0060/serio0)

Second bug:
Loop device not work!

mount $RAMIMAGE $RAMMOUNTDIR -v -t minix -o loop=/dev/loop/0
ioctl: LOOP_SET_FD
losetup -d /dev/loop0
ioctl: LOOP_CLR_FD

23:30:19 [root@murilo:/MRX/tools/mrxcdram]#mount -V
mount: mount-2.12
23:31:00 [root@murilo:/MRX/tools/mrxcdram]#


Thanks for any help!!!!
