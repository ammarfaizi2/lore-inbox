Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbTIXCBP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 22:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbTIXCBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 22:01:15 -0400
Received: from holomorphy.com ([66.224.33.161]:59267 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261250AbTIXCBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 22:01:08 -0400
Date: Tue, 23 Sep 2003 18:58:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Grant Grundler <iod00d@hp.com>, bcrl@kvack.org, tony.luck@intel.com,
       davidm@hpl.hp.com, davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au,
       ak@suse.de, peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030924015841.GC21455@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>,
	Grant Grundler <iod00d@hp.com>, bcrl@kvack.org, tony.luck@intel.com,
	davidm@hpl.hp.com, davidm@napali.hpl.hp.com,
	peter@chubb.wattle.id.au, ak@suse.de, peterc@gelato.unsw.edu.au,
	linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com> <20030923142925.A16490@kvack.org> <20030923185104.GA8477@cup.hp.com> <20030923115122.41b7178f.davem@redhat.com> <20030923203819.GB8477@cup.hp.com> <20030923134529.7ea79952.davem@redhat.com> <20030923223540.GA10490@cup.hp.com> <20030923163542.55fd8ed9.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923163542.55fd8ed9.davem@redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 04:35:42PM -0700, David S. Miller wrote:
> That's a amusing coincidence since at least some people think ia64
> will end up the same way the i860 did :-)
> In the past I did always advocate things the way you are right now,
> but these days I think I've been wrong the whole time and Intel on x86
> is doing the right thing.
> They do everything in hardware and this makes the software so much
> simpler.  Sure, there's a lot of architectually inherited complexity
> in the x86 family, but their engineering priorities mean there is so
> much other stuff you simply never have to think about as a programmer.

Several of the x86 "hardware assists" need some rather hefty hacks
codewise to cope with their concomitant data structure proliferations
under industrial workloads, and generally have me begging for RISC's
system-level features instead (which, of course, require various
undoings of Linux' x86 crossdressings to exploit).

Given the reactions in prior threads, this message clearly needs to
wait a long while before it will ever be heard.


-- wli
