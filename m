Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVI2Q4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVI2Q4y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbVI2Q4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:56:54 -0400
Received: from mail.dvmed.net ([216.237.124.58]:45036 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932240AbVI2Q4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:56:52 -0400
Message-ID: <433C1CD0.9080906@pobox.com>
Date: Thu, 29 Sep 2005 12:56:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: Bernd Petrovitsch <bernd@firmix.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Luben Tuikov <ltuikov@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509281227570.19896-100000@master.linux-ide.org>	 <433B0374.4090100@adaptec.com> <20050928223542.GA12559@alpha.home.local>	 <433BFB1F.2020808@adaptec.com> <1128007032.11443.77.camel@tara.firmix.at> <433C174D.4050302@adaptec.com>
In-Reply-To: <433C174D.4050302@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> On 09/29/05 11:17, Bernd Petrovitsch wrote:
> 
>>Then submit your driver as a (separate) block device in parallel to the
>>existing SCSI subsystem. People will use it for/with other parts if it
> 
> 
> SAS is ultimately SCSI.  I'll just have to write my own SCSI core.
> _We_ together can do this in parallel to the old SCSI Core.

You should have stated this plainly, from the start.

If you want to do your own SCSI layer, you need to do it at the block 
layer rather than poking around drivers/scsi/

	Jeff



