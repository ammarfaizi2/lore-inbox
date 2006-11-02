Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWKBRU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWKBRU0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 12:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWKBRU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 12:20:26 -0500
Received: from www.osadl.org ([213.239.205.134]:54716 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750768AbWKBRUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 12:20:25 -0500
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required)
	[2.6.18-rc4-mm1]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1162455263.15900.320.camel@localhost.localdomain>
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de>
	 <1162417916.15900.271.camel@localhost.localdomain>
	 <20061102001838.GA911@rhlx01.hs-esslingen.de>
	 <1162452676.15900.287.camel@localhost.localdomain>
	 <1162455263.15900.320.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 18:22:08 +0100
Message-Id: <1162488129.15900.396.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 09:14 +0100, Thomas Gleixner wrote:
> On Thu, 2006-11-02 at 08:31 +0100, Thomas Gleixner wrote:
> > Does it resume normal operation after the "ACPI: lapic on CPU 0 stops in
> > C2[C2]" message ?
> > 
> > It is easy to fix by marking all AMDs broken again, but I really want to
> > avoid this.
> 
> Doo, found a brown paperbag bug.

I uploaded a new queue with more fixups.

http://tglx.de/projects/hrtimers/2.6.19-rc4-mm1/patch-2.6.19-rc4-mm1-hrt-dyntick4.patch

	tglx


