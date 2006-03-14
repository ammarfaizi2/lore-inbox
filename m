Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWCNPHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWCNPHj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWCNPHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:07:39 -0500
Received: from mtaout1.012.net.il ([84.95.2.1]:23193 "EHLO mtaout1.012.net.il")
	by vger.kernel.org with ESMTP id S932147AbWCNPHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:07:36 -0500
Date: Tue, 14 Mar 2006 17:07:05 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [RFC PATCH 1/3] x86-64: Calgary IOMMU - introduce iommu_detected
In-reply-to: <200603141601.20657.ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <MULI@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>, okrieg@us.ibm.com
Message-id: <20060314150705.GJ23631@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060314082432.GE23631@granada.merseine.nu>
 <200603141601.20657.ak@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 04:01:19PM +0100, Andi Kleen wrote:
> On Tuesday 14 March 2006 09:24, Muli Ben-Yehuda wrote:
> > Hi,
> >
> > swiotlb relies on the gart specific iommu_aperture variable to know if
> > we discovered a hardware IOMMU before swiotlb
> > initialization. Introduce iommu_detected to do the same thing, but in
> > a HW IOMMU neutral manner, in preparation for adding the Calgary HW
> > IOMMU.
> 
> I don't have time to review it today and will leave for a short vacation
> so it might take some time.

Thanks for the heads up!

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

