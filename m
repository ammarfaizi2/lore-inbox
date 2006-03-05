Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWCEWhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWCEWhT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 17:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbWCEWhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 17:37:19 -0500
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:62850 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751117AbWCEWhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 17:37:18 -0500
Message-ID: <440B681C.8030403@bigpond.net.au>
Date: Mon, 06 Mar 2006 09:37:16 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: =?ISO-8859-1?Q?Ra=FAl_Baena?= <raul_baena@ya.com>, jonathan@jonmasters.org,
       linux-kernel@vger.kernel.org
Subject: Re: Doubt about scheduler
References: <4407584A.60301@ya.com> <35fb2e590603032233i7302162do553ba61674cc8e50@mail.gmail.com> <440AE3F3.3090404@ya.com> <440AE7E3.4060500@yahoo.com.au>
In-Reply-To: <440AE7E3.4060500@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 5 Mar 2006 22:37:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Raúl Baena wrote:
> 
>> Thank you very much Jon. But I think I haven´t explained very well.
>>
>> I know that now the prio_array and runqueues structs aren´t accesible 
>> for modules, but in the 2.6.5 version they were. I would like to know 
>> the reason, why before they were accesible and now they don´t? If you 
>> could answer me, it would be great.
> 
> 
> I don't remember them being available in 2.6.5... but as to why they
> aren't available now: it is much cleaner this way. It even benefits
> you because now nobody will break your module when they change the
> data structure.

SuSE patched their 2.6.5 kernel to make the run queues visible in a 
header file.  Perhaps Raul was using a SuSE version of 2.6.5.

> 
>> I could to write the reason in my university job. (In Spain we have to 
>> make a final degree job, and mine is about modules in linux (I chose 
>> this), I would like to show information of the new scheduler, a 
>> scheduler monitor, and these fields are indispensable for me)
> 
> 
> If your task is about modules in Linux, then I don't see how that
> involves the scheduler at all?
> 
> On the other hand, if you want a scheduler monitor then I can't see
> why it would be appropriate to implement as a module (we have schedstats,
> which you can read from a userspace program or daemon).
> 
> Nick
> 

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
