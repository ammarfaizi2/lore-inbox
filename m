Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTERDhL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 23:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTERDhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 23:37:11 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:65414 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261944AbTERDhK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 23:37:10 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 17 May 2003 20:49:11 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SIS-650+CPQ Presario 3045US+USB ...
Message-ID: <Pine.LNX.4.55.0305172022440.4235@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've spent a few horrible hours terrified by the idea of a possible XP
install on my new laptop. It's a Compaq Presario 3045US with SIS-650
chipset and there was no way to have USB bits work with it because of a
IRQ routing issue. The PCI routing table of that machine issues requests
for 0x60, 0x61 and 0x63 that, to have everything to work out, must be
handled like the 0x4* cases. Now, while 0x60 and 0x63 were ot documented
at all, 0x61 was documented as IDEIRQ and I was a bit worried about that.
But this is not the case since the machine issue 0x60..0x63 for the four
OHCI devices. Now USB is working great with keyboard, mouse and drives. I
still have to say bye to the Broadcom 54g wireless interface though ...



- Davide

