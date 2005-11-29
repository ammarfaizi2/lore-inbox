Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbVK2X4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbVK2X4q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbVK2X4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:56:46 -0500
Received: from ozlabs.org ([203.10.76.45]:4332 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751407AbVK2X4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:56:45 -0500
Date: Wed, 30 Nov 2005 10:56:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andi Kleen <ak@suse.de>
Cc: Nicholas Miell <nmiell@comcast.net>, Stephane Eranian <eranian@hpl.hp.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051129235626.GC9659@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andi Kleen <ak@suse.de>, Nicholas Miell <nmiell@comcast.net>,
	Stephane Eranian <eranian@hpl.hp.com>,
	Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
	linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
References: <20051129180903.GB6611@frankl.hpl.hp.com> <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy> <20051129215207.GR19515@wotan.suse.de> <1133303615.3271.12.camel@entropy> <20051129224346.GS19515@wotan.suse.de> <1133305338.3271.30.camel@entropy> <20051129231750.GU19515@wotan.suse.de> <1133306966.3271.36.camel@entropy> <20051129233920.GW19515@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129233920.GW19515@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 12:39:20AM +0100, Andi Kleen wrote:
> > Well, if that's all you want them to use RDPMC 0 for, why not just make
> > PMCs programmable from userspace?
> 
> First we need to have a cycle counter PMC anyways for the NMI watchdog.
> So it can as well be used for other purposes.

But the watchdog doesn't require it to be in the same place on all
machines.  Exporting it turns an internal requirement into an ABI
point.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
