Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265698AbUATUrI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 15:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265713AbUATUrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 15:47:08 -0500
Received: from painless.aaisp.net.uk ([217.169.20.17]:25263 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S265698AbUATUrA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 15:47:00 -0500
Subject: Interrupt errors and dvd pausing under 2.6
From: Andrew Clayton <andrew@digital-domain.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1074631617.1765.27.camel@alpha.digital-domain.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 20 Jan 2004 20:46:57 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing some interrupt errors in /proc/interrupts and the message
'spurious 8259A interrupt: IRQ7.' in dmesg,/var/log/messages. 


I am also seeing dvd pauses, which seems to last for about 5-10 seconds,
these happen about every 20 minutes. The rest of the system is OK. When
these pauses happen the number of interrupt errors increases. I have
seen this with 2.6.1-mm[1345]. With 2.6.1 and 2.6.1-bk[45] I am unable
to play a dvd at all, don't remember the error message (can reproduce it
if need be). Using libxine1-1_rc3a

Running a vmstat in the background shows nothing abnormal during the
pauses.


This is under Fedora Core 1 on a AMD Athlon 1800+ XP with 512MB ram.
There is 2 hard drives on ide0 and a cdrom and dvdrom on ide1

I don't have any APIC support in the kernel, preempt is disabled and and
everything is built in. 


2.4 works fine. 2.4.25-pre4 is the last 2.4 kernel I've been running.


Just ask if you want any more info.

I'd appreciate it if you could CC me in any replies.

Thanks, 

Andrew Clayton

