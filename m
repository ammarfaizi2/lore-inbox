Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbTL3EqN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbTL3EqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:46:13 -0500
Received: from mail006.syd.optusnet.com.au ([211.29.132.63]:5815 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264441AbTL3EqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:46:09 -0500
Message-Id: <6.0.1.1.2.20031230082335.022d26b0@mail.optusnet.com.au>
X-Nil: 
Date: Tue, 30 Dec 2003 15:46:00 +1100
To: sflory@rackable.com
From: Leon Toh <tltoh@attglobal.net>
Subject: Re: Adaptec/DPT I2O Option Omitted From Linux 2.6.0 Kernel
  Configuration Tool
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3FF071B1.6010202@rackable.com>
References: <6.0.1.1.2.20031227093632.0229afe8@wheresmymailserver.com>
 <3FEF721D.7020405@rackable.com>
 <6.0.1.1.2.20031229201602.021feec0@mail.optusnet.com.au>
 <3FF071B1.6010202@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:25 AM 30/12/2003, Samuel Flory wrote:
>Leon Toh wrote:
>>  At 11:15 AM 29/12/2003, Samuel Flory wrote:
>>
>>How broken is the driver than ? What are the implication's if the driver 
>>is left as it is for now ?
>
>   It doesn't compile at all.  If it's not fixed your only other option is 
> the generic i2o driver.

Using generic I2O driver is definitely an option for now especially for 
those who wants to immediately jump onto the 2.6 bandwagon. However the 
down site with this is we can't use an of the available Management 
utilities for the card.

Now which is better is not for me to comment on. I shall leave it to others 
to decide for their own as to which is suitable for their environment.

>>>It doesn't even compile in 2.4 for a number of archs like amd64.
>>
>>This driver was initially intended only for i386 arch. Furthermore at 
>>that time when this driver was finalized amd64 wasn't available.
>
>   My point is that the driver isn't very portable.

Oh.... I see.

>>>   A while back  a bunch of people (including myself) raised the concern 
>>> through various channels with adaptec.  In theroy someone at adaptec is 
>>> working on it, but there was not an ETA.
>>
>>If you have happen to have a list of issues with this current driver 
>>together with supporting information to back up those claims, please 
>>forward them to so that I can escalate those issues into Adaptec via the 
>>appropriate communication channel. I happen to have a number of contact's 
>>within Adaptec myself.
>>By the way I've hack the script file to make Adaptec I2O Option to appear 
>>in Linux 2.6.0 Kernel Configuration tool. Currently I'm now in the middle 
>>of recompiling the kernel using current dpti2o driver support but haven't 
>>got to the dpti2o driver yet.
>
>   You might want to hold off on doing a lot of work for a bit.  I think 
> there was a beta driver that was being passed around.

I can now officially report that the dpt_i2o driver embedded in kernel 
2.6.0 is broken. I'll highlight and bring this up through my contacts back 
at Adaptec. And hopefully we than can get some kind of official resolution 
soon.

