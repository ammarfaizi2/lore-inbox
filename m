Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVATFuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVATFuC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 00:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVATFuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 00:50:02 -0500
Received: from palrel13.hp.com ([156.153.255.238]:53174 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262054AbVATFt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 00:49:58 -0500
Date: Wed, 19 Jan 2005 21:49:35 -0800
From: Grant Grundler <iod00d@hp.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>, Peter Chubb <peterc@gelato.unsw.edu.au>,
       Tony Luck <tony.luck@intel.com>,
       Darren Williams <dsw@gelato.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       Chris Wedgwood <cw@f00f.org>, torvalds@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       Ia64 Linux <linux-ia64@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: Horrible regression with -CURRENT from "Don't busy-lock-loop in preemptable spinlocks" patch
Message-ID: <20050120054935.GC11410@esmail.cup.hp.com>
References: <20050117055044.GA3514@taniwha.stupidest.org> <20050116230922.7274f9a2.akpm@osdl.org> <20050117143301.GA10341@elte.hu> <20050118014752.GA14709@cse.unsw.EDU.AU> <16877.42598.336096.561224@wombat.chubb.wattle.id.au> <20050119080403.GB29037@elte.hu> <16878.9678.73202.771962@wombat.chubb.wattle.id.au> <20050119092013.GA2045@elte.hu> <16878.54402.344079.528038@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16878.54402.344079.528038@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 08:43:30AM +1100, Paul Mackerras wrote:
> I suggest read_poll(), write_poll(), spin_poll(),...

Erm...those names sound way too much like existing interfaces.
Perhaps check_read_lock()/check_write_lock() ?

If they don't get used too much, the longer name should be ok.

grant
