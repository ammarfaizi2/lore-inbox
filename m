Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933324AbWFXIXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933324AbWFXIXt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 04:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933321AbWFXIX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 04:23:26 -0400
Received: from www.osadl.org ([213.239.205.134]:6291 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1752134AbWFXIXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 04:23:20 -0400
Subject: Re: [patch 1/3] Drop tasklist lock in do_sched_setscheduler
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <20060624010741.6faf355d.akpm@osdl.org>
References: <20060622082758.669511000@cruncher.tec.linutronix.de>
	 <20060622082812.492564000@cruncher.tec.linutronix.de>
	 <20060624010741.6faf355d.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 10:25:05 +0200
Message-Id: <1151137505.25491.331.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 01:07 -0700, Andrew Morton wrote:

> These three patches had intricate dependencies upon the __IP__ and
> __IP_DECL__ gunk which later patches removed, so these patches do not
> compile against the pi-futex patches.
> 
> So I dropped these.
> 
> And I'll drop the lockdep patches, so you'll be able to redo these.

Will do.

	tglx


