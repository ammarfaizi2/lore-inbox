Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUJLRrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUJLRrp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUJLRgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:36:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64670 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266357AbUJLRbS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:31:18 -0400
Message-ID: <416C14D9.9020408@pobox.com>
Date: Tue, 12 Oct 2004 13:31:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Mark Lord <lkml@rtr.ca>, Christoph Hellwig <hch@infradead.org>,
       Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4165A85D.7080704@rtr.ca> <4165AB1B.8000204@pobox.com>	<4165ACF8.8060208@rtr.ca> <20041007221537.A17712@infradead.org>	<1097241583.2412.15.camel@mulgrave> <4166AF2F.6070904@rtr.ca>	<1097249266.1678.40.camel@mulgrave> <4166B37D.8030701@rtr.ca>	<1097251299.1928.56.camel@mulgrave> <416C0DC5.2080206@rtr.ca> 	<20041012170526.GB9274@havoc.gtf.org> <1097601002.1763.84.camel@mulgrave>
In-Reply-To: <1097601002.1763.84.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Tue, 2004-10-12 at 12:05, Jeff Garzik wrote:
> 
>>I'll respectfully disagree with James...  I think the most prudent
>>course of action is to follow the example of SCSI common code.
>>
>>If the SCSI core is doing something wrong, we should fix that _first_,
>>not set a precedent of confusing dissociation.
>>
>>Everyone knows that Linux programmers engineer with their cut-n-paste
>>feature.
> 
> 
> So you'll be sending me the patches that do this?

I'm just saying you are encouraging inconsistency, which is wrong.

Mark should either
a) follow the style you request, _and_ submit patches to clean up the 
SCSI core, or

b) take the lock, just like the SCSI core is doing.

I disagree with the assertion that Mark's code should be different from 
the SCSI core.

	Jeff



