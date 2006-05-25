Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbWEYJIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbWEYJIA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 05:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWEYJH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 05:07:59 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:59327 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S965091AbWEYJH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 05:07:59 -0400
Message-ID: <447573E0.6000108@myri.com>
Date: Thu, 25 May 2006 11:07:44 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Anton Blanchard <anton@samba.org>, netdev@vger.kernel.org,
       gallatin@myri.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] myri10ge - Driver core
References: <20060517220218.GA13411@myri.com>	 <20060517220608.GD13411@myri.com> <20060523153928.GB5938@krispykreme>	 <4474138C.2050705@myri.com> <1148543942.13249.268.camel@localhost.localdomain>
In-Reply-To: <1148543942.13249.268.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Wed, 2006-05-24 at 10:04 +0200, Brice Goglin wrote:
>
>   
>> I am not sure what you mean.
>> The only ppc64 with PCI-E that we have seen so far (a G5) couldn't do
>> write combining according to Apple.
>>     
>
> That is not 100% true.... I don't know what apple had in mind. It also
> depends in what slot you are.
>
> Do you have ways to measure the difference ?
>   

No, we don't have any PPC with PCIe running Linux. The only G5 PCIe that
we have is running MacOSX.

> Try doing __ioremap(mgp->iomem_base, mgp->board_span, _PAGE_NO_CACHE);
> instead of using the normal ioremap for #ifdef powerpc and tell us if it
> makes a difference.
>   

I'll try it as soon as we get our G5 PCIe to run Linux.

thanks,
Brice

