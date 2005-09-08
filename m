Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbVIHAox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVIHAox (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 20:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVIHAox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 20:44:53 -0400
Received: from web50203.mail.yahoo.com ([206.190.38.44]:5271 "HELO
	web50203.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932484AbVIHAow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 20:44:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=t4wO4JNnoHCZAvgkc4C7ESZOdPrpwnIJUHsnJ3KYKmkgSN7G7kFB7mcKp8QuOowPEV90KHVqLTzG5EMW0D0CtML0BT7i6gSMY29gOB/2C+Q3VP1El+CEcWWI5ol2+trig/8QNueFoGCCJLMQVxYOztXuP8qg7/cBrMbWbeCtfqM=  ;
Message-ID: <20050908004442.83467.qmail@web50203.mail.yahoo.com>
Date: Wed, 7 Sep 2005 17:44:42 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: RFC: i386: kill !4KSTACKS
To: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <431F18A3.6050502@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Bill Davidsen <davidsen@tmr.com> wrote:

> Alex Davis wrote:
> >>Please don't tell me to "care for closed-source drivers". 
> > 
> > ndiswrapper is NOT closed source. And I'm not asking you to "care".
> > 
> > 
> >>I don't want the pain of debugging crashes on the machines which run unknown code
> >>in kernel space.
> > 
> > I'm not asking you to debug crashes. I'm simply requesting that the
> > kernel stack size situation remain as it is: with 8K as the default
> > and 4K configurable. 
> 
> I can be happy with 4K as the default, everything I use *except* 
> ndiswrapper seems to run fine (I don't currently need fancy filesystems) 
> but laptops seem to include a lot of unsupported hardware, which can't 
> be replaced due to resources (money, slots, batter life).
> -- 
I could live with any default, as long as it's configurable.
The intent here, however, is to take away the option. That's
what I have an issue with.

Is there any problem caused by letting stack size be
configurable to any (sane) arbitrary maximum value
(e.g. 32K)?


>     -bill davidsen (davidsen@tmr.com)
> "The secret to procrastination is to put things off until the
>   last possible moment - but no longer"  -me
> 


I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
