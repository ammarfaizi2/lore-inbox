Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbTL2SZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 13:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTL2SZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 13:25:56 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:4637 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S263625AbTL2SZy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 13:25:54 -0500
Message-ID: <3FF071B1.6010202@rackable.com>
Date: Mon, 29 Dec 2003 10:25:53 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Leon Toh <tltoh@attglobal.net>
CC: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec/DPT I2O Option Omitted From Linux 2.6.0 Kernel   Configuration
 Tool
References: <6.0.1.1.2.20031227093632.0229afe8@wheresmymailserver.com> <3FEF721D.7020405@rackable.com> <6.0.1.1.2.20031229201602.021feec0@mail.optusnet.com.au>
In-Reply-To: <6.0.1.1.2.20031229201602.021feec0@mail.optusnet.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Dec 2003 18:25:53.0629 (UTC) FILETIME=[318D08D0:01C3CE39]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leon Toh wrote:
>  At 11:15 AM 29/12/2003, Samuel Flory wrote:
> 
> 
> How broken is the driver than ? What are the implication's if the driver 
> is left as it is for now ?
> 

   It doesn't compile at all.  If it's not fixed your only other option 
is the generic i2o driver.

>> It doesn't even compile in 2.4 for a number of archs like amd64.
> 
> 
> This driver was initially intended only for i386 arch. Furthermore at 
> that time when this driver was finalized amd64 wasn't available.

   My point is that the driver isn't very portable.

> 
>>   A while back  a bunch of people (including myself) raised the 
>> concern through various channels with adaptec.  In theroy someone at 
>> adaptec is working on it, but there was not an ETA.
> 
> 
> If you have happen to have a list of issues with this current driver 
> together with supporting information to back up those claims, please 
> forward them to so that I can escalate those issues into Adaptec via the 
> appropriate communication channel. I happen to have a number of 
> contact's within Adaptec myself.
> 
> By the way I've hack the script file to make Adaptec I2O Option to 
> appear in Linux 2.6.0 Kernel Configuration tool. Currently I'm now in 
> the middle of recompiling the kernel using current dpti2o driver support 
> but haven't got to the dpti2o driver yet.

   You might want to hold off on doing a lot of work for a bit.  I think 
there was a beta driver that was being passed around.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

