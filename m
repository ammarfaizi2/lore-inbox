Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVBHKoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVBHKoE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 05:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVBHKoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 05:44:04 -0500
Received: from bender.bawue.de ([193.7.176.20]:33995 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S261509AbVBHKoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 05:44:00 -0500
Date: Tue, 8 Feb 2005 11:43:44 +0100
From: Joerg Sommrey <jo@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: strange repeating keys and irq 0 routing on 2.6.x
Message-ID: <20050208104344.GA4229@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

a few times in the last couple of months I experienced some strange key
repeating in X.  A single key-press sometimes results in 2-8 typed
keys.  This started around 2.6.8 but I'm not sure.  It was last seen on
2.6.10-ac8.

There were similar problems reported for Toshiba laptops and within XFree,
but my problem seems to be different.

The key repeating starts some hours after reboot and it gets
worse with time.  After one day the keyboard is not usable anymore.
At the same time ntpd often fails reading the radio clock attached to a
serial port. 

It doesn't happen after every reboot.  BUT: Sometimes IRQ 0 is processed
on CPU1 after reboot (though /proc/irq/0/smp_affinity is 3 and all other
irq are handled on CPU0). In these cases the repeating keys appear.

The box has two Athlon MPs.

What can I do to gather more information?

-jo

-- 
-rw-r--r--  1 jo users 63 2005-01-10 08:33 /home/jo/.signature
