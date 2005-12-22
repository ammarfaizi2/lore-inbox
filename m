Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbVLVWMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbVLVWMu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 17:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbVLVWMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 17:12:50 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:9392 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1030344AbVLVWMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 17:12:49 -0500
Message-ID: <43AB24DF.4080908@ru.mvista.com>
Date: Fri, 23 Dec 2005 01:12:47 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH/RFC] SPI core: turn transfers to be linked list
References: <43A480C0.9080201@ru.mvista.com> <200512200011.57052.david-b@pacbell.net> <43A95713.6020405@ru.mvista.com> <200512220955.46916.david-b@pacbell.net>
In-Reply-To: <200512220955.46916.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>>And in case transfers is an array, we should either be apriory  
>>aware of whether the chaining will take place or allocate an array large 
>>enough to hold additional transfers. Neither of these look good to me, 
>>and having a linked list of transfers will definitely solve this problem.
>>    
>>
>
>Well, that's the guts of the good example I was hoping you would share.
>I'll be posting a refresh of this code soonish; maybe you can provide 
>a complete patch, changing all the code over to use list-not-array?
>  
>
Let's agree upon that I'll proovide the complete patch as soon as you 
repost all the patches from the very beginning (with the updates you've 
made).
It's a little bit hard to track all that stuff now, I mean patches, 
patches to patches, etc. :)

Vitaly
