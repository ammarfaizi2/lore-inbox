Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965176AbVINNAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbVINNAc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 09:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbVINNAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 09:00:32 -0400
Received: from magic.adaptec.com ([216.52.22.17]:13988 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965173AbVINNAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 09:00:04 -0400
Message-ID: <43281EC9.5070804@adaptec.com>
Date: Wed, 14 Sep 2005 08:59:53 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Sergey Panov <sipan@sipan.org>, Matthew Wilcox <matthew@wil.cx>,
       Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
References: <1126308949.4799.54.camel@mulgrave>	 <20050910041218.29183.qmail@web51612.mail.yahoo.com>	 <20050911093847.GA5429@infradead.org> <4325FA6F.3060102@adaptec.com>	 <20050913154014.GE32395@parisc-linux.org> <1126677387.26050.71.camel@sipan.sipan.org> <43280123.1020700@pobox.com>
In-Reply-To: <43280123.1020700@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Sep 2005 12:59:59.0608 (UTC) FILETIME=[369FF780:01C5B92C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/05 06:53, Jeff Garzik wrote:
> ...and in this thread, SAS, more than one LLDD -should- be able to make 
> use it of.
> 
> ServerWorks/Broadcom SAS+SATA hardware, for which I will soon be writing 
> a driver, has exactly the same needs as Adaptec SAS+SATA hardware.

Hi Jeff,

Nice of you to finally join us.

I'm sure you've looked at the SAS code.  If SW/Broadcom has the same
open transport architecture, as we do, as you say they do, then you
should have no problem generating 4 events (link up/down, BYTES_DMAED,
BROADCAST(x)) to plug right into the SAS Layer, and have it do port
management, discovery, expander configuration, etc, for you.

Please let me know how it goes.  I'm very curious.
If there's any concerns with the SAS Layer, I'm willing to help
in anywhich way I can.

	Luben

