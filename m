Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWHDCQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWHDCQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 22:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWHDCQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 22:16:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:40142 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030289AbWHDCQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 22:16:26 -0400
Date: Thu, 3 Aug 2006 19:16:02 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       akpm@osdl.org, xen-devel@lists.xensource.com,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared
 with an SMP hypervisor.
In-Reply-To: <200608040247.59950.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0608031915030.32487@schroedinger.engr.sgi.com>
References: <20060803002510.634721860@xensource.com> <200608030802.44391.ak@suse.de>
 <Pine.LNX.4.64.0608030943110.29745@schroedinger.engr.sgi.com>
 <200608040247.59950.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006, Andi Kleen wrote:

> > An include <asm/xen-bitops.h> would need to fall back to asm-generic if
> > there is no file in asm-arch/xen-bitops.h. I thought we had such a 
> > mechanism?
> AFAIK not. If you want generic you need a proxy include file.

Hmm... Well then we have no way of adding a new asm-arch file 
without adding them to each arch. Makes it difficult to add
new functionality.


