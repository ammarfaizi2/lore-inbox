Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271744AbTGRNjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 09:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271757AbTGRNjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:39:51 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:47239 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S271744AbTGRNjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:39:49 -0400
Message-ID: <3F17FF5B.2040409@genebrew.com>
Date: Fri, 18 Jul 2003 10:08:27 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Dave Jones <davej@codemonkey.org.uk>,
       "Andrew S. Johnson" <andy@asjohnson.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DRM, radeon, and X 4.3
References: <200307170539.25702.andy@asjohnson.com>	 <20030717172625.GA16502@suse.de> <1058532934.19558.31.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1058532934.19558.31.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2003-07-17 at 18:26, Dave Jones wrote:
> 
>> > Linux agpgart interface v0.100 (c) Dave Jones
>> > [drm] Initialized radeon 1.9.0 20020828 on minor 0
>> > [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
>> > [drm:radeon_unlock] *ERROR* Process 1929 using kernel context 0
>> > 
>> > There is something X doesn't like.  How do I fix this?
>>
>>Looks like there isn't an agp chipset module also loaded
>>(via-agp.o, intel-agp.o etc...)
> 
> 
> Still shouldnt do that - also the radeon doesn't require AGP

FWIW, I can reproduce the "problem" here. Perhaps a less cryptic error 
message could be printked.

Thanks,
Rahul

