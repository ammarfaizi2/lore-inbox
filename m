Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbUB0Mv3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 07:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbUB0Mv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 07:51:29 -0500
Received: from ns.suse.de ([195.135.220.2]:9092 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262844AbUB0MvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 07:51:23 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64 iommu rewrite part 4/5
References: <1077884018.22925.371.camel@gaston.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Feb 2004 13:51:21 +0100
In-Reply-To: <1077884018.22925.371.camel@gaston.suse.lists.linux.kernel>
Message-ID: <p73oerk4ree.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> +#if !defined(CONFIG_PCI) || PCI_DMA_BUS_IS_PHYS

Can you make that a run time test? On x86-64 PCI_DMA_BUS_IS_PHYS is 
defined to a variable.

Thanks,
-Andi
