Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWIABbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWIABbb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWIABbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:31:31 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:40150 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S964845AbWIABba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:31:30 -0400
Message-ID: <44F78F0D.2030907@student.ltu.se>
Date: Fri, 01 Sep 2006 03:38:21 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: akpm@osdl.org, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc4-mm3 2/2] fs/xfs: Correcting error-prone boolean-statement
References: <44F77653.6000606@student.ltu.se> <20060901100745.P3186664@wobbly.melbourne.sgi.com> <44F78A67.1060007@student.ltu.se> <20060901111601.R3186664@wobbly.melbourne.sgi.com>
In-Reply-To: <20060901111601.R3186664@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:

>On Fri, Sep 01, 2006 at 03:18:31AM +0200, Richard Knutsson wrote:
>  
>
>>Nathan Scott wrote:
>>    
>>
>>>Are you using XFS on your systems?  What is your strategy for getting this
>>>runtime tested going to be?  Or are you delegating that responsibility? :)
>>> 
>>>      
>>>
>>Sorry, can't say that I do. So pretty please... ;)
>>Seriously, I can not find a state when this may fail (if not "if (var == 
>>TRUE)" happend to be correct for 'var' != 0 != 1, but that is just a bug 
>>waiting to happend).
>>But please correct me if I am wrong.
>>    
>>
>
>OK, I'll run with it in my own testing for awhile.
>
Thanks!

>                                                    I was also curious to
>why you didn't remove the other few B_TRUE/B_FALSE occurences?  (and the
>typedef)?
>  
>
Working on it. Should be out tomorrow(or in about 20 hours).
 From the "Re: Conversion to generic boolean"-thread (started on 
06-08-28), there were those who did not seem to like the conversion. But 
since no-one complained about removing "== B_FALSE/B_TRUE", I thought it 
best to remove them first and then take the rest from there.

>cheers.
>
>  
>
cu

