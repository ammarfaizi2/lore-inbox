Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUKJJ4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUKJJ4G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 04:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbUKJJ4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 04:56:06 -0500
Received: from smtp.rol.ru ([194.67.21.9]:49000 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S261631AbUKJJz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 04:55:56 -0500
Message-ID: <4191E657.1030409@vlnb.net>
Date: Wed, 10 Nov 2004 12:58:47 +0300
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: "Moore, Eric Dean" <Eric.Moore@lsil.com>, mpt_linux_developer@lsil.com,
       linux-kernel@vger.kernel.org,
       "Shirron, Stephen" <Stephen.Shirron@lsil.com>
Subject: Re: 2.6: unused code under drivers/message/fusion/
References: <91888D455306F94EBD4D168954A9457C2D1E91@nacos172.co.lsil.com> <4191CD47.1000205@vlnb.net> <20041110094041.GI4089@stusta.de>
In-Reply-To: <20041110094041.GI4089@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Wed, Nov 10, 2004 at 11:11:51AM +0300, Vladislav Bolkhovitin wrote:
> 
>>Moore, Eric Dean wrote:
>>
>>>We need to hold off on this change. Yes, there are 
>>>customers of LSI Logic using mptstm.c, as
>>>part of the target-mode drivers.  
>>>
>>>The proposed generic target mode drivers proposal is yet part
>>>of the kernel.  
>>>http://scst.sourceforge.net/
>>>We are looking into supporting this once its available.
>>
>>Well, SCST is already available, stable and useful. People use it 
>>without considerable problems, except with inconvenient LUNs management, 
>>which we are going to fix in the next version. I don't expect it will be 
>>considering for the kernel inclusion at least until 2.7. So, you can 
>>start supporting it right now :-).
> 
> 
> With the current kernel development model, there is no 2.7 planned for 
> the next years.
> 
> Linus and Andrew believe 6 was an odd number, so you could submit your 
> code now. [1]

OK, I'll prepare the next version as the kernel patch.

Thanks,
Vlad

>>Vlad
> 
> 
> cu
> Adrian
> 
> [1] this is a slightly abbreviated version of the development model
>     Linus announced
> 

