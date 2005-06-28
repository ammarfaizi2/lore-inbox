Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVF1SvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVF1SvC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 14:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVF1SvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 14:51:01 -0400
Received: from smtp-2.llnl.gov ([128.115.250.82]:49308 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S261314AbVF1Su2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 14:50:28 -0400
Date: Tue, 28 Jun 2005 11:50:11 -0700 (PDT)
From: Chuck Harding <charding@llnl.gov>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-reply-to: <20050628153139.GA2348@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.63.0506281145270.31407@ghostwheel.llnl.gov>
Organization: Lawrence Livermore National Laboratory
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Pine/4.62 (X11; U; Linux i686; en-US; rv:2.6.11-rc2-mm1)
References: <20050608112801.GA31084@elte.hu> <20050625091215.GC27073@elte.hu>
 <200506250919.52640.gene.heskett@verizon.net>
 <200506251039.14746.gene.heskett@verizon.net>
 <Pine.LNX.4.63.0506271157200.8605@ghostwheel.llnl.gov>
 <1119902991.4794.5.camel@dhcp153.mvista.com>
 <Pine.LNX.4.58.0506280337390.24849@localhost.localdomain>
 <20050628081843.GA16455@elte.hu> <20050628091222.GA30629@elte.hu>
 <42C16C1F.20202@stud.feec.vutbr.cz> <20050628153139.GA2348@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005, Ingo Molnar wrote:

>
> * Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
>
>> Ingo Molnar wrote:
>>> i've also uploaded -50-27 in which i've improved the irq-flags debugging
>>> code.
>>
>> Hi Ingo,
>> check_raw_flags needs to be exported. The attached one-line patch is
>> against -V0.7.50-29.
>
> thanks, i've uploaded the -30 patch with your fix included.
>
> 	Ingo

It's working fine now - switching back and forth between graphical mode
and text console (which works with or with out the shift key B-)  and no
more flooding of BUG: scheduling with irqsw disabled in dmesg. I did
notice that 50-24 kernal was hard locked up when I came in this morning.
SysRq-B would not reboot it and pinging from another machine said it
was down. I went ahead and booted up another kernel and saw the message
about 50-30 so I built that and that is what I am running on now. I really
like using it because X works much better at rendering the screen and
screen animations are really smooth. (this is on a 2GHz P4 with 1Gb RAM)

-- 
Charles D. (Chuck) Harding <charding@llnl.gov>  Voice: 925-423-8879
Senior Computer Associate         ICCD            Fax: 925-423-6961
Lawrence Livermore National Laboratory      Computation Directorate
Livermore, CA USA  http://www.llnl.gov  GPG Public Key ID: B9EB6601
------------------ http://tinyurl.com/5w5ey -----------------------
-- Oxymoron: Spending Cuts. --
