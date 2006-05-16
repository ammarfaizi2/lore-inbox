Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751699AbWEPIwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWEPIwS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 04:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbWEPIwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 04:52:18 -0400
Received: from smtpout.mac.com ([17.250.248.178]:24776 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751699AbWEPIwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 04:52:17 -0400
In-Reply-To: <20060516082859.GD18645@rhun.haifa.ibm.com>
References: <20060515213956.31627.qmail@web31508.mail.mud.yahoo.com> <1147732867.26686.188.camel@localhost.localdomain> <20060516025003.GC18645@rhun.haifa.ibm.com> <B2E79864-3AC6-4B72-B97B-222FEDA136A1@mac.com> <20060516082859.GD18645@rhun.haifa.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <89ABA4A5-D146-44BE-B36B-9F48E1F74CCB@mac.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jonathan Day <imipak@yahoo.com>,
       linux-kernel@vger.kernel.org, Zvika Gutterman <zvi@safend.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: /dev/random on Linux
Date: Tue, 16 May 2006 04:52:05 -0400
To: Muli Ben-Yehuda <muli@il.ibm.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 16, 2006, at 04:28, Muli Ben-Yehuda wrote:
> On Tue, May 16, 2006 at 04:15:19AM -0400, Kyle Moffett wrote:
>> On May 15, 2006, at 22:50, Muli Ben-Yehuda wrote:
>>> On Mon, May 15, 2006 at 11:41:07PM +0100, Alan Cox wrote:
>>>> A paper by people who can't work out how to mail linux-kernel or  
>>>> vendor-sec, or follow "REPORTING-BUGS" in the source,
>>>
>>> Zvi did contact Matt Mackall, the current /dev/random maintainer,  
>>> and was very keen on discussing the paper with him. I don't think  
>>> he got any response.
>>
>> So he's demanding that one person spend time responding to his paper?
>
> Who said anything about demanding? he wanted to discuss the paper.  
> He received no response (AFAIK). Please don't read more into it.

Pardon; my wording was overly harsh, but I still want to point out  
that assuming an unresponsive MAINTAINERS entry indicates that the  
person doesn't care is totally wrong.  Given the volume of email a  
lot of these people receive, it's very easy for it to go unnoticed or  
be trapped by a spam filter.  Publishing to the LKML is virtually  
always OK; even if you have a security problem, the average  
turnaround for "critical" security fixes like theoretical local root  
exploits is around 24 hours or so.  We went through about 8 stable  
"releases" over the course of a little more than a week because of  
several fairly urgent security fixes during that time.

>> The "maintainer" for any given piece of the kernel is the entry in  
>> MAINTAINERS *and* linux-kernel@vger.kernel.org *and* the  
>> appropriate sub-mailing-list.
>
> For security related information, it is sometimes best not to tell  
> the whole world about it immediately (although you should  
> definitely tell the whole world about it eventually). It should've  
> probably been posted to lkml when mpm didn't respond, I agree. I'll  
> take the blame for not suggesting that to Zvi.

As I said above, even the LKML is probably ok if you think you've  
found an actual explot.  If you really feel nervous about exposing  
it, I believe there's a security@kernel.org email where you can send  
such information which will even tenatively agree to a coordinated  
disclosure if you can prove that it's an urgent security problem.

Cheers,
Kyle Moffett

--
Premature optimization is the root of all evil in programming
   -- C.A.R. Hoare



