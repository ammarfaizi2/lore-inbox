Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267972AbUGaQxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267972AbUGaQxU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 12:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267971AbUGaQxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 12:53:20 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:19460 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267972AbUGaQxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 12:53:18 -0400
Subject: Re: [Patch] Per kthread freezer flags (Version 2)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: ncunningham@linuxmail.org
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091143537.2703.61.camel@desktop.cunninghams>
References: <1090999301.8316.12.camel@laptop.cunninghams>
	 <20040729190438.GA468@openzaurus.ucw.cz>
	 <1091139864.2703.24.camel@desktop.cunninghams>
	 <20040729224422.GG18623@elf.ucw.cz>
	 <1091143537.2703.61.camel@desktop.cunninghams>
Content-Type: text/plain
Date: Sat, 31 Jul 2004 18:53:01 +0200
Message-Id: <1091292781.1810.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 09:25 +1000, Nigel Cunningham wrote:
> Okay.. how does this look?
> 
> I applied your changes and fixed a couple of typos I noticed. I also
> added support for the hcvs thread, which is new since rc1-mm1. (This is
> against rc2-mm1).

I'm still suffering from the NIC-won't-come-out-from-S3 (I need to
unplug my CardBus NIC, then plug it again after resuming from S3) when
applying this patch against 2.6.8-rc2-mm1... I'll keep reverting every
hunk of the patch till I find the culprit.

