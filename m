Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWAKSci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWAKSci (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWAKSci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:32:38 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:30707 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932219AbWAKSch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:32:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=ARdoAdOnhUTiFv87yavOV/7NQaP81q63aUgMaRJsQYP3Nnexs7NY6gQEzRx3h70M+piqY3mU+6Sm6LMHCzX4EEjfWzmmCW4U2g5eU0pGAxedgVeiX/PRWbcQqv1gMvjsjhxiDj5rGFB/enzkSkGZapJ1KzYVQkUSmye7ZQy62SA=
Message-ID: <43C54F32.3040509@gmail.com>
Date: Thu, 12 Jan 2006 00:02:18 +0530
Reply-To: chaitanya.hazarey@gmail.com
Organization: Grid Comp & Ecom Lab (C-212), School of Technology and Computer
 Science, Tata Institue of Fundamental Research, Mumbai
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Back to the Future ? or some thing sinister ?
References: <eaef64fc0601081131i17336398l304038c6dea3e057@mail.gmail.com>	 <20060109040322.GA2683@localhost.localdomain> <728201270601090726i256cf19bj48be55621b86931f@mail.gmail.com>
In-Reply-To: <728201270601090726i256cf19bj48be55621b86931f@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
From: Chaitanya Vinay Hazarey <c.v.hazarey@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Gupta wrote:

>On 1/8/06, Nathan Lynch <ntl@pobox.com> wrote:
>  
>
>>Chaitanya Hazarey wrote:
>>    
>>
>>>We have got a machine, lets say X , make is IBM and the CPU is Intel
>>>Pentium 4 2.60 GHz. Its running a 2.6.13.1 Kernel and previously,
>>>      
>>>
>
>
>Is this machine's time is synchronized with some server using ntp. I
>had seen some very similar issue when the clock deviation was more
>than a second .If clock is adjusted and time difference becomes more
>than 2 sec the diffence becomes negative because timeval has its
>members as signed int.It think that issue might be playing a role
>here.
>
>  
>
Nope tried every thing, shutting down the ntp server, changing the Ntp 
server, any thing I do it still will hang intermittently. And if the 
problem is because of the Ntp why should it hang only on 2.6 not 2.4 
kernels ?

And the point is that when it reaches that stage all the commands seem 
to execute ultra slow.

Any help for diagnosing the problem is most welcome.

Thanks,

Chaitanya


