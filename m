Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932895AbWF2LaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932895AbWF2LaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932896AbWF2LaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:30:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:51665 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932895AbWF2LaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:30:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=pJjPlQ9XlTGH1cgT8GuLCAh4fTQLBKpq8qbt1jNDRsyT2B7g+VzminRSLrqYMRCab6mYg88YS9IKi9wZin8mRdtm/Bg2C8Ao1vMcviyJN0GEWk3g8nYKA9YJkTbBI5tG2xg06iyLo4h+V/e0/qATElfbxRR7M0L0tmtpH4Ut0jw=
Date: Thu, 29 Jun 2006 13:30:27 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Steven Rostedt <rostedt@goodmis.org>
cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Milan Svoboda <msvoboda@ra.rockwell.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Linux-2.6.17-rt3 on arm ixdp465
In-Reply-To: <Pine.LNX.4.58.0606290517420.25758@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.64.0606291327130.10401@localhost.localdomain>
References: <OF333B3CA3.DCE515CC-ONC125719C.00265C3B-C125719C.0026A1E2@ra.rockwell.com>
 <Pine.LNX.4.64.0606291051400.10401@localhost.localdomain>
 <Pine.LNX.4.58.0606290517420.25758@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Jun 2006, Steven Rostedt wrote:

>
> On Thu, 29 Jun 2006, Esben Nielsen wrote:
>
>> On Thu, 29 Jun 2006, Milan Svoboda wrote:
>>>
>>> I use "old" eepro100 network device driver...
>>>
>
> Why?  Do you have problems with the e100 driver?  Just to let you know
> that the eepro100 is scheduled for removal:
>
> http://marc.theaimsgroup.com/?l=git-commits-head&m=114288220325419&w=2
>
>
>>
>> "old"?
>
>>
>>> Thank you for your answer, I look at it too...
>>>
>>
>> eepro100 seems to be SMP safe, so it shouldn't be there.
>> Have anyone else used eepro100 with preempt-realtime?
>
> I use to use it a while back ago, when e100 would screw up my network
> card. But that has been fixed so I don't use eepro100 and I would
> recommend anyone else to switch to e100.

And I use that one on my labtop with preempt-realtime with no problems.
There is an error in arch/arm/configs/ixp4xx_defconfig then: It ought to 
default to e100 instead of eepro100.

Esben

>
> -- Steve
>
