Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161192AbWHJMAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161192AbWHJMAt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWHJMAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:00:49 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:2525 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161192AbWHJMAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:00:48 -0400
Message-ID: <44DB1FEC.8090101@garzik.org>
Date: Thu, 10 Aug 2006 08:00:44 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SATA] max-sect and sii-m15w branches merged
References: <44DB106C.6090504@garzik.org> <44DB17C4.2070908@gmail.com>
In-Reply-To: <44DB17C4.2070908@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> I just merged the max-sect and sii-m15w branches into the upstream 
>> branch.
>>
>> This means that the following two changes are queued for 2.6.19:
>>
>> * increase max sectors from 200 to 256 (for lba28)
>> * better mod15write support for sata_sil
> 
> Are we ready for m15w-iterate-over-large-write patch?  It has been used 
> by many people for quite some time and works great.  If you think we can 
> merge that patch, I'll port it over #upstream.

I would prefer that be considered after 2.6.19, since sii-m15w will be 
first appear in 2.6.19.

Feel free to send it along, if you wish.  I'll keep it in a separate 
branch, and make sure it appears in #ALL (and thus Andrew's -mm tree).

	Jeff



