Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVLXPxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVLXPxV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 10:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVLXPxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 10:53:21 -0500
Received: from mail.dvmed.net ([216.237.124.58]:32966 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751244AbVLXPxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 10:53:20 -0500
Message-ID: <43AD6EE9.8080707@pobox.com>
Date: Sat, 24 Dec 2005 10:53:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Sweetman <safemode@comcast.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pci-dma disables iommu on nforce4 motherboards?
References: <43AD674F.1040008@comcast.net>
In-Reply-To: <43AD674F.1040008@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Ed Sweetman wrote: > I have an asus A8N-E motherboard
	and recieve the following message on boot. > PCI-DMA: Disabling IOMMU.
	> > I have no issues with anything not functioning. I guess i'm just >
	curious as to why this is done and if i'm missing out on any sort of >
	performance gain by not using the iommu. I have less than 4GB of ram, >
	would that be why it's disabled (which is why i think it is)? - [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> I have an asus A8N-E motherboard and recieve the following message on boot.
> PCI-DMA: Disabling IOMMU.
> 
> I have no issues with anything not functioning.  I guess i'm just 
> curious as to why this is done and if i'm missing out on any sort of 
> performance gain by not using the iommu.   I have less than 4GB of ram, 
> would that be why it's disabled (which is why i think it is)?  -

What happens if you boot with iommu=force ?

	Jeff



