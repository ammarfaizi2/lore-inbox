Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264954AbUFXNuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUFXNuX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 09:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUFXNuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 09:50:23 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:61496 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264954AbUFXNuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 09:50:18 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: arjanv@redhat.com
Subject: Re: 32-bit dma allocations on 64-bit platforms
Date: Thu, 24 Jun 2004 09:48:07 -0400
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@muc.de>, Terence Ripperda <tripperda@nvidia.com>,
       discuss@x86-64.org, tiwai@suse.de, linux-kernel@vger.kernel.org
References: <2akPm-16l-65@gated-at.bofh.it> <m38yee6j7s.fsf@averell.firstfloor.org> <1088057885.2806.16.camel@laptop.fenrus.com>
In-Reply-To: <1088057885.2806.16.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406240948.07234.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, June 24, 2004 2:18 am, Arjan van de Ven wrote:
> What is the problem again, can't the driver us the dynamic pci mapping
> API which does allow more memory to be mapped even on crippled machines
> without iommu ?
> And isn't this a problem that will vanish since PCI Express and PCI X
> both *require* support for 64 bit addressing, so all higher speed cards
> are going to be ok in principle ?

Well, PCI-X may require it, but there certainly are PCI-X devices that don't 
do 64 bit addressing, or if they do, it's a crippled implementation (e.g. top 
32 bits have to be constant).

Jesse
