Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbWJSNEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWJSNEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWJSNEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:04:46 -0400
Received: from cantor.suse.de ([195.135.220.2]:24041 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751572AbWJSNEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:04:45 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PCI-DMA: Disabling IOMMU
Date: Thu, 19 Oct 2006 15:04:37 +0200
User-Agent: KMail/1.9.3
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Sebastian Biallas <sb@biallas.net>,
       linux-kernel@vger.kernel.org
References: <45364248.2020901@biallas.net> <200610182348.44968.ak@suse.de> <1161259688.17335.32.camel@localhost.localdomain>
In-Reply-To: <1161259688.17335.32.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191504.37384.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Actually if you flip it around and print
> "PCI-DMA: Enabling IOMMU"
> 
> and keep quiet if you disable it then users should be happy because its
> turned something on and that is clearly always good 8)

There already is a Using GART IOMMU message afterwards. The reason the
disabling message is there that one can distingush the case of IOMMU
working, but deciding that it's not needed and IOMMU not compiled
in (which unfortunately a few users do even when they need it) 

Ok admittedly there is another warning when iommu is disabled, but
would be needed anyways so maybe it's obsolete. But I think it's better
to keep it for now.

-Andi
