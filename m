Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVLHUrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVLHUrb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVLHUra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:47:30 -0500
Received: from cantor.suse.de ([195.135.220.2]:20649 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932372AbVLHUra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:47:30 -0500
Date: Thu, 8 Dec 2005 21:47:28 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] Re: pcibus_to_node value when no pxm info is present for the pci bus
Message-ID: <20051208204728.GQ11190@wotan.suse.de>
References: <20051207223414.GA4493@localhost.localdomain> <Pine.LNX.4.62.0512081104280.29958@schroedinger.engr.sgi.com> <20051208193439.GB3776@localhost.localdomain> <20051208200440.GB15804@wotan.suse.de> <20051208202138.GD3776@localhost.localdomain> <Pine.LNX.4.62.0512081241180.30546@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512081241180.30546@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 12:41:28PM -0800, Christoph Lameter wrote:
> On Thu, 8 Dec 2005, Ravikiran G Thirumalai wrote:
> 
> > That was my thinking earlier too, but shouldn't we have uniformity in
> > behaviour between kmalloc_node and alloc_pages_node wrt nodeid handling?  
> > IMHO it would be less confusing that way. alloc_pages_node is not that much 
> > of a fastpath routine anyways...
> 
> I agree.

Ok I will submit a patch.

-Andi

