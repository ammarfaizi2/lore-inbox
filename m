Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbVJ0R5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVJ0R5J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 13:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVJ0R5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 13:57:09 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:16877 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751359AbVJ0R5I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 13:57:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fOgixm/mLaQOxZQLbIlBn4GI+nFNFopY+9f6+f+wEiYnxCAsK1wY+siT0GWpMR/U+oLMY2fXT9HLO8VPXxh9E22ifv4913qv3QUXtCgORXVjQrs6EjoI8jVR10foIaaYgvUXxEVEuiq4e1E0B2/Ng9fALxm/9zEPco6ahFGGogw=
Message-ID: <29495f1d0510271057i42084703gc4a8ffc8ce1f5a21@mail.gmail.com>
Date: Thu, 27 Oct 2005 10:57:06 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Michael Madore <michael.madore@gmail.com>
Subject: Re: PCI-DMA: high address but no IOMMU
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d4b6d3ea0510271047t413e9ea8l333a532c1a5f3d77@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d4b6d3ea0510271047t413e9ea8l333a532c1a5f3d77@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/05, Michael Madore <michael.madore@gmail.com> wrote:
> Hi,
>
> I am seeing the following errors in /var/log/messages when booting
> 2.6.14-rc5 on a dual Opteron nforce4 motherboard with 8GB of RAM:
>
> Checking aperture...
> CPU 0: aperture @ be8c000000 size 32 MB
> Aperture from northbridge cpu 0 too small (32 MB)
> No AGP bridge found
> Your BIOS doesn't leave a aperture memory hole
> Please enable the IOMMU option in the BIOS setup
> This costs you 64 MB of RAM
> Mapping aperture over 65536 KB of RAM @ 8000000
>
> ...
>
> PCI-DMA: Disabling AGP.
> PCI-DMA: More than 4GB of RAM and no IOMMU
> PCI-DMA: 32bit PCI IO may malfunction.<6>PCI-DMA: Disabling IOMMU.

I get the same message on my 2-way Opteron machine (ASUS K8N-DL mobo),
but I only have 2 GB of RAM :/ Seems odd the PCI-DMA subsystem thinks
I have more than 4 :) Anybody have any ideas?

Thanks,
Nish
