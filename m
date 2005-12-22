Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbVLVW5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbVLVW5Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 17:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbVLVW5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 17:57:16 -0500
Received: from kirby.webscope.com ([204.141.84.57]:41154 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1030349AbVLVW5Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 17:57:16 -0500
Message-ID: <43AB2EDF.6030207@linuxtv.org>
Date: Thu, 22 Dec 2005 17:55:27 -0500
From: Mike Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: "P. Christeas" <p_christ@hol.gr>, Adrian Bunk <bunk@stusta.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc6: known regressions in the kernel Bugzilla
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>	<20051222005209.0b1b25ca.akpm@osdl.org>	<20051222135718.GA27525@stusta.de>	<200512222152.05427.p_christ@hol.gr> <1135291436.14685.7.camel@localhost>
In-Reply-To: <1135291436.14685.7.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab wrote:

>Em Qui, 2005-12-22 às 21:52 +0200, P. Christeas escreveu:
>  
>
>>On Thursday 22 December 2005 3:57 pm, you wrote:
>>    
>>
>>The two important tags are:
>>v2.6.13 0da688d20078783b23f99b232b272b027d6c3f59
>>v2.6.14-rc1 1f9d1e3248d4eb96b229eecf0e5d9445d3529e85
>>    
>>
>Christeas,
>
>	Between 2,6,13 and 2.6.14-rc1 we had about 220 v4l patches. It would
>help more if you get v4l CVS tree and try to identify the broken patch.
>there weren't so many patches for cx2388x. I suspect it might be some
>changes at tda9887, cx88-cards or cx88-tvaudio (the latest is the more
>likely).
>  
>
Actually, a -git bisection test is even easier, less work involved, and 
will point you to the exact patch that caused the regression.

http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bisect.txt

Cheers,
Michael Krufky

P.S.: I apologize if any cc's got dropped.... I tried to add those that 
I know should be here, but the V4L mailing list hosted by RedHat adds a 
Reply-To: and drops all the cc's ...  I've been flamed about it in the 
past, and I complained about it on V4L list-- Alan Cox says this was 
intended, and nobody agrees with me that it should be fixed.  :-(  (this 
is my last word on the issue)

