Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVCRJDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVCRJDX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 04:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVCRJDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 04:03:23 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:44438 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261517AbVCRJCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 04:02:36 -0500
In-Reply-To: <16954.7656.838769.483631@cargo.ozlabs.ibm.com>
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk> <16952.41973.751326.592933@cargo.ozlabs.ibm.com> <200503161406.01788.jbarnes@engr.sgi.com> <29ab1884ee5724e9efcfe43f14d13376@cl.cam.ac.uk> <16953.20279.77584.501222@cargo.ozlabs.ibm.com> <1111067594.1213.27.camel@localhost.localdomain> <16954.7656.838769.483631@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <03425ef53cbc0ed3d82b5a127f892180@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org, Ian.Pratt@cl.cam.ac.uk,
       riel@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, kurt@garloff.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christian.Limpach@cl.cam.ac.uk
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
Date: Fri, 18 Mar 2005 09:05:06 +0000
To: Paul Mackerras <paulus@samba.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Mar 2005, at 00:16, Paul Mackerras wrote:

> That sounds like a good way to make AGP accesses slower. :)
>
> Seriously, given that AGP is a technology that is being superseded by
> PCI Express, I think it's reasonable to look at the range of current
> implementations to see what we have to cope with.  So I don't think
> it's worth worrying too much about the possibility of GARTs that go
> through the IOMMU.  However, the idea of having phys_to_agp/agp_to_phys
> (or virt_to_agp/agp_to_virt) sounds like it wouldn't be too much
> effort, if it would help Xen.

I'll post a patch for this next week. Thanks for your patience so far!

  -- Keir

