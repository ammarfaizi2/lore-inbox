Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUF3Ugo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUF3Ugo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUF3Ugo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:36:44 -0400
Received: from bender.bawue.de ([193.7.176.20]:45461 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S262356AbUF3Ugg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:36:36 -0400
Date: Wed, 30 Jun 2004 22:36:21 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: System not booting after acpi_power_off()
Message-ID: <20040630203621.GA4712@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

my box behaves a bit strange after "shutdown -h".  The system performs a
clean shutdown, but afterwards the front-side power button doesn't
power-on anymore.  After turning off power completely for 5 - 10 sec
using the power supply's rear-side switch system boots again.  I found a
hint that this might be caused by a power supply that doesn't fully
conform to ATX 2.01.  Though this might be the real cause of my problem,
I'd like to know if there is a workaround.  Shutting down from an older
Knoppix-CD (kernel 2.4.20 using apm) works fine, i.e. "front-side
power-on" works.  However, with 2.6 running on a SMP box there seems to
be no way to poweroff via apm.

Is there a way to let machine_power_off() behave like apm_power_off() on
a SMP box?

My system:
kernel:	2.6.7-mm1 (same with other 2.4 and 2.6)
CPU:	2 x Athlon MP
board:	Tyan Tiger MPX (S2466)

TIA
-jo

-- 
-rw-r--r--    1 jo       users          80 2004-06-30 19:31 /home/jo/.signature
