Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbTIWSvG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbTIWSvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:51:05 -0400
Received: from palrel11.hp.com ([156.153.255.246]:16035 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262234AbTIWSvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:51:02 -0400
Date: Tue, 23 Sep 2003 11:51:04 -0700
From: Grant Grundler <iod00d@hp.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, "David S. Miller" <davem@redhat.com>,
       davidm@hpl.hp.com, davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au,
       ak@suse.de, iod00d@hp.com, peterc@gelato.unsw.edu.au,
       linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030923185104.GA8477@cup.hp.com>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com> <20030923142925.A16490@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923142925.A16490@kvack.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 02:29:25PM -0400, Benjamin LaHaise wrote:
...
> (yet another hardware issue pushed off on software for no significant gain).

Even x86 pays at least a one cycle penalty for every misaligned access.
In general, open source code has no excuse for using misaligned fields.
It's (mostly) avoidable.  TCP/IP headers are the historical exception.

One could make the same arguement that a modern NIC should not require
16 byte alignment for DMA. It's a tradeoff one way or the other.
Just a matter of perspective.

grant
