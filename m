Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTLASGe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 13:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbTLASGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 13:06:34 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:32239 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S263823AbTLASGc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 13:06:32 -0500
Message-ID: <3FCB8312.3050703@rackable.com>
Date: Mon, 01 Dec 2003 10:06:10 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata in 2.4.24?
References: <Pine.LNX.4.44.0312010836130.13692-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0312010836130.13692-100000@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Dec 2003 18:06:30.0087 (UTC) FILETIME=[D8759D70:01C3B835]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> On Sat, 29 Nov 2003, Marcelo Tosatti wrote:
> 
> 
>>
>>On Sat, 29 Nov 2003, Samuel Flory wrote:
>>
>>
>>>   Are you considering including libata support for 2.4.24?  From my 
>>>testing with a number of different embedded sata chipsets (mostly ICH, 
>>>SI, and Promise) it appears very stable.  I'm not seeing any data 
>>>corruption or lockups when running Cerberus with 2.4.23-rc5 + libata 
>>>patch.  The only troubles I've had were with initialization of embedded 
>>>promise sata controllers. (I still need to test with Jeff's latest fixes 
>>>for this.)
>>
>>I'm happy to include it in 2.4 when Jeff thinks its stable enough for a 
>>stable series. ;)
> 
> 
> I thought a bit more about this issue and I have a different opinion now.
> 
> 2.6 is getting more and more stable and already includes libata --- users 
> who need it should use 2.6.

   While I agree that 2.6 is looking better every day.  I've been 
running my desktop on it for sometime.  I'm not sure agree we should be 
forcing  people to use 2.6 simply to be able to read their hard drive.


   It's getting harder to find a newly released motherboard without 
onboard sata.  Not having  libata support means that anyone running 2.4 
unpatched will be unable to use such systems.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

