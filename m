Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270035AbUJHPnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270035AbUJHPnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270033AbUJHPnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:43:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42201 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270035AbUJHPio
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:38:44 -0400
Message-ID: <4166B475.3080707@pobox.com>
Date: Fri, 08 Oct 2004 11:38:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@infradead.org>, Mark Lord <lsml@rtr.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca>	<416547B6.5080505@rtr.ca>	<20041007150709.B12688@infradead.org>	<4165624C.5060405@rtr.ca>	<416565DB.4050006@pobox.com>	<4165A45D.2090200@rtr.ca>	<4165A766.1040104@pobox.com>	<4165A85D.7080704@rtr.ca>	<4165AB1B.8000204@pobox.com>	<4165ACF8.8060208@rtr.ca> 	<20041007221537.A17712@infradead.org>	<1097241583.2412.15.camel@mulgrave>  <4166AF2F.6070904@rtr.ca> <1097249266.1678.40.camel@mulgrave> <4166B37D.8030701@rtr.ca>
In-Reply-To: <4166B37D.8030701@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> And the driver will need it's own copy in some versions anyway,
> since this driver will be used on much older/earlier kernels
> than just the ones with the latest libata stuff.


Typically that's done with an out-of-tree compatibility module, such as 
something like kcompat (http://sf.net/projects/gkernel/), which provides 
a modern driver API to older kernels.

	Jeff


