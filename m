Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263431AbTIWXhC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 19:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTIWXhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 19:37:02 -0400
Received: from rth.ninka.net ([216.101.162.244]:4774 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263412AbTIWXg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 19:36:59 -0400
Date: Tue, 23 Sep 2003 16:35:42 -0700
From: "David S. Miller" <davem@redhat.com>
To: Grant Grundler <iod00d@hp.com>
Cc: bcrl@kvack.org, tony.luck@intel.com, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au, ak@suse.de,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923163542.55fd8ed9.davem@redhat.com>
In-Reply-To: <20030923223540.GA10490@cup.hp.com>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
	<20030923142925.A16490@kvack.org>
	<20030923185104.GA8477@cup.hp.com>
	<20030923115122.41b7178f.davem@redhat.com>
	<20030923203819.GB8477@cup.hp.com>
	<20030923134529.7ea79952.davem@redhat.com>
	<20030923223540.GA10490@cup.hp.com>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 15:35:40 -0700
Grant Grundler <iod00d@hp.com> wrote:

> And someone at Intel obviously agrees the newer architectures
> should support misaligned access in SW since ever RISC chip
> they've built (starting with i860, ~1989) does it that way.

That's a amusing coincidence since at least some people think ia64
will end up the same way the i860 did :-)

In the past I did always advocate things the way you are right now,
but these days I think I've been wrong the whole time and Intel on x86
is doing the right thing.

They do everything in hardware and this makes the software so much
simpler.  Sure, there's a lot of architectually inherited complexity
in the x86 family, but their engineering priorities mean there is so
much other stuff you simply never have to think about as a programmer.

