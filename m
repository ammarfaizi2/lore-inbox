Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVFSKEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVFSKEc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 06:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVFSKEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 06:04:32 -0400
Received: from mail.linicks.net ([217.204.244.146]:3858 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S262176AbVFSKEa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 06:04:30 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2 errors in 2.6.12
Date: Sun, 19 Jun 2005 11:04:28 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506191104.28900.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>and my SBLive! plays only on 2 repros Front left and right.

Yes - I noticed something with my SB Live.  I thought it was me, but going 
through everythnig this morning, I don't think it is.

>From 2.6.11.12 dmesg:

Jun 17 18:39:45 linuxamd kernel: Advanced Linux Sound Architecture Driver 
Version 1.0.8 (Thu Jan 13 09:39:32 2005 UTC).
Jun 17 18:39:45 linuxamd kernel: ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 5 
(level, low) -> IRQ 5
Jun 17 18:39:45 linuxamd kernel: ALSA device list:
Jun 17 18:39:45 linuxamd kernel:   #0: Sound Blaster Live! (rev.7, 
serial:0x80611102) at 0xe000, irq 5

And here from new 2.6.12 dmesg:

Jun 18 15:27:41 linuxamd kernel: Advanced Linux Sound Architecture Driver 
Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
Jun 18 15:27:41 linuxamd kernel: PCI: Found IRQ 5 for device 0000:00:0f.0
Jun 18 15:27:41 linuxamd kernel: ALSA device list:
Jun 18 15:27:41 linuxamd kernel:   #0: SB Live [Unknown] (rev.7, 
serial:0x80611102) at 0xe000, irq 5

Something is awry?

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
