Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVK2XHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVK2XHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVK2XHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:07:24 -0500
Received: from ozlabs.org ([203.10.76.45]:2794 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964803AbVK2XHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:07:23 -0500
Date: Wed, 30 Nov 2005 10:07:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andi Kleen <ak@suse.de>
Cc: Nicholas Miell <nmiell@comcast.net>, Stephane Eranian <eranian@hpl.hp.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051129230704.GA9659@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andi Kleen <ak@suse.de>, Nicholas Miell <nmiell@comcast.net>,
	Stephane Eranian <eranian@hpl.hp.com>,
	Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
	linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
References: <20051129151515.GG19515@wotan.suse.de> <200511291056.32455.raybry@mpdtxmail.amd.com> <20051129180903.GB6611@frankl.hpl.hp.com> <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy> <20051129215207.GR19515@wotan.suse.de> <1133303615.3271.12.camel@entropy> <20051129224346.GS19515@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129224346.GS19515@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 11:43:47PM +0100, Andi Kleen wrote:
> > Well, RDPMC isn't defined at all. You're assuming that future processor
> > revisions will have the same or substantially similar PerfCtrs as
> > current processors, and nothing guarantees that at all.
> 
> Point, but i guess it is reasonable to assume that future x85 CPUs
> will have cycle counter perfctrs.  I cannot imagine anybody dropping
> such a basic facility.

It need not necessarily remain configurable to be in PMC 0 however.
Nor do the the PMC MSRs have to remain fixed..

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
