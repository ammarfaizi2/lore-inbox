Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWEYEIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWEYEIP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWEYEIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:08:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:43234 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964854AbWEYEIO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:08:14 -0400
Date: Wed, 24 May 2006 23:12:26 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, Jon Mason <jdmason@us.ibm.com>,
       Muli Ben-Yehuda <muli@il.ibm.com>, Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [discuss] [PATCH 3/4] x86-64: Calgary IOMMU - IOMMU abstractions
Message-ID: <20060525041226.GG7720@us.ibm.com>
References: <20060525033631.GE7720@us.ibm.com> <200605250559.51076.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605250559.51076.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 05:59:50AM +0200, Andi Kleen wrote:
> 
>  /* Must execute after PCI subsystem */
> -fs_initcall(pci_iommu_init);
> +fs_initcall(gart_iommu_init);
> 
> This change is wrong too and even throws a warning. gart_iommu_init is already
> called elsewhere.
> 
> -Andi
> 
I don't see that in the patches I sent out (I just double checked), but
that is very wrong.

Thanks,
Jon
