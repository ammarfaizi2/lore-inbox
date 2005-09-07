Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVIGQhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVIGQhF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 12:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVIGQhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 12:37:04 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:9220 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751242AbVIGQhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 12:37:02 -0400
Message-ID: <431F18A3.6050502@tmr.com>
Date: Wed, 07 Sep 2005 12:43:15 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Davis <alex14641@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: i386: kill !4KSTACKS
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
In-Reply-To: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Davis wrote:
>>Please don't tell me to "care for closed-source drivers". 
> 
> ndiswrapper is NOT closed source. And I'm not asking you to "care".
> 
> 
>>I don't want the pain of debugging crashes on the machines which run unknown code
>>in kernel space.
> 
> I'm not asking you to debug crashes. I'm simply requesting that the
> kernel stack size situation remain as it is: with 8K as the default
> and 4K configurable. 

I can be happy with 4K as the default, everything I use *except* 
ndiswrapper seems to run fine (I don't currently need fancy filesystems) 
but laptops seem to include a lot of unsupported hardware, which can't 
be replaced due to resources (money, slots, batter life).
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
