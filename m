Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWCUQky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWCUQky (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWCUQkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:40:53 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:11409 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750818AbWCUQkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:40:51 -0500
Message-ID: <44202C91.30601@garzik.org>
Date: Tue, 21 Mar 2006 11:40:49 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] libata updates
References: <20060320111658.GA16172@havoc.gtf.org>	 <1142872556.21455.7.camel@localhost.localdomain>	 <441F52F7.8030309@garzik.org> <1142936420.21455.26.camel@localhost.localdomain>
In-Reply-To: <1142936420.21455.26.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.4 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.4 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2006-03-20 at 20:12 -0500, Jeff Garzik wrote:
> 
>>In my [no doubt warped] brain, I equate the SFF-8038 interface to "PCI 
>>IDE BMDMA", and from there, view most hardware as a subset of PCI IDE 
>>BMDMA.  It might not do DMA, might not be PCI, might not do irqs, but 
>>most PATA hardware seems able to be driven by a "bmdma driver".  Thus, 
>>the name :)
> 
> 
> Most of that file is ST-506 type register interfaces, only a tiny bit is
> SFF PCI IDE with DMA.
> 
> Expect some patches soon. I've got my tree merged against the git tree
> now, just needs some testing.

To be specific, are the patches against libata-dev.git 'upstream' branch?

(most should apply to Linus-vanilla branch, so regardless of the 
definition of "the git tree" it should be OK)

	Jeff



