Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVLHU0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVLHU0L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVLHU0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:26:11 -0500
Received: from cantor2.suse.de ([195.135.220.15]:11222 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932341AbVLHU0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:26:10 -0500
Date: Thu, 8 Dec 2005 21:26:08 +0100
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@engr.sgi.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] Re: pcibus_to_node value when no pxm info is present for the pci bus
Message-ID: <20051208202608.GP11190@wotan.suse.de>
References: <20051207223414.GA4493@localhost.localdomain> <Pine.LNX.4.62.0512081104280.29958@schroedinger.engr.sgi.com> <20051208193439.GB3776@localhost.localdomain> <20051208200440.GB15804@wotan.suse.de> <20051208202138.GD3776@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208202138.GD3776@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That was my thinking earlier too, but shouldn't we have uniformity in
> behaviour between kmalloc_node and alloc_pages_node wrt nodeid handling?  
> IMHO it would be less confusing that way. alloc_pages_node is not that much 
> of a fastpath routine anyways...

No strong opinion either way.

-Andi
