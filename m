Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWIMOlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWIMOlq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 10:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWIMOlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 10:41:46 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:47519 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750884AbWIMOlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 10:41:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=tEWl1pS6qFKBYPRbLQKFWgzoO7I9sUDwUZ+PtHswiCl52jVatRjmp61KXwrkF6ZAK6WwK5MwqSAp+ner6XZzntwY2r3tRCZCYmFGoEpiDCEEwF/yIO1RkW6x1qgHoFf0zHZ4pfKmISI94smfJgB03sFH1bsml7Jpab/6OnNsbl8=
Message-ID: <450818A2.30402@gmail.com>
Date: Wed, 13 Sep 2006 23:41:38 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: Linux v2.6.18-rc5
References: <15740.1157524923@ocs3.ocs.com.au>
In-Reply-To: <15740.1157524923@ocs3.ocs.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> Tejun Heo (on Sun, 03 Sep 2006 15:10:44 +0900) wrote:
>> Hmm... Can you try the attached patch and see what happens?  ATM, I'm on 
>> the road and can't test the patch, so it's only compile-tested.  This 
>> patch basically reverts some of the effects of the following commit and 
>> makes PCS update a little bit more aggressive iff necessary.
>>
>> ea35d29e2fa8b3d766a2ce8fbcce599dce8d2734
>> [libata] ata_piix: Consolidate PCS register writing
> 
> I am also on the road, without access to the machines that had the ich5
> and ich7 problems.  I will not be able to test the patch until about
> September 18.

It seems my box can't reproduce your condition.  I did ~50 soft reboots 
but PCS always correctly detects devices.  I'll wait for your test result.

Thanks.

-- 
tejun
