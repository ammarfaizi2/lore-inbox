Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbVKHJq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbVKHJq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 04:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbVKHJq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 04:46:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:13459 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965035AbVKHJqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 04:46:25 -0500
Subject: Re: CLOCK_REALTIME_RES and nanosecond resolution
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: tglx@linutronix.de
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1131442459.18108.75.camel@tglx.tec.linutronix.de>
References: <1131418511.4652.88.camel@gaston>
	 <1131442459.18108.75.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 20:45:37 +1100
Message-Id: <1131443137.4652.101.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is the resolution which you can expect for timers (nanosleep and
> interval timers) as the timers depend on the jiffy tick.
> 
> The resolution of the readout functions is not affected by this.

Ok, thanks, POSIX spec wasn't very clear about that 

Ben.


