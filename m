Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUFZEDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUFZEDg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 00:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUFZEDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 00:03:36 -0400
Received: from chnmfw01.eth.net ([202.9.145.21]:62988 "EHLO ETH.NET")
	by vger.kernel.org with ESMTP id S262138AbUFZEDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 00:03:34 -0400
Message-ID: <40DCF598.6000206@eth.net>
Date: Sat, 26 Jun 2004 09:33:36 +0530
From: Amit Gud <gud@eth.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Fao, Sean" <Sean.Fao@dynextechnologies.com>
CC: Alan <alan@clueserver.org>, Pavel Machek <pavel@ucw.cz>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS)
References: <004e01c45abd$35f8c0b0$b18309ca@home>	 <200406251444.i5PEiYpq008174@eeyore.valparaiso.cl>	 <20040625162537.GA6201@elf.ucw.cz> <1088181893.6558.12.camel@zontar.fnordora.org> <40DC625F.3010403@eth.net> <40DC8981.7090703@dynextechnologies.com>
In-Reply-To: <40DC8981.7090703@dynextechnologies.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jun 2004 03:55:51.0203 (UTC) FILETIME=[78D5F730:01C45B31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fao, Sean wrote:

> Amit Gud wrote:
>
>> It cannot be denied that there _are_ applications for such a system 
>> that we already discussed and theres a class of users who will find 
>> the system useful.
>
>
>
> I personally see no use whatsoever. Why not just allocate 100% of the 
> file system to everybody and ignore quota's, entirely?  Each user will 
> use whatever he/she requires and when space starts to run out, users 
> will manually clean up what they don't need.
>
We should get our basics right first. We _do_ need quotas!! Without any 
quota system how are we going to avoid a malicious user  from taking 
away all the space to keep other people starving? In EQFS also this can 
happen, but we are giving *controlled flexibility* to the user. He is 
having some stretching power but not beyond a certain limit. And do you 
think users are sincere enough to clean up there files when they are done?

> I am totally against the automatic deletion of files and believe that 
> all users will _eventually_ walk in on a Monday morning to find out 
> that the OS took it upon itself to delete a file that was flagged as 
> elastic, that shouldn't have been.  

User is the king, he decides what files should be elastic and what not. 
This can always be controlled.


AG

