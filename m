Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311642AbSC2Tal>; Fri, 29 Mar 2002 14:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311644AbSC2Tab>; Fri, 29 Mar 2002 14:30:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32777 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311642AbSC2TaR>;
	Fri, 29 Mar 2002 14:30:17 -0500
Message-ID: <3CA4C066.3020509@mandrakesoft.com>
Date: Fri, 29 Mar 2002 14:28:38 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Michal Jaegermann <michal@harddata.com>
CC: brian@worldcontrol.com, linux-kernel@vger.kernel.org
Subject: Re: tulip driver again
In-Reply-To: <20020328174724.A24374@mail.harddata.com> <20020329024021.GA2887@top.worldcontrol.com> <20020328215744.A25760@mail.harddata.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Jaegermann wrote:

>On Thu, Mar 28, 2002 at 06:40:21PM -0800, brian@worldcontrol.com wrote:
>
>>On Thu, Mar 28, 2002 at 05:47:24PM -0700, Michal Jaegermann wrote:
>>
>>>I know that this is boring and a number of my earlier reports was
>>>apparently ignored
>>>
>>There is a tulip specific discussion list, which may explain why you
>>get ignored on this forum.
>>
>
>Well, in a due time I filed pretty detailed bug reports, with dumps
>of PCI space from older working and non-working drivers and what not,
>on sourceforge where presumably a development of this driver was going.
>This was ignored there as well.
>

Currently the tulip driver is very stable for a large number of 
chipsets, but not all of them.  And there are some problems like, 
"calling this function with 1 as argument, and some chipsets work. 
 calling this function with 0 as argument, and that breaks some chipsets 
but then other chipsets are fixed."

The temporary solution is to use the latest _stable_ version of the 
driver, on http://sf.net/projects/tulip/ or use the de4x5 driver.  I am 
working on the long term solution, which is fixing the link state 
machine in the driver to actually be (a) sane and (b) workable for all 
chipsets.

This work is going to be merged into 2.5.x series _first_, then after 
it's proven stable merged back into 2.4.x as a solution for all.  But 
this takes time... in the meantime, there are the temporary solutions 
mentioned to get you by.

    Jeff






