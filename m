Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWI3LMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWI3LMm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 07:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWI3LMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 07:12:41 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:8914 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750832AbWI3LMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 07:12:41 -0400
Message-ID: <451E511B.3090704@garzik.org>
Date: Sat, 30 Sep 2006 07:12:27 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Muli Ben-Yehuda <muli@il.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Jim Paradis <jparadis@redhat.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, jdmason@kudzu.us
Subject: Re: [PATCH] x86[-64] PCI domain support
References: <20060926191508.GA6350@havoc.gtf.org> <20060928093332.GG22787@rhun.haifa.ibm.com> <451B99C5.7080809@garzik.org> <20060928224550.GJ22787@rhun.haifa.ibm.com> <451C54C0.6080402@garzik.org> <20060928233116.GK22787@rhun.haifa.ibm.com> <20060930093421.GP22787@rhun.haifa.ibm.com> <451E40DF.30406@garzik.org> <20060930104248.GR22787@rhun.haifa.ibm.com>
In-Reply-To: <20060930104248.GR22787@rhun.haifa.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> So pci_domain_nr and pci_proc_domain are only available if
> CONFIG_PCI_DOMAINS is defined. I followed suit and make pci_iommu only
> available if CONFIG_CALGARY_IOMMU is defined, but perhaps it would be
> better to make it unconditional, since ->sysdata will always be
> available anyway. Was there a specific reason why pci_domain_nr is
> only available if CONFIG_PCI_DOMAINS?

Generic stubs already exist in include/linux/pci.h.

	Jeff


