Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751660AbVLBEqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbVLBEqb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 23:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbVLBEqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 23:46:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750861AbVLBEqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 23:46:30 -0500
Date: Thu, 1 Dec 2005 20:45:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: wfg@mail.ustc.edu.cn, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, christoph@lameter.com, riel@redhat.com,
       a.p.zijlstra@chello.nl, npiggin@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for
 balanced zone aging
Message-Id: <20051201204549.68d3efac.akpm@osdl.org>
In-Reply-To: <20051202021811.GB28539@opteron.random>
References: <20051201101810.837245000@localhost.localdomain>
	<20051201101933.936973000@localhost.localdomain>
	<20051201023714.612f0bbf.akpm@osdl.org>
	<20051201222846.GA3646@dmt.cnet>
	<20051201150349.3538638e.akpm@osdl.org>
	<20051202011924.GA3516@mail.ustc.edu.cn>
	<20051201173015.675f4d80.akpm@osdl.org>
	<20051202020407.GA4445@mail.ustc.edu.cn>
	<20051202021811.GB28539@opteron.random>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> low_mem_reserve

I've a suspicion that the addition of the dma32 zone might have
broken this.
