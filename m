Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWGCLyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWGCLyI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 07:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWGCLyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 07:54:07 -0400
Received: from www.osadl.org ([213.239.205.134]:49088 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751119AbWGCLyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 07:54:06 -0400
Subject: Re: [RFC][patch 09/44] IA64: Use the new IRQF_ constansts
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Jes Sorensen <jes@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       tony.luck@intel.com, linux-ia64@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <yq0r712hqd1.fsf@jaguar.mkp.net>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
	 <20060701145224.258259000@cruncher.tec.linutronix.de>
	 <yq0r712hqd1.fsf@jaguar.mkp.net>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 13:56:32 +0200
Message-Id: <1151927792.24611.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-03 at 07:36 -0400, Jes Sorensen wrote:
> >>>>> "Thomas" == Thomas Gleixner <tglx@linutronix.de> writes:
> 
> Thomas> Use the new IRQF_ constants and remove the SA_INTERRUPT define
> 
> Hi Thomas,
> 
> You forgot to remove the duplicate define of IRQF_PERCPU from
> include/asm-ia64/irq.h when you introduced the one in
> include/linux/interrupt.h.
> 
> On ia64, without this patch, building Linus' git tree spits out
> compile warnings left right and center (harmless ones though).
> 
> I checked the ia64 code and I don't see any place that actually relied
> on the old define or hardcoded it in asm, but I could be wrong of
> course.
> 
> It compiles, it boots, Enterprise Ready<tm>!

Andrew sent a fix to Linus already.
	
	tglx


