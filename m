Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269412AbTCDQfS>; Tue, 4 Mar 2003 11:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269418AbTCDQfS>; Tue, 4 Mar 2003 11:35:18 -0500
Received: from havoc.daloft.com ([64.213.145.173]:27018 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S269412AbTCDQfR>;
	Tue, 4 Mar 2003 11:35:17 -0500
Date: Tue, 4 Mar 2003 11:45:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Kai Bankett <kai.bankett@ontika.net>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][IO_APIC] 2.5.63bk7 irq_balance improvments / bug-fixes
Message-ID: <20030304164540.GA23172@gtf.org>
References: <200303041733.14930.kai.bankett@ontika.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303041733.14930.kai.bankett@ontika.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would it be possible for you to test Arjan's irqbalance daemon?

We believe it is a superior solution to in-kernel irq balancing, but
also, can be safely used in addition to in-kernel irq balancing.
(we just have not run benchmarks to prove this yet :))

http://people.redhat.com/arjanv/irqbalance/

This userspace solution is shipping with current Red Hat, and is
portable to non-ia32 architectures.

	Jeff



