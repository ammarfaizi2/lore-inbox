Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266512AbUF0Boh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUF0Boh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 21:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUF0Bog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 21:44:36 -0400
Received: from mta13.mail.adelphia.net ([68.168.78.44]:388 "EHLO
	mta13.adelphia.net") by vger.kernel.org with ESMTP id S266512AbUF0Bod
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 21:44:33 -0400
Message-ID: <40DE267A.20907@capitalgenomix.com>
Date: Sat, 26 Jun 2004 21:44:26 -0400
From: "Fao, Sean" <sean.fao@capitalgenomix.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Wille Padnos <spadnos@sover.net>
CC: Amit Gud <gud@eth.net>, "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       Alan <alan@clueserver.org>, Pavel Machek <pavel@ucw.cz>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS)
References: <004e01c45abd$35f8c0b0$b18309ca@home>	 <200406251444.i5PEiYpq008174@eeyore.valparaiso.cl>	 <20040625162537.GA6201@elf.ucw.cz> <1088181893.6558.12.camel@zontar.fnordora.org> <40DC625F.3010403@eth.net> <40DC8981.7090703@dynextechnologies.com> <40DCF598.6000206@eth.net> <40DDEC76.8060101@capitalgenomix.com> <40DE03DF.7090404@sover.net>
In-Reply-To: <40DE03DF.7090404@sover.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Wille Padnos wrote:

> Fao, Sean wrote:
>
>> Amit Gud wrote:
>>
>>> Fao, Sean wrote:
>>>
>>>> Amit Gud wrote:
>>>>
>>>>> It cannot be denied that there _are_ applications for such a 
>>>>> system that we already discussed and theres a class of users who 
>>>>> will find the system useful.
>>>>
>>>>
>>>> I personally see no use whatsoever. Why not just allocate 100% of 
>>>> the file system to everybody and ignore quota's, entirely?  Each 
>>>> user will use whatever he/she requires and when space starts to run 
>>>> out, users will manually clean up what they don't need.
>>>
>>>
>>> We should get our basics right first. We _do_ need quotas!! Without 
>>> any quota system how are we going to avoid a malicious user  from 
>>> taking away all the space to keep other people starving? In EQFS 
>>> also this can happen, but we are giving *controlled flexibility* to 
>>> the user. He is having some stretching power but not beyond a 
>>> certain limit. And do you think users are sincere enough to clean up 
>>> there files when they are done?
>>
>>
>> And I suppose you think that users will be sincere enough to mark 
>> files as elastic?  I, for one, already said that I absolutely would 
>> *not* mark a single file as elastic.  If I'm using 110 MB and you 
>> need an additional 10 MB for storage, you won't be getting it from me 
>> because I don't want to come in some morning to find that a file has 
>> disappeared.
>>
>> The system that you're asking for is a system without quotas.  Think 
>> about what you're saying.
>
>
> I think you missed one of the main points - you don't get any extra 
> space until you mark some of your files as elastic.
> You're right - under this system, nobody would get any space from 
> deletion of your files because you would use the system as a normal 
> hard quota system - you would mark no files as elastic, and would 
> therefore be limited to your quota (in the example you gave, you would 
> not be using 110M, because your quota would have limited you to 
> 100M).  If you were so kind as to mark something as elastic (say, that 
> recently doneloaded install tarball of the Gimp), then you would 
> remove the storage taken by those files from your quota usage and 
> would have more space available, with the risk that the elastic files 
> might not stick around.


You're right; I did missunderstand one of the main points.  I was under 
the impression that I could take whatever I needed, as long as it were 
available.  This does change my view on the subject, somewhat.

Thanks for clearing that up,

Sean
