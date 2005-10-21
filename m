Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbVJUQYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbVJUQYw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 12:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbVJUQYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 12:24:52 -0400
Received: from tardis.csc.ncsu.edu ([152.14.51.184]:1669 "EHLO
	tardis.csc.ncsu.edu") by vger.kernel.org with ESMTP id S965021AbVJUQYv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 12:24:51 -0400
Message-ID: <43591652.6080505@csc.ncsu.edu>
Date: Fri, 21 Oct 2005 12:24:50 -0400
From: "Vincent W. Freeh" <vin@csc.ncsu.edu>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Understanding Linux addr space, malloc, and heap
References: <4358F0E3.6050405@csc.ncsu.edu>	<1129903396.2786.19.camel@laptopd505.fenrus.org>	<4359051C.2070401@csc.ncsu.edu>	<1129908179.2786.23.camel@laptopd505.fenrus.org>	<43590B23.2090101@csc.ncsu.edu> <je64rqlued.fsf@sykes.suse.de>
In-Reply-To: <je64rqlued.fsf@sykes.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess I live in a different world.  I do lots of things I'm not 
"supposed" to do.

Moreover, it is very sensible and usable to mprotect malloc pages.  I 
have implemented simple sandboxing this way.  For my dissertation I 
implemented a DSM by mprotect'g malloc'd memory.  This system worked for 
 >6 on several version of Linux and SunOS.  I actually have a better 
track record for this technique than for some things that are within the 
specifications.

Andreas Schwab wrote:
> "Vincent W. Freeh" <vin@csc.ncsu.edu> writes:
> 
> 
>>The point of the code is to show that one can protect malloc code.
> 
> 
> You "can" do many things.  But that does not mean that you always get any
> sensible behaviour.
> 
> Andreas.
> 
