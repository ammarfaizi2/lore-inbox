Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWAJM4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWAJM4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWAJM4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:56:08 -0500
Received: from 213-140-2-69.ip.fastwebnet.it ([213.140.2.69]:18870 "EHLO
	aa002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750815AbWAJM4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:56:07 -0500
Date: Tue, 10 Jan 2006 13:56:17 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Mike Galbraith <efault@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Message-ID: <20060110135617.020f82fb@localhost>
In-Reply-To: <5.2.1.1.2.20060110125942.00bef510@pop.gmx.net>
References: <20060109210035.3f6adafc@localhost>
	<5.2.1.1.2.20060109162113.00ba9fd0@pop.gmx.net>
	<5.2.1.1.2.20060102092903.00bde090@pop.gmx.net>
	<20060101123902.27a10798@localhost>
	<5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
	<5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
	<200512281027.00252.kernel@kolivas.org>
	<20051227190918.65c2abac@localhost>
	<20051227224846.6edcff88@localhost>
	<200512281027.00252.kernel@kolivas.org>
	<5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
	<5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
	<5.2.1.1.2.20060109162113.00ba9fd0@pop.gmx.net>
	<5.2.1.1.2.20060110125942.00bef510@pop.gmx.net>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2006 13:07:33 +0100
Mike Galbraith <efault@gmx.de> wrote:

> Can you please try this version?  It tries harder to correct any 

It seems that you have forgotten the to attach the patch...

> imbalance... hopefully not too hard.  In case you didn't notice, you need 
> to let your exploits run for a bit before the throttling will take 
> effect.  I intentionally start tasks off at 0 cpu usage, so it takes a bit 
> to come up to it's real usage.

Yes, I've seen it.

-- 
	Paolo Ornati
	Linux 2.6.15-plugsched on x86_64
