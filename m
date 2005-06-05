Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVFEKxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVFEKxS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 06:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVFEKxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 06:53:18 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:50562
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261550AbVFEKxO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 06:53:14 -0400
Subject: Re: patch] Real-Time Preemption, plist fixes
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <1117960337.20785.251.camel@tglx.tec.linutronix.de>
References: <Pine.LNX.4.44.0506041748060.17923-100000@dhcp153.mvista.com>
	 <1117960337.20785.251.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 05 Jun 2005 12:53:48 +0200
Message-Id: <1117968828.20785.286.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-05 at 10:32 +0200, Thomas Gleixner wrote:
> On Sat, 2005-06-04 at 17:53 -0700, Daniel Walker wrote:
> > >
> > I already released a patch to fix this.
> 
> Nice to know. Where ?
> 

Ingo pointed me at the patch. 

Sorry, but I really don't see the release there.

> The first time I saw these latencies I has the PI abstraction applied, and
> the most recent time I had the attached patch applied only. This patch is
> small so I'm not sure if it could have that type of effect on task 
> latency.

It fixes a problem and uncovers others, but your comment is more a
question than an explanation for the urgency of the fix. In fact the
original implementation leads to solid deadlocks in
plist_for_each_safe() loops.


I really can't blame Ingo for ignoring this.

tglx


