Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWFHUue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWFHUue (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWFHUue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:50:34 -0400
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:55228 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S965004AbWFHUud
	(ORCPT <rfc822;linux-kerneL@vger.kernel.org>);
	Thu, 8 Jun 2006 16:50:33 -0400
Message-ID: <44888D8F.2000404@compro.net>
Date: Thu, 08 Jun 2006 16:50:23 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: tglx@linutronix.de
Cc: linux-kerneL@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RT exec for exercising RT kernel capabilities
References: <448876B9.9060906@compro.net> <1149795975.5257.83.camel@localhost.localdomain>
In-Reply-To: <1149795975.5257.83.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> Mark,
> 
> On Thu, 2006-06-08 at 15:12 -0400, Mark Hounschell wrote:
>> With the ongoing work being done to rt kernel enhancements by Ingo and friends,
>> I would like to offer the use of a user land test (rt-exec). The rt-exec tests
>> well the deterministic real-time capabilities of a computer. Maybe it could
>> useful in some way to the effort or to anyone interested in making this type of
>> determination about their kernel/computer.
>>
>> A README describing the rt-exec can be found at
>> ftp://ftp.compro.net/public/rt-exec/README
>>
>> It can be downloaded from
>> ftp://ftp.compro.net/public/rt-exec/rt-exec-1.0.0.tar.bz2
>>
>> Complaints, comments, or suggestions welcome.
> 
> Nice tool. 
> 
> Some remarks. You can build high resolution timer support without the
> extra lib package from the HRT sourceforge site. You need a recent glibc
> and  some quirks in the source. See the cyclictest program I'm using.
> http://www.tglx.de/projects/misc/cyclictest/cyclictest-v0.8.tar.bz2
> 

I didn't realize that. Right you are.

> It would also be cute to add tests for the PI support for
> pthread_mutexes.
> 
> 	tglx

I'm not sure what one needs to do in user land to actually test that but I'll
investigate.

Thanks
Mark

