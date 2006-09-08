Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWIHHc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWIHHc7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 03:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWIHHc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 03:32:59 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:65327 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750701AbWIHHc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 03:32:58 -0400
Message-ID: <45011CAC.2040502@openvz.org>
Date: Fri, 08 Sep 2006 11:33:00 +0400
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: balbir@in.ibm.com, Kirill Korotaev <dev@sw.ru>,
       Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
 memory)
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>	 <44FEC7E4.7030708@sw.ru>  <44FF1EE4.3060005@in.ibm.com> <1157580371.31893.36.camel@linuxchandra>
In-Reply-To: <1157580371.31893.36.camel@linuxchandra>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> On Thu, 2006-09-07 at 00:47 +0530, Balbir Singh wrote:
>
> <snip>
>> Some not quite so urgent ones - like support for guarantees. I think
>> this can
>
> IMO, guarantee support should be considered to be part of the
> infrastructure. Controller functionalities/implementation will be
> different with/without guarantee support. In other words, adding
> guarantee feature later will cause re-implementations.
I'm afraid we have different understandings of what a "guarantee" is.
Don't we?
Guarantee may be one of

  1. container will be able to touch that number of pages
  2. container will be able to sys_mmap() that number of pages
  3. container will not be killed unless it touches that number of pages
  4. anything else

Let's decide what kind of a guarantee we want.
>> be worked out as we make progress.
>>
>>> I agree with these requirements and lets move into this direction.
>>> But moving so far can't be done without accepting:
>>> 1. core functionality
>>> 2. accounting
>>>
>> Some of the core functionality might be a limiting factor for the requirements.
>> Lets agree on the requirements, I think its a great step forward and then
>> build the core functionality with these requirements in mind.
>>
>>> Thanks,
>>> Kirill
>>>

