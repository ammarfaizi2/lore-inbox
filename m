Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751723AbWCCWXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbWCCWXr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 17:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbWCCWXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 17:23:47 -0500
Received: from mail.dvmed.net ([216.237.124.58]:32662 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751723AbWCCWXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 17:23:46 -0500
Message-ID: <4408C1E1.7090006@pobox.com>
Date: Fri, 03 Mar 2006 17:23:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Allen Martin <AMartin@nvidia.com>, Chris Wedgwood <cw@f00f.org>,
       Michael Monnerie <m.monnerie@zmi.at>, linux-kernel@vger.kernel.org,
       suse-linux-e@suse.com
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
References: <DBFABB80F7FD3143A911F9E6CFD477B00E48CCB0@hqemmail02.nvidia.com> <200603032312.13369.ak@suse.de>
In-Reply-To: <200603032312.13369.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Friday 03 March 2006 22:27, Allen Martin wrote:
> 
> 
>>nForce4 has 64 bit (40 bit AMD64) DMA in the SATA controller.  We gave
>>the docs to Jeff Garzik under NDA.  He posted some non functional driver
>>code to linux-ide earlier this week that has the 64 bit registers and
>>structures although it doesn't make use of them.  Someone could pick
>>this up if they wanted to work on it though.
> 
> 
> Thanks for the correction. Sounds nice - hopefully we'll get a driver soon.
> I guess it's in good hands with Jeff for now.

I'll happen but not soon.  Motivation is low at NV and here as well, 
since newer NV is AHCI.  The code in question, "NV ADMA", is essentially 
legacy at this point -- though I certainly acknowledge the large current 
installed base.  Just being honest about the current state of things...

	Jeff



