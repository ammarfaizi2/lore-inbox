Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUHUNEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUHUNEP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 09:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUHUNEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 09:04:14 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:46511 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S265051AbUHUNEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 09:04:11 -0400
Date: Sat, 21 Aug 2004 15:04:24 +0200
To: linux-kernel@vger.kernel.org
Subject: complete freeze of 2.6.8.1 with ntp
Message-ID: <20040821130423.GA6141@tink>
Reply-To: emard@softhome.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: emard@softhome.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI

This doesn't exist in 2.6.7 and appears in 2.6.8.1.
I have debian sarge latest sync.
I do:

/etc/init.d/ntp restart
(but ntp is only stopped, not started, it's probably debian's fault)
(not when network is active I do)

/etc/init.d/ntp start
and check ntp status time several times with:

ntpq -c pe

I think (can't check) that machine freezes when the ntp has reached
status of being ready to change kernel's clock synthesizer, 
the kernel completely halts. No oops, no blinking leds just
whole machine stops responding.

I tried with and withot HPET, result is the same.

Emard
