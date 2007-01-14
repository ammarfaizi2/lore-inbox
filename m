Return-Path: <linux-kernel-owner+w=401wt.eu-S1750959AbXANVkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbXANVkW (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 16:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbXANVkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 16:40:22 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:40011 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbXANVkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 16:40:21 -0500
Message-ID: <45AAA3C2.80603@student.ltu.se>
Date: Sun, 14 Jan 2007 22:42:26 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Matthias Schniedermeyer <ms@citd.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] How to (automatically) find the correct maintainer(s)
References: <45A9092F.7060503@student.ltu.se> <45A93B02.7040301@citd.de> <45A96E31.3080307@student.ltu.se> <45A973A8.1000101@citd.de>
In-Reply-To: <45A973A8.1000101@citd.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> Richard Knutsson wrote:
>   
>> Matthias Schniedermeyer wrote:
>>
>>     
>>> Richard Knutsson wrote:
>>>
>>>  
>>>
>>>       
>>>> Any thoughts on this is very much appreciated (is there any flaws with
>>>> this?).
>>>>     
>>>>         
>>> The thought that crossed my mind was:
>>>
>>> Why not do the same thing that was done to the "Help"-file. (Before it
>>> was superseded by Kconfig).
>>>
>>> Originaly there was a central Help-file, with all the texts. Then it was
>>> split and placed in each sub-dir. And later it was superseded by Kconfig.
>>>
>>> On the other hand you could skip the intermediate step and just fold the
>>> Maintainer-data directly into Kconfig, that way everything is "in one
>>> place" and you could place a "Maintainers"-Button next to the
>>> "Help"-Button in *config, or just display it alongside the help.
>>>
>>> And MAYBE that would also lessen the "update-to-date"-problem, as you
>>> can just write the MAINTAINERs-data when you create/update the
>>> Kconfig-file. Which is a thing that creates much bigger pain when you
>>> forget it accidently. ;-)
>>>
>>> Oh, and it neadly solves the mapping-problem, for at least all
>>> kernel-parts that have a Kconfig-option/Sub-Tree.
>>>   
>>>       
>> I'm all for splitting up the MAINTAINERS! :)
>>
>> Just, do you have any ideas how to solve the possible multiple of the
>> same entries, when handling multiple sub-directories and when many
>> different drivers with different maintainers are in the same directory
>> and a maintainer have more then one driver?
>>     
>
> Handles.
> If a Maintainer maintains several subsystems/drivers a "handle" could be
> used to references to a handle-list (hello MAINTAINERS) or to the place
> where the full-maintainers-entry is placed.
>   
Mm, and maybe store the entry on the shortest-pathway common directory. 
Then there should be just a few left entries in the current MAINTAINERS. 
But how to create the handles?
* Name (problem with persons with the same name)
* E-mail (much to change when they change it)
This also make a problem when there is a change of the maintainer, what 
happens with the entry if there is no maintainer?
* Just numbers and increase every new one with one? (quite ugly!)
... and here is the end of my ideas.

Any good ideas? (Really liked the idea to have a "Maintainer"-button 
next to "Help" in *config)

