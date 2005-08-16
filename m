Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbVHPFDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbVHPFDp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 01:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbVHPFDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 01:03:45 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:60932 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965103AbVHPFDo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 01:03:44 -0400
Message-ID: <430173AD.20109@vmware.com>
Date: Mon, 15 Aug 2005 22:03:41 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: akpm@osdl.org, chrisl@vmware.com, jdike@addtoit.com,
       linux-kernel@vger.kernel.org, pratap@vmware.com,
       virtualization@lists.osdl.org
Subject: Re: [PATCH 1/6] i386 virtualization - Fix uml build
References: <200508152258.j7FMwdAb005304@zach-dev.vmware.com> <20050816043702.GS7762@shell0.pdx.osdl.net>
In-Reply-To: <20050816043702.GS7762@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Aug 2005 05:03:42.0414 (UTC) FILETIME=[DF4F76E0:01C5A21F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>* zach@vmware.com (zach@vmware.com) wrote:
>  
>
>>Attempt to fix the UML build by assuming the default i386 subarchitecture
>>(mach-default).
>>
>>I can't fully test this because spinlock breakage is still happening in
>>my tree, but it gets rid of the mach_xxx.h missing file warnings.
>>    
>>
>
>I assume this is intended to fix a build error caused by patches in the
>earlier set which added more reliance on mach-default?
>  
>

Yes, I already sent the fix to Jeff and Andrew, so it may already 
included in anything based off -mm1.  But it seems a good idea in 
general for UML.  I got a 100% clean um-i386 build after this patch on 
-rc5-mm1.

Zach
