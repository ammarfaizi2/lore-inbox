Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265268AbTL2TFA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbTL2TFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:05:00 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:35361 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S265268AbTL2TE5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:04:57 -0500
Message-ID: <3FF07AD8.2040601@rackable.com>
Date: Mon, 29 Dec 2003 11:04:56 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Johannes Ruscheinski <ruschein@mail-infomine.ucr.edu>
CC: Tomas Szepe <szepe@pinerecords.com>, linux-kernel@vger.kernel.org
Subject: Re: Best Low-cost IDE RAID Solution For 2.6.x? (OT?)
References: <20031228180424.GA16622@mail-infomine.ucr.edu> <3FEF8CFD.7060502@rackable.com> <20031229134150.GB30794@louise.pinerecords.com> <20031229185908.GB31215@mail-infomine.ucr.edu>
In-Reply-To: <20031229185908.GB31215@mail-infomine.ucr.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Dec 2003 19:04:56.0692 (UTC) FILETIME=[A6201340:01C3CE3E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Ruscheinski wrote:
> Also sprach Tomas Szepe:
> 
>>On Dec-28 2003, Sun, 18:10 -0800
>>Samuel Flory <sflory@rackable.com> wrote:
>>
>>
>>>PS- Why not at least run software raid 5?  It takes far less cpu than 
>>>you'd think, and can save your ass.
>>
>>Absolutely.  With eight low-cost IDE disks, you'd be nuts to go raid0
>>or linear.
>>
> 
> 
> I'll probably go with raid5 and the Promise tx4000 card recommended by Joel.
> It looks like I'll have the funding to buy another box and another 1 TiB of
> disk space.  Thanks for all the advice!!
> 
> 

   A word of advice when using software raid.  Be sure to run badblocks 
on all the disks before creating your array.  Software raid isn't as 
nice about bad sectors as most hardware raid controllers.  On the other 
hand the md driver kicks the ass of nearly every raid controller I've tried.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

