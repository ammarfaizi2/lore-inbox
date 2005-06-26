Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVFZRVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVFZRVL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 13:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVFZRVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 13:21:00 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:42182 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261466AbVFZRUv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 13:20:51 -0400
Subject: Re: Possible spin-problem in nanosleep()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-os@analogic.com
Cc: Andreas Schwab <schwab@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0506240733520.20914@chaos.analogic.com>
References: <Pine.LNX.4.61.0506230812160.15775@chaos.analogic.com>
	 <jell516ymn.fsf@sykes.suse.de>
	 <Pine.LNX.4.61.0506230841390.15910@chaos.analogic.com>
	 <Pine.LNX.4.61.0506231058560.16531@chaos.analogic.com>
	 <1119546715.17066.20.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0506240733520.20914@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119806289.28649.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Jun 2005 18:18:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-06-24 at 12:42, Richard B. Johnson wrote:
> Are you saying that each might get the CPU from between 0 and 1
> tick, i.e., asynchronous with the tick? If so, depending upon the
> phase between the timer-tick and when a task gets awakened, a task
> may never get any CPU time at all. If so, this is a bug.

No I'm saying the samping rate of the timer tick limits the resolution
of accounting of data (ie straight information theory limits)

