Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVCQUR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVCQUR1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 15:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVCQUR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 15:17:27 -0500
Received: from everest.2mbit.com ([24.123.221.2]:28817 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261922AbVCQUNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 15:13:21 -0500
Message-ID: <4239E4CC.7050007@lovecn.org>
Date: Fri, 18 Mar 2005 04:13:00 +0800
From: Coywolf Qi Hunt <coywolf@lovecn.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: "Peter W. Morreale" <peter_w_morreale@hotmail.com>,
       linux-kernel@vger.kernel.org
References: <BAY101-F3858D9AE9F3222CAB9AB3CC1490@phx.gbl> <Pine.LNX.4.61.0503171401030.22694@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0503171401030.22694@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Broken-Reverse-DNS: no host name for for IP address 221.201.199.142
X-Scan-Signature: 0c1945f502a06f7766c9348c347b6b03
X-SA-Exim-Connect-IP: 221.201.199.142
X-SA-Exim-Mail-From: coywolf@lovecn.org
Subject: Re: Kernel memory limits?
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  4.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [221.201.199.142 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.2 (built Sun, 13 Feb 2005 18:23:43 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> On Thu, 17 Mar 2005, Peter W. Morreale wrote:
> 
>> (I did not see this addressed in the FAQs...)
>>
>> How much physical memory can the 2.4.26 kernel address in kernel 
>> context on x86?
>>
> 
> All of it.
> 
>> What about DMA memory?
>>
> 
> All of it, too. The old DMA controller(s) could only address 16 MB
> because that's all the page-registers allowed. Bus-mastering DMA
> off the PCI/Bus has no such limitation. Most have DMA controllers
> that use scatter-lists so RAM doesn't even have to be contiguous,
> only properly allocated (in pages) and nailed down with no caching.
> 

Kernel Image itself resides at physical address 1M. Is this kernel image
area a hole to the old DMA range? Thanks.


	Coywolf


