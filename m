Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbVITFCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbVITFCe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 01:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbVITFCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 01:02:34 -0400
Received: from [210.76.114.20] ([210.76.114.20]:48838 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S932538AbVITFCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 01:02:33 -0400
Message-ID: <432F97E1.4080805@ccoss.com.cn>
Date: Tue, 20 Sep 2005 13:02:25 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: Song Jiang <sjiang@lanl.gov>
CC: LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [Question] How to understand Clock-Pro algorithm?
References: <432F7DD5.6050204@ccoss.com.cn> <1127188898.3130.52.camel@moon.c3.lanl.gov>
In-Reply-To: <1127188898.3130.52.camel@moon.c3.lanl.gov>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi:

    OOh, the original author here! Thanks a lot.

    Let's assume Mn is the total number of non-resident pages in follow 
words.

    Nod, 'M=Mh+Mc' and 'Mc+Mn' < 2M are always true.

    Have this implied that Mn is alway less than M? I think so.

    but if "Once the number exceeds M the memory size in number of pages,
we terminted the test period of the cold page pointed to by HAND-test."

    If Mn is alway less than M, when we move to HAND-test?

    Or, my view have error.

    I doublt on this, in fact.

    Good luck.

                                                                    Liyu


Song Jiang Wrote:

>On Mon, 2005-09-19 at 21:11, liyu wrote:
>
>  
>
>>    My question is out:As this paper words, the number of cold page is 
>>total of resident cold pages
>>and non-resident pages. It's the seem number of non-resident cold pages 
>>can not beyond M at all!
>>    
>>
>
>You are right. So the total number of pages (non-resident + resident)
>around the clock is no more than 2m 
>(m is the memory size in pages).
>
>  
>
>>   
>>    I also have more questions on CLOCK-Pro. but this question is most 
>>doublt for me.
>>
>>    
>>
>  I am happy to help. I also have the clock-pro simulator that
>almost exactly simulates what's described in the paper. Let me
>know if you want it.
>
>   Song Jiang
>
>  
>
>>liyu
>>
>>   
>>
>>
>>
>>   
>>   
>>
>>--
>>To unsubscribe, send a message with 'unsubscribe linux-mm' in
>>the body to majordomo@kvack.org.  For more info on Linux MM,
>>see: http://www.linux-mm.org/ .
>>Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
>>    
>>
>
>--
>To unsubscribe, send a message with 'unsubscribe linux-mm' in
>the body to majordomo@kvack.org.  For more info on Linux MM,
>see: http://www.linux-mm.org/ .
>Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
>
>
>  
>

