Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268356AbUIKXQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268356AbUIKXQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 19:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268360AbUIKXQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 19:16:59 -0400
Received: from zork.zork.net ([64.81.246.102]:42408 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S268356AbUIKXQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 19:16:58 -0400
To: romieu@fr.zoreil.com
Cc: jgarzik@pobox.com, akpm@osdl.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1-mm4: r8169: irq 16: nobody cared!/TX Timeout
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: romieu@fr.zoreil.com, jgarzik@pobox.com, akpm@osdl.org,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Date: Sun, 12 Sep 2004 00:16:43 +0100
Message-ID: <6upt4s4cro.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irq 16: nobody cared!
 [<c0106864>] __report_bad_irq+0x24/0x90
 [<c0106ad2>] note_interrupt+0x92/0x160
 [<c0106f12>] do_IRQ+0x162/0x1a0
 [<c010491c>] common_interrupt+0x18/0x20
 [<c0101f80>] default_idle+0x0/0x40
 [<c0101fac>] default_idle+0x2c/0x40
 [<c0102034>] cpu_idle+0x34/0x50
handlers:
[<c02a5470>] (rtl8169_interrupt+0x0/0x1d0)
Disabling IRQ #16
NETDEV WATCHDOG: eth2: transmit timed out
eth2: TX Timeout

CONFIG_R8169_NAPI=y

I downed and upped the interface and it started working again.
