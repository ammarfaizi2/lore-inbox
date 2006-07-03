Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWGCGxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWGCGxH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 02:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWGCGxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 02:53:07 -0400
Received: from tornado.reub.net ([202.89.145.182]:16602 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750850AbWGCGxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 02:53:06 -0400
Message-ID: <44A8BEB2.5020803@reub.net>
Date: Mon, 03 Jul 2006 18:52:34 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060702)
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Grant Wilson <grant.wilson@zen.co.uk>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Neil Brown <neilb@suse.de>
Subject: Re: 2.6.17-mm5 dislikes raid-1, just like mm4
References: <20060701033524.3c478698.akpm@osdl.org> <20060701181455.GA16412@aitel.hist.no> <20060701152258.bea091a6.akpm@osdl.org> <44A7560B.3050000@reub.net> <1151848394.3558.2.camel@mulgrave.il.steeleye.com> <44A7D82A.80909@zen.co.uk> <1151852788.3558.10.camel@mulgrave.il.steeleye.com> <44A7E992.4010201@zen.co.uk> <20060702190719.GA815@aitel.hist.no>
In-Reply-To: <20060702190719.GA815@aitel.hist.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/07/2006 7:07 a.m., Helge Hafting wrote:
> On Sun, Jul 02, 2006 at 04:43:14PM +0100, Grant Wilson wrote:
>> James Bottomley wrote:
>>> On Sun, 2006-07-02 at 15:28 +0100, Grant Wilson wrote:
>>>> With the patch applied to 2.6.17-mm5 my RAID-1 is up and running on both
>>>> SATA drives with no problems.
>>> That's great, thanks.  Now we know what the problem patch is, I'd like
>>> to try an 11th our correction of the logic fault in the original.  Could
>>> you try this patch against original -mm (by reversing the previous
>>> patch).  I think it should correct the problem?
>>>
>>> Thanks,
>>>
>>> James
>>>
>> [snip]
>>
>> With the first patch reversed and the second applied to -mm5 my RAID-1
>> array is still working correctly on both disks.
>>
> The patch makes 2.6.17-mm5 md work on SATA and SCSI for me too.
> 
> Helge Hafting

+1.  Fixes everything here up too.

So with two patches applied (this one and an unrelated MSI fix) I'm all up and 
running perfectly on -mm5.

Thanks,
Reuben
