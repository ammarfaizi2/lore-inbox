Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbVLVWNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbVLVWNH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 17:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbVLVWNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 17:13:07 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:53854 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030345AbVLVWNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 17:13:05 -0500
Message-ID: <43AB24DC.20209@tmr.com>
Date: Thu, 22 Dec 2005 17:12:44 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: remove CONFIG_UID16
References: <20051217044410.GO23349@stusta.de> <20051217131807.GD13043@infradead.org> <20051217183854.GQ23349@stusta.de>
In-Reply-To: <20051217183854.GQ23349@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sat, Dec 17, 2005 at 01:18:07PM +0000, Christoph Hellwig wrote:
> 
>>On Sat, Dec 17, 2005 at 05:44:10AM +0100, Adrian Bunk wrote:
>>
>>>It seems noone noticed that CONFIG_UID16 was accidentially always 
>>>disabled in the latest -mm kernels.
>>>
>>>Is there any reason against removing it completely?
>>
>>Yes, it breaks backwards-compatilbity for not even that old binaries.
>>
>>There's not way we're ever going to remove it.
> 
> 
> You are right.
> 
> Sorry, this was a dumb idea

The question is, did you prove that (a) the people who need it are smart 
enough to set it, or (b) the people who need it are not testing -mm kernels.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
