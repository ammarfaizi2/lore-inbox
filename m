Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVHSBTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVHSBTJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 21:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVHSBTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 21:19:09 -0400
Received: from NS4.Sony.CO.JP ([137.153.0.44]:55464 "EHLO ns4.sony.co.jp")
	by vger.kernel.org with ESMTP id S964786AbVHSBTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 21:19:08 -0400
Message-ID: <43046867.4030707@sm.sony.co.jp>
Date: Thu, 18 Aug 2005 19:52:23 +0900
From: Hiroyuki Machida <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Posix file attribute support on VFAT (take #2)
References: <43023957.1020909@sm.sony.co.jp> <20050816212531.GA2479@infradead.org>
In-Reply-To: <20050816212531.GA2479@infradead.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to explain background....

Christoph Hellwig wrote:
> On Wed, Aug 17, 2005 at 04:07:03AM +0900, Machida, Hiroyuki wrote:
> 
>>This is a take 2 of posix file attribute support on VFAT.
> 
> 
> Sorry, but this is far too scary.  Please just use one of the sane
> filesystems linux supports.
> 

I would say that purpose of the feature is having ability to
build root fs for small embedded device, not support full posix 
attributes top of VFAT. I think the situation is like uclinux, 
which has no MMU support and many restriction, however it's still
very helpful for small embedded device.

To reduce resource consumption, developers for embedded system
would like to select one file system type to be used, if possible. 
And in most case, FAT is required for data exchange.
	E.g. memory/storage card or USB client. 

So adding small feature to FAT could have ability to build root fs, 
it's very helpful. It's not required to support full attributes.

What do you think ?

Thanks,
Hiroyuki Machida


