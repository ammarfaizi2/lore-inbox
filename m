Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWHOXTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWHOXTI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 19:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWHOXTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 19:19:08 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:31369 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750808AbWHOXTG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 19:19:06 -0400
Message-ID: <44E25665.1000702@us.ibm.com>
Date: Tue, 15 Aug 2006 16:19:01 -0700
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Randy Dunlap <rdunlap@xenotime.net>
CC: Pavel Machek <pavel@suse.cz>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
References: <1155677232.11401@shark.he.net>
In-Reply-To: <1155677232.11401@shark.he.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> 
>>Hi!
>>
>>
>>>> AM> - The existing comments could benefit from some rework by a
>>>> AM> native English speaker.
>>>>
>>>>could someone assist here, please?
>>>
>>>See if this helps.
>>>Patch applies on top of all ext4 patches from
>>>http://ext2.sourceforge.net/48bitext3/patches/latest/.
>>
>>>--- linux-2618-rc4-ext4.orig/include/linux/ext4_fs_extents.h
>>>+++ linux-2618-rc4-ext4/include/linux/ext4_fs_extents.h
>>>@@ -22,29 +22,29 @@
>>> #include <linux/ext4_fs.h>
>>> 
>>> /*
>>>- * with AGRESSIVE_TEST defined capacity of index/leaf blocks
>>>- * become very little, so index split, in-depth growing and
>>>- * other hard changes happens much more often
>>>- * this is for debug purposes only
>>>+ * With AGRESSIVE_TEST defined, the capacity of index/leaf blocks
>>>+ * becomes very small, so index split, in-depth growing and
>>>+ * other hard changes happen much more often.
>>>+ * This is for debug purposes only.
>>>  */
>>> #define AGRESSIVE_TEST_
>>
>>Using _ for disabling is unusual/nasty. Can't we simply #undef it?
> 
> 
> Yes, that's the right thing to do.
> The ext4dev people should do that. :)
> 

Okey, I will fixed that. thanks.
> ---
> ~Randy

