Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270673AbTGUTYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270674AbTGUTYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:24:49 -0400
Received: from thor.65535.net ([216.17.104.19]:23563 "EHLO thor.65535.net")
	by vger.kernel.org with ESMTP id S270673AbTGUTYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:24:45 -0400
Date: Mon, 21 Jul 2003 12:39:14 -0700 (PDT)
From: Rus Foster <rghf@fsck.me.uk>
X-X-Sender: rghf@thor.65535.net
To: linux-kernel@vger.kernel.org
Subject: Is this bad?
Message-ID: <20030721123836.K2947@thor.65535.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've started getting the following at boot time on my Dual AMD 2000MP+
Jul 21 20:36:42 duocity kernel: Freeing unused kernel memory: 136k freed
Jul 21 20:36:42 duocity kernel:
Jul 21 20:36:42 duocity kernel: wait_on_irq, CPU 1:
Jul 21 20:36:42 duocity kernel: irq:  1 [ 1 0 ]
Jul 21 20:36:42 duocity kernel: bh:   0 [ 0 0 ]
Jul 21 20:36:42 duocity kernel: Stack dumps:
Jul 21 20:36:42 duocity kernel: CPU 0: <unknown>
Jul 21 20:36:42 duocity kernel: CPU 1:dffe3e2c c03819fd 00000001 00000040
000000
00 c010878d c0381a12 dfcef000
Jul 21 20:36:42 duocity kernel:        c04dbb40 dfe0f400 c0217dea dfcef000
dfcef
000 c021801c dfcef000 00000000
Jul 21 20:36:42 duocity kernel:        dfcef000 dfcef000 dfe0f3e4 c02143a0
dfcef
000 dffe2000 00000001 00000000
Jul 21 20:36:42 duocity kernel: Call Trace: [<c010878d>]  [<c0217dea>]
[<c02180
1c>]  [<c02143a0>]  [<c0214c6e>]  [<c0137bb1>]  [<c012ea4c>]  [<c0137e44>]
[<c0
1369e1>]  [<c01368f2>]  [<c0136c56>]  [<c0107063>]  [<c01050b9>]
[<c0105708>]
Jul 21 20:36:42 duocity kernel:
Jul 21 20:36:42 duocity kernel: ohci1394_0: irq_handler: Bus reset
requested
Jul 21 20:36:42 duocity kernel: ohci1394_0: Cancel request received
Jul 21 20:36:42 duocity kernel: ohci1394_0: Got RQPkt interrupt
status=0x0000840
9

I'm guessing this is bad...CPU on the way out?

Rus

-- 
www: http://jvds.com   | Virtual Servers from just $15/mo
MSNM: support@jvds.com | Totally Customizable Technology
e: rghf@jvds.com       | FreeBSD & Linux
       10% donation to FreeBSD.org on each purchase
