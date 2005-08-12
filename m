Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVHLVdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVHLVdW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 17:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVHLVdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 17:33:21 -0400
Received: from mail.dvmed.net ([216.237.124.58]:16301 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751285AbVHLVdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 17:33:20 -0400
Message-ID: <42FD159D.7080107@pobox.com>
Date: Fri, 12 Aug 2005 17:33:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: monz@danbbs.dk
CC: Linux IDE Mailing List <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: SATA status report updated
References: <42FC2EF8.7030404@pobox.com> <42FCF5D3.1080409@danbbs.dk>
In-Reply-To: <42FCF5D3.1080409@danbbs.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mogens Valentin wrote:
> Jeff Garzik wrote:
> 
>>
>> Things in SATA-land have been moving along recently, so I updated the 
>> software status report:
>>
>>     http://linux.yyz.us/sata/software-status.html
> 
> 
>  >> Queueing support, NCQ:
>  >> #3 will be supported by libata, for all hardware and devices that
>  >> support NCQ.
> 
> I guess this means libata support for HW-based NCQ.
> It also could mean software/driver implemented NCQ, which could work on 
> chipsets not supporting HW-NCQ in unison with a disk having NCQ?

NCQ by definition -requires- support in the controller chip.


>> Although I have not updated it in several weeks, folks may wish to 
>> refer to the hardware status report as well:
>>
>>     http://linux.yyz.us/sata/sata-status.html
> 
> 
> How well does libata work with the newest ULi chipsets?
> If not well, is there a possible timeframe?

No idea.  I don't see many bug reports, so I suppose its OK.

	Jeff


