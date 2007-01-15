Return-Path: <linux-kernel-owner+w=401wt.eu-S1751286AbXAOSh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbXAOSh1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 13:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbXAOSh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 13:37:27 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:64891 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbXAOSh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 13:37:26 -0500
Message-ID: <45ABCA64.6000000@student.ltu.se>
Date: Mon, 15 Jan 2007 19:39:32 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] How to (automatically) find the correct maintainer(s)
References: <45A9092F.7060503@student.ltu.se> <tkrat.428a51215926acac@s5r6.in-berlin.de> <45A93069.5080906@student.ltu.se> <tkrat.343d5eb8f1097532@s5r6.in-berlin.de> <45A96C3F.3090307@student.ltu.se> <tkrat.af9f8565dea59963@s5r6.in-berlin.de> <45AAA090.6010701@student.ltu.se> <tkrat.fe0c382d998fca1c@s5r6.in-berlin.de>
In-Reply-To: <tkrat.fe0c382d998fca1c@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> On 14 Jan, Richard Knutsson wrote:
>   
>> Stefan Richter wrote:
>>     
>>> May I remind that whoever uses scripts to figure out contacts should
>>> better double-check what the script found out for him.
>>>       
> [...]
>   
>> During development, that's a given. But I would hope that when its more 
>> stable it will always find the right answer or no answer at all (if 
>> there is errors in ex MAINTAINERS, even the human will bother the receiver)
>>     
>
> Note, if people build scripts which look up contacts, I hope they don't
> become careless and forget to search elsewhere for proper contacts if
> _no_ contact was found automatically.
>   
Maybe the script may print out some pointers for such a case ;)
> [...]
>   
>>> It is already somewhat
>>> costly to backtrack .c files from .o files from config options, but
>>> considerably more so with .h files.
>>>
>>>       
>> I think it is to early to be thinking about what is easier, first a 
>> "algorithm" that does what we want is needed, then I'm more then happy 
>> to write a script/program for it :)
>> Costly?? It is even simple in bash:
>> C_FILE=${O_FILE/'.o'/'.c'}
>>     
>
> When I wrote "somewhat costly" I didn't refer to a 1:1 mapping between
> .c and .o. That's not what it takes. I mostly referred to having to
> implement a parser for parts of the Linux Makefile language. On the
> bright side, the more indirection you introduce, the less people will
> write their own scripts and the less scripts with bugs will be out
> there. :-)
>
>   
Oh, yes so it is. But I don't think it will be too much. But do you have 
any objections on the last proposal (to include "I:"), otherwise I 
thinking of trying to implement it (thinking of Perl, any reason to not 
do so?) to see if it can stand real usage.

Hope so (on bugs that is, always fun with scripts) :)
> [...]
>   
>> (I: for "include". Btw, what is F: standing for? Is it instead of P:?)
>>     
> [...]
>
> Doesn't need to be F. "Files" happens to start with F.
>   
Doh, was in the track of "pathway" or such...

