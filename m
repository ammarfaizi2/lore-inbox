Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbTJ2DqL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 22:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbTJ2DqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 22:46:11 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:61824 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261793AbTJ2DpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 22:45:21 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 28 Oct 2003 19:45:12 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: SiS ISA bridge IRQ routing on 2.6 ...
Message-ID: <Pine.LNX.4.56.0310281931510.933@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, I saw that Marcelo merged Alan bits to fix the IRQ routing with the
newest SiS ISA bridges. To make it really short the ISA bridge inside the
SiS 85C503/5513 issue IRQ routing requests on 0x60, 0x61, 0x62 and 0x63
for the USB hosts and the current code does not handle them correctly.
2.6-test9 does not have those bits and the USB  subsystem won't work w/out
that. Did Alan ever posted the patch for 2.6? If yes, did you simply miss
it or you have a particular reason to not merge it?
I really would like to remove the SiS IRQ patch from my to-apply-2.6
folder :)



- Davide

