Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSGKVFN>; Thu, 11 Jul 2002 17:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317909AbSGKVFM>; Thu, 11 Jul 2002 17:05:12 -0400
Received: from freesurfmta01.sunrise.ch ([194.230.0.16]:60140 "EHLO
	freesurfmail.sunrise.ch") by vger.kernel.org with ESMTP
	id <S311749AbSGKVFI>; Thu, 11 Jul 2002 17:05:08 -0400
Message-ID: <3D298E8200068368@freesurfmta01.sunrise.ch> (added by
	    postmaster@freesurf.ch)
From: "Per Jessen" <per@computer.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 11 Jul 2002 23:28:31 +0200
Reply-To: "Per Jessen" <per@computer.org>
X-Mailer: PMMail 98 Professional (2.01.1600) For Windows 95 (4.0.1212)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: Periodic clock tick considered harmful (was: Re: HZ, preferably as small as possible)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2002 09:44:35 -0700, dank@kegel.com wrote:

>Mark Mielke <mark@mark.mielke.cc> wrote:
>> 
>> On Wed, Jul 10, 2002 at 04:09:21PM -0600, Cort Dougan wrote:
>> > Yes, please do make it a config option.  10x interrupt overhead makes me
>> > worry.  It lets users tailor the kernel to their expected load.
>> 
>> All this talk is getting to me.
>> 
>> I thought we recently (1 month ago? 2 months ago?) concluded that
>> increases in interrupt frequency only affects performance by a very
>> small amount, but generates an increase in responsiveness. The only
>> real argument against that I have seen, is the 'power conservation'
>> argument. The idea was, that the scheduler itself did not execute
>> on most interrupts. The clock is updated, and that is about all.
>
>On UML and mainframe Linux, *any* periodic clock tick 
>is heavy overhead when you have a large number of 
>(mostly idle) instances of Linux running, isn't it?   

Without knowing what UML is in this context, but assuming that mainframe
means IBM s390 mainframes, I can confirm that any periodic clock tick
is heavy overhead. With or without (mostly) idle instances. 

/Per



regards,
Per Jessen, Zurich
http://www.enidan.com - home of the J1 serial console.

Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."


