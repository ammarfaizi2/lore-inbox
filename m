Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932725AbVINK4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbVINK4B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 06:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932724AbVINK4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 06:56:01 -0400
Received: from mail.dvmed.net ([216.237.124.58]:50604 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932717AbVINK4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 06:56:00 -0400
Message-ID: <43280123.1020700@pobox.com>
Date: Wed, 14 Sep 2005 06:53:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergey Panov <sipan@sipan.org>
CC: Matthew Wilcox <matthew@wil.cx>, Luben Tuikov <luben_tuikov@adaptec.com>,
       Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
References: <1126308949.4799.54.camel@mulgrave>	 <20050910041218.29183.qmail@web51612.mail.yahoo.com>	 <20050911093847.GA5429@infradead.org> <4325FA6F.3060102@adaptec.com>	 <20050913154014.GE32395@parisc-linux.org> <1126677387.26050.71.camel@sipan.sipan.org>
In-Reply-To: <1126677387.26050.71.camel@sipan.sipan.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Panov wrote:
> On Tue, 2005-09-13 at 09:40 -0600, Matthew Wilcox wrote:

>>As you know, stuff is being rearranged to move more of the SPI-specific
>>code from both SCSI core and LLDDs into the SPI transport.  I suspect
>>domain discovery will always be triggered by the LLDD for SPI, but at
>>least a driver doesn't have to have its own code to do that any more.

> Only if it can be turned into a some sort of library LLDD may use if it
> needs it. But it is only makes sense to move that code out of the LLDD
> and into the transport module, if more then one LLDD can make use of it.


...and in this thread, SAS, more than one LLDD -should- be able to make 
use it of.

ServerWorks/Broadcom SAS+SATA hardware, for which I will soon be writing 
a driver, has exactly the same needs as Adaptec SAS+SATA hardware.

	Jeff


