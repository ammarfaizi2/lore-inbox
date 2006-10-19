Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423313AbWJSLwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423313AbWJSLwL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 07:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423317AbWJSLwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 07:52:11 -0400
Received: from cantor2.suse.de ([195.135.220.15]:46722 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423313AbWJSLwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 07:52:10 -0400
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: PCI-DMA: Disabling IOMMU
Date: Thu, 19 Oct 2006 13:52:34 +0200
User-Agent: KMail/1.9.1
Cc: Sebastian Biallas <sb@biallas.net>, linux-kernel@vger.kernel.org
References: <45364248.2020901@biallas.net> <200610182348.44968.ak@suse.de> <20061019051528.GE4582@rhun.haifa.ibm.com>
In-Reply-To: <20061019051528.GE4582@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191352.35177.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The original message is misleading - there may certainly be more than
> one IOMMU and then we will end up "disabling IOMMU" and then
> "reenabling IOMMU" later when we detect another one. Can we at least
> make it "disabling GART IOMMU"?

Ok, although the printk is already guarded by a test for another IOMMU

-Andi
