Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbVI3CXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVI3CXD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbVI3CXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:23:02 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:48117 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932378AbVI3CXA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:23:00 -0400
Subject: Re: l2.6.14-rc2-rt7 - build problems - mce?
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0509291907x77604133oc1d8a64e9e70dd59@mail.gmail.com>
References: <5bdc1c8b0509291907x77604133oc1d8a64e9e70dd59@mail.gmail.com>
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 29 Sep 2005 19:22:59 -0700
Message-Id: <1128046979.987.36.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 19:07 -0700, Mark Knecht wrote:
> Hi,
>    Any ideas how I could configure the kernel to get past this
> problem? Currently the config file says this about MCE:
> 
> CONFIG_GART_IOMMU=y
> CONFIG_SWIOTLB=y
> CONFIG_X86_MCE=y
> # CONFIG_X86_MCE_INTEL is not set
> 
> Can I safely set CONFIG_X86_MCE to no or not set? Or is this something
> else completely?

I think it's something else completely .. You would be better off
turning on complete preemption .

Daniel

