Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751829AbWJADm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbWJADm1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 23:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbWJADm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 23:42:27 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:43243 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751829AbWJADm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 23:42:26 -0400
Message-ID: <451F38FB.8080902@garzik.org>
Date: Sat, 30 Sep 2006 23:41:47 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Muli Ben-Yehuda <muli@il.ibm.com>, Andrew Morton <akpm@osdl.org>
CC: Greg KH <greg@kroah.com>, Jim Paradis <jparadis@redhat.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       jdmason@kudzu.us
Subject: Re: [PATCH] x86-64: Calgary IOMMU: update to work with PCI domains
References: <20060926191508.GA6350@havoc.gtf.org> <20060928093332.GG22787@rhun.haifa.ibm.com> <451B99C5.7080809@garzik.org> <20060928224550.GJ22787@rhun.haifa.ibm.com> <451C54C0.6080402@garzik.org> <20060928233116.GK22787@rhun.haifa.ibm.com> <20060930093421.GP22787@rhun.haifa.ibm.com> <451E40DF.30406@garzik.org> <20060930104248.GR22787@rhun.haifa.ibm.com> <451E57FE.5000600@garzik.org> <20060930175148.GS22787@rhun.haifa.ibm.com>
In-Reply-To: <20060930175148.GS22787@rhun.haifa.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> On Sat, Sep 30, 2006 at 07:41:50AM -0400, Jeff Garzik wrote:
> 
>> Muli Ben-Yehuda wrote:
>>> The patch I posted earlier is all that's needed, if you could merge it
>>> into #pciseg that would be fine. I'm pondering making one small
>>> change though: in your pci domains patch, you have this snippet:
>> Would you be kind enough to resend the patch with a proper Signed-off-by 
>> line?  (and subject/description, etc. while you're at it)
> 
> This patch updates Calgary to work with Jeff's PCI domains code by
> moving each bus's pointer to its struct iommu_table to struct
> pci_sysdata, rather than stashing it in ->sysdata directly.
> 
> Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
> Signed-off-by: Jon Mason <jdmason@kudzu.us>

applied, and pushed out to jgarzik/misc-2.6.git#pciseg.

thanks,

	Jeff



