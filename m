Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTKRNso (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTKRNms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:42:48 -0500
Received: from ns.suse.de ([195.135.220.2]:1746 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262747AbTKRNmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:42:20 -0500
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86  Architecture
References: <JB3R.23s.23@gated-at.bofh.it.suse.lists.linux.kernel>
	<JWKQ.7nS.15@gated-at.bofh.it.suse.lists.linux.kernel>
	<LhtX.bs.15@gated-at.bofh.it.suse.lists.linux.kernel>
	<LhtX.bs.13@gated-at.bofh.it.suse.lists.linux.kernel>
	<m3k76qsf8i.fsf@averell.firstfloor.org.suse.lists.linux.kernel>
	<Pine.LNX.4.53.0310271603580.21953@montezuma.fsmlabs.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Oct 2003 22:15:06 +0100
In-Reply-To: <Pine.LNX.4.53.0310271603580.21953@montezuma.fsmlabs.com.suse.lists.linux.kernel>
Message-ID: <p73brs29ycl.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> writes:

> On Mon, 27 Oct 2003, Andi Kleen wrote:
> 
> > The wmb() change is not needed, unless you have an oostore CPU
> > (x86 has ordered writes by default). It probably does not hurt
> > neither though (I do it the same way on x86-64), but also doesn't 
> > change anything.
> 
> The original intent was to fix an SMP P5 system, it oopses otherwise under 
> load.

That doesn't make any sense. P5 doesn't support SFENCE.

-Andi
