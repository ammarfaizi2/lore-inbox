Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161194AbWHKH2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161194AbWHKH2b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 03:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161198AbWHKH2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 03:28:30 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:12614 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161173AbWHKH22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 03:28:28 -0400
Message-ID: <44DC319A.10802@de.ibm.com>
Date: Fri, 11 Aug 2006 09:28:26 +0200
From: Thomas Klein <osstklei@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
CC: Alexey Dobriyan <adobriyan@gmail.com>,
       Jan-Bernd Themann <ossthema@de.ibm.com>, netdev@vger.kernel.org,
       Thomas Klein <tklein@de.ibm.com>, linuxppc-dev@ozlabs.org,
       Christoph Raisch <raisch@de.ibm.com>, linux-kernel@vger.kernel.org,
       Marcus Eder <meder@de.ibm.com>
Subject: Re: [PATCH 3/6] ehea: queue management
References: <44D99F38.8010306@de.ibm.com> <20060811000540.200CE67B6B@ozlabs.org> <20060811003204.GA6935@martell.zuzino.mipt.ru> <20060811004602.23EB467B64@ozlabs.org>
In-Reply-To: <20060811004602.23EB467B64@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Neuling wrote:
>>>> +static inline u32 map_swqe_size(u8 swqe_enc_size)
>>>> +{
>>>> +	return 128 << swqe_enc_size;
>>>> +}		      ^
>>>> +		      |
>>>> +static inline u32|map_rwqe_size(u8 rwqe_enc_size)
>>>> +{		      |
>>>> +	return 128 << rwqe_enc_size;
>>>>         
>> 		      ^
>>     
>>>> +}		      |
>>>>         
>>> 		      |
>>> Snap!  These are ide|tical...
>>>       
>> 		      |
>> No, they aren't. -----+
>>     
>
> Functionally identical.
>
> Mikey
>
>   
Agreed. Functions were replaced by a single map_wqe_size() function.

Thomas

