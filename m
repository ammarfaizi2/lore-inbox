Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWFSUgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWFSUgH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWFSUgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:36:07 -0400
Received: from cantor2.suse.de ([195.135.220.15]:45747 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751116AbWFSUgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:36:05 -0400
From: Andi Kleen <ak@suse.de>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: The "Out of IOMMU space" error and the "Please enable the IOMMU option" option
Date: Mon, 19 Jun 2006 22:35:52 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <a0623094bc0b77aaeba9a@[129.98.90.227]> <200606161031.16554.ak@suse.de> <a0623095ec0b8e87b768d@[129.98.90.227]>
In-Reply-To: <a0623095ec0b8e87b768d@[129.98.90.227]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606192235.52759.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 June 2006 22:09, Maurice Volaski wrote:
> With 2.6.16.20 and iommu=memaper=4,
>
> Jun 19 15:20:31 [kernel] [  103.697664] PCI-DMA: Disabling AGP.
> Jun 19 15:20:31 [kernel] [  103.698226] PCI-DMA: using GART IOMMU.
> Jun 19 15:20:31 [kernel] [  103.698341] PCI-DMA: Reserving 512MB of
> IOMMU area in the AGP aperture
>
> I'm not sure why it tells me it's disabling AGP, but otherwise it looks
> good.

It does that when it can't find an AGP bridge (= no AGP slot). Many
modern systems only have PCI Express.

-andi
