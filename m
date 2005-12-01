Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVLAR5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVLAR5v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVLAR5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:57:51 -0500
Received: from ns.suse.de ([195.135.220.2]:22673 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932383AbVLAR5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:57:49 -0500
Date: Thu, 1 Dec 2005 18:57:42 +0100
From: Andi Kleen <ak@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: "Dugger, Donald D" <donald.d.dugger@intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, "Shah, Rajesh" <rajesh.shah@intel.com>,
       akpm@osdl.org
Subject: Re: [PATCH] Add VT flag to cpuinfo
Message-ID: <20051201175742.GN19515@wotan.suse.de>
References: <7F740D512C7C1046AB53446D3720017306158A1B@scsmsx402.amr.corp.intel.com> <20051201165205.GB12616@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201165205.GB12616@krispykreme>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 03:52:05AM +1100, Anton Blanchard wrote:
> 
> > Well, I really don't see a conflict here, TLA's for x86
> > architectures are orthogonal to PowerPC and vice versa
> > so this shouldn't cause any confusion.
> 
> Do you read all of the linux-kernel mailing list? :) Its caused me to
> have to look twice on a number of occasions. 
> 
> I know it isnt going to be fixed but I do wonder if intel knows how to
> use google before creating yet another TLA :)

It would be probably hopeless at least in the 2-6 letter TLA space. 
Every possible TLA has been already used for countless other things.
Just live with the collisions. Or use names instead of them.

cpuinfo flags are deeply architecture specific anyways, so I don't
think it makes much sense to try to get them unique over architectures.
In fact I think ppc doesn't even have a "flags" line. 

-Andi

