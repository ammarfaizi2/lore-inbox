Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbTH2SQC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbTH2SQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:16:02 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:50837 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S261657AbTH2SP5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:15:57 -0400
Message-ID: <3F4F96DE.7030603@rackable.com>
Date: Fri, 29 Aug 2003 11:09:34 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: libata update posted (was Re: VIA Serial ATA chipset)
References: <20030813074535.C3AB427AC8@mail.medav.de> <3F4F6863.4080400@pobox.com> <3F4F8BA7.1080002@rackable.com> <3F4F949B.6030900@pobox.com>
In-Reply-To: <3F4F949B.6030900@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Aug 2003 18:15:56.0731 (UTC) FILETIME=[976020B0:01C36E59]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Samuel Flory wrote:
>
>> Jeff Garzik wrote:
>>
>>> Changes:
>>> * continue work towards fully async taskfile API:  you call 
>>> submit_tf(), and later on, your callback is called when the taskfile 
>>> completes or times out.   async taskfile API is required for ATAPI 
>>> and supporting more advanced host controllers like Promise or AHCI 
>>> (SATA2).
>>> * some cleanups
>>
>
>>   I'm guessing there is no support for Promise yet?
>
>
> Not yet.  Once I finish the item mentioned above, "async taskfile 
> API", Promise support will appear quite rapidly.
>
>
>> PS-  The driver works great on the silcon image chipset.  (Once I 
>> realized that my Seagate drive needed newer firmware.)
>
>
> Um... libata doesn't support Silicon Image yet?
>


  The Intel PIIX/ICH support in the ac kernel seems to work on all my 
onboard  Silicon Image controllers.  I think that's only your ata-scsi 
work, however.

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


