Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965254AbWIFAQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965254AbWIFAQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 20:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbWIFAQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 20:16:35 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:3806 "EHLO gepetto.dc.ltu.se")
	by vger.kernel.org with ESMTP id S965254AbWIFAQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 20:16:34 -0400
Message-ID: <44FE14ED.3020605@student.ltu.se>
Date: Wed, 06 Sep 2006 02:23:09 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: akpm@osdl.org, xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [xfs-masters] Re: [PATCH 2.6.18-rc4-mm3 2/2] fs/xfs: Converting
 into generic boolean
References: <44F833C9.1000208@student.ltu.se> <20060904150241.I3335706@wobbly.melbourne.sgi.com> <44FBFEE9.4010201@student.ltu.se> <20060905130557.A3334712@wobbly.melbourne.sgi.com> <44FD71C6.20006@student.ltu.se> <20060906091407.M3365803@wobbly.melbourne.sgi.com>
In-Reply-To: <20060906091407.M3365803@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:

>On Tue, Sep 05, 2006 at 02:47:02PM +0200, Richard Knutsson wrote:
>  
>
>>Just the notion: "your" guys was the ones to make those to boolean(_t), 
>>    
>>
>
>Sort of, we actually inherited that type from IRIX where it is
>defined in <sys/types.h>.
>  
>
Oh, ok

>>>"int needflush;" is just as readable (some would argue moreso) as
>>>"bool needflush;" and thats pretty much the level of use in XFS -
>>> 
>>>      
>>>
>>How are you sure "needflush" is, for example, not a counter?
>>    
>>
>
>Well, that would be named "flushcount" or some such thing.  And you
>would be able to tell that it was a counter by the way its used in
>the surrounding code.
>  
>
True, thinking more of when you have a quick look at the headers, but 
"flushcount" would be a more logical name in such a case.

>This discussion really isn't going anywhere useful; I think you need
>to accept that not everyone sees value in a boolean type. :)
>  
>
Well, can you blame me for trying? ;)
But the more important thing is to clean up the boolean-type and 
FALSE/TRUE mess in the kernel.

>cheers.
>  
>
Thank you for your time and happy coding :)

