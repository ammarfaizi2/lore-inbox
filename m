Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbUCYQRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 11:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbUCYQRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 11:17:33 -0500
Received: from dsl-64-30-195-78.lcinet.net ([64.30.195.78]:35471 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S263215AbUCYQRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 11:17:31 -0500
Message-ID: <03ec01c41284$a99cb8e0$d100a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Kernel" <linux-kernel@vger.kernel.org>
Subject: 2.6.4 Hard lockup
Date: Thu, 25 Mar 2004 08:17:25 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System just froze. Magic Keys didn't work. Shift-Print didn't work to print
the screen nothing at all. But, I did have a digital camera handy, so I have
some information to give. I did check the syslog log files and nothing was
recorded.

[<c0000000b>] NMI Watchdog detected LOCKUP on CPU1, eip c013c769, registers:
CPU:    1
EIP:        0060:[<c013c769>]    Not tainted
EFLAGS:    00000086
EIP is at .text.lock.module+0x145/0x14c
eax:   f77a2000    ebx:    c013c4cf    ecx:    c0138f03    edx:    c825ca30
esi:    0000000    edi:    00000096    ebp:    c013c4c1    esp:    f77a33374
ds:    007b    cs:    007b    ss: 0068
Process syslog-ng (pid: 748, threadin=f77a2000 task=f7435820)
Stack:   00000004    c02ca580    00000001    c013c4cf    00000000
c011ad20    f7435820    c0135368
            c013c4cf    c025d300    c013c4cf    f77a3468    c011b773
c013c4cf    00000000    c011ae3f
            f77a3468    f88e9400    0000000    00000000    00861ce7
0000000    c02ca580    00000001
Call Trace:
[<00000004>]

Here is a link to the photos, I did my best to get accurate information
copied from them
http://ftp.jg555.com/crash/

----
Jim Gifford
maillist@jg555.com

