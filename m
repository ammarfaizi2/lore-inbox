Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVC1Stk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVC1Stk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 13:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbVC1Stk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 13:49:40 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:30918
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261997AbVC1Ste (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 13:49:34 -0500
Date: Mon, 28 Mar 2005 10:47:18 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: nickpiggin@yahoo.com.au, hugh@veritas.com, akpm@osdl.org,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
Message-Id: <20050328104718.5e0bda7f.davem@davemloft.net>
In-Reply-To: <20050328085136.A9847@flint.arm.linux.org.uk>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>
	<20050325212234.F12715@flint.arm.linux.org.uk>
	<4244C3B7.4020409@yahoo.com.au>
	<20050326113530.A12809@flint.arm.linux.org.uk>
	<424566E0.80001@yahoo.com.au>
	<20050326155254.E12809@flint.arm.linux.org.uk>
	<42462B7A.4080305@yahoo.com.au>
	<20050327085725.A30883@flint.arm.linux.org.uk>
	<20050327101739.48c843e1.davem@davemloft.net>
	<20050328085136.A9847@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005 08:51:36 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> Why would I want to do this, given that decrementing mm->nr_ptes in
> free_pgd_slow() would make it negative ?  Am I missing something
> obvious?

You were saying there was no way to figure out which mm is
assosociate a particular pgd, and I'm merely showing you
how you can in fact do it. :-)
