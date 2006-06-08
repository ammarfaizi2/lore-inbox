Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbWFHWbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWFHWbe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 18:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWFHWbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 18:31:34 -0400
Received: from www.osadl.org ([213.239.205.134]:21737 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S965031AbWFHWbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 18:31:34 -0400
Subject: Re: [PATCH] genirq: Fix missing initializer for unmask in
	no_irq_chip
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1149793075.5257.51.camel@localhost.localdomain>
References: <20060517001310.GA12877@elte.hu>
	 <20060517221536.GA13444@elte.hu> <20060519145225.GA12703@elte.hu>
	 <20060607165456.GC13165@flint.arm.linux.org.uk>
	 <1149700829.5257.16.camel@localhost.localdomain>
	 <1149706650.5257.19.camel@localhost.localdomain>
	 <20060608113534.GA5050@flint.arm.linux.org.uk>
	 <1149768256.5257.37.camel@localhost.localdomain>
	 <20060608152926.GA15337@flint.arm.linux.org.uk>
	 <1149782293.5257.43.camel@localhost.localdomain>
	 <1149793075.5257.51.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 00:32:11 +0200
Message-Id: <1149805931.5257.111.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 20:57 +0200, Thomas Gleixner wrote:
> I uploaded a new patch series which contains the ARM side fix and I
> added error messages for that case at the appropriate places.

Sorry, pushed out the wrong one.

Uploaded the non broken version

http://www.tglx.de/projects/armirq/2.6.17-rc6/patch-2.6.17-rc6-armirq5.patch
http://www.tglx.de/projects/armirq/2.6.17-rc6/patch-2.6.17-rc6-armirq5.patches.tar.bz2

	tglx


