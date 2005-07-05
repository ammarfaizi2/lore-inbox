Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVGEP2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVGEP2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 11:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVGEP2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 11:28:43 -0400
Received: from po2.wam.umd.edu ([128.8.10.164]:25763 "EHLO po2.wam.umd.edu")
	by vger.kernel.org with ESMTP id S261887AbVGEPRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 11:17:45 -0400
Date: Tue, 5 Jul 2005 11:17:35 -0400 (EDT)
From: Patrick Jenkins <patjenk@wam.umd.edu>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] multipath routing algorithm, better patch
Message-ID: <Pine.GSO.4.61.0507051114310.15834@rac3.wam.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Thomas Graf wrote:
>> * Patrick McHardy <42C4919A.5000009@trash.net> 2005-07-01 02:43
>>
>>>If it isn't set correctly its an iproute problem. Did you actually
>>>experience any problems?
>>
>> Well, my patch for iproute2 to enable multipath algorithm selection
>> is currently being merged to Stephen together with the ematch bits.
>> We had to work out a dependency on GNU flex first (the berkley
>> version uses the same executable names) so the inclusion was
>> delayed a bit.
>
>So its no problem but simply missing support. BTW, do you know if
>Stephen's new CVS repository is exported somewhere?

Yes, we did experience a problem. The routing doesnt work as advertised 
(i.e. it wont utilize the multiple routes). Patrick is correct in saying 
its missing support.

>From what you are saying it seems the problem will be corrected by a new 
feature in iproute2 that allows the user to select this ability. Is this 
correct? Also, does this mean my patch is not needed? It seems to me that 
it should be supported somehow in the kernel seeing as how everyone might 
not utilize iproute2.

Once again, please cc me in the reply because I am not a member of the 
list.

Thanks,
Patrick Jenkins


