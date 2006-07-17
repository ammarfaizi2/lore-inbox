Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWGQUXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWGQUXI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 16:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWGQUXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 16:23:08 -0400
Received: from mail.suse.de ([195.135.220.2]:4589 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751162AbWGQUXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 16:23:07 -0400
From: Andreas Schwab <schwab@suse.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: linux-kernel@vger.kernel.org, keir@xensource.com,
       Tony Lindgren <tony@atomide.com>, zach@vmware.com,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kernel/timer.c: next_timer_interrupt() strange/buggy(?) code (2.6.18-rc1-mm2)
References: <20060717185330.GA32264@rhlx01.fht-esslingen.de>
X-Yow: Did I do an INCORRECT THING??
Date: Mon, 17 Jul 2006 22:22:53 +0200
In-Reply-To: <20060717185330.GA32264@rhlx01.fht-esslingen.de> (Andreas Mohr's
	message of "Mon, 17 Jul 2006 20:53:30 +0200")
Message-ID: <jehd1g6kwy.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr <andi@rhlx01.fht-esslingen.de> writes:

> (a "continue" simply continue:s the loop without checking the loop condition
> at the bottom, right?)

No.  A continue jumps to the end of the loop body.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
