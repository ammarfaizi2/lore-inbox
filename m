Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWCNPBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWCNPBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWCNPBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:01:40 -0500
Received: from ns2.suse.de ([195.135.220.15]:27079 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751092AbWCNPBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:01:39 -0500
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [RFC PATCH 1/3] x86-64: Calgary IOMMU - introduce iommu_detected
Date: Tue, 14 Mar 2006 16:01:19 +0100
User-Agent: KMail/1.8
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <MULI@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
References: <20060314082432.GE23631@granada.merseine.nu>
In-Reply-To: <20060314082432.GE23631@granada.merseine.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141601.20657.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 09:24, Muli Ben-Yehuda wrote:
> Hi,
>
> swiotlb relies on the gart specific iommu_aperture variable to know if
> we discovered a hardware IOMMU before swiotlb
> initialization. Introduce iommu_detected to do the same thing, but in
> a HW IOMMU neutral manner, in preparation for adding the Calgary HW
> IOMMU.

I don't have time to review it today and will leave for a short vacation
so it might take some time.

-Andi
