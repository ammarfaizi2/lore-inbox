Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTK0W7W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 17:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbTK0W7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 17:59:22 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:39636 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261506AbTK0W7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 17:59:21 -0500
Subject: Re: APM Suspend Problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Misha Nasledov <misha@nasledov.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031127062057.GA31974@nasledov.com>
References: <20031127062057.GA31974@nasledov.com>
Content-Type: text/plain
Message-Id: <1069921674.6691.202.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 28 Nov 2003 09:58:21 +1100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> hdc: start_power_step(step: 0)
> hdc: completing PM request, suspend
> hda: start_power_step(step: 0)
> hda: start_power_step(step: 1)
> hda: complete_power_step(step: 1, stat: 50, err: 0)
> hda: completing PM request, suspend
> hda: Wakeup request inited, waiting for !BSY...
> hda: start_power_step(step: 1000)
> blk: queue c138fa00, I/O limit 4095Mb (mask 0xffffffff)
> hda: completing PM request, resume
> hdc: Wakeup request inited, waiting for !BSY...
> hdc: start_power_step(step: 1000)
> hdc: completing PM request, resume

Those messages are harmless, they just show normal operations
of the IDE suspend code. I beleive it's probably time to disable
the debug code in there ;)

Ben.

