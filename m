Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAIOTQ>; Tue, 9 Jan 2001 09:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129759AbRAIOTG>; Tue, 9 Jan 2001 09:19:06 -0500
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:26019 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S129562AbRAIOSy>; Tue, 9 Jan 2001 09:18:54 -0500
From: anders.karlsson@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: linux-kernel@vger.kernel.org
Message-ID: <802569CF.004E990A.00@d06mta03.portsmouth.uk.ibm.com>
Date: Tue, 9 Jan 2001 14:18:28 +0000
Subject: 2.4.0-ac4 lockups
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi,

I'm currently running ROCK Linux 1.3.11 on a MiTAC 6033 laptop, XFree86
4.0.1
and the rest of the linux install is quite bleeding edge (I can find out
version
numbers for most things is needed). In this box there is a PCMCIA Token
Ring
card (IBM Turbo 16/4 PC Card 2) and to drive this, pcmcia-cs-3.1.23.

The problem that is showing its ugly face is that after some prolonged
network
activity the system will lock solidly. The magic SysRq keys still work,
well sort
of anyway. Alt-SysRq-s does inspire the system to disk activity.
Alt-SysRq-u
doesn't do enough for the disk-led to light up but Alt-SysRq-b does reboot
the
system. Upon reboot I go and fetch a coffee while the system is fsck'ing
the
filesystems.

I have had several lockups in the last couple of days. It started in
2.4.0-prer
and with the Token Ring card. Some crash messages has been relating to
virtual memory at invalid addresses and when I get a good crash message I
will write it down and post to the list.

Any ideas anyone?

      /Anders


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
