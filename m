Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262926AbVDAWOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbVDAWOR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 17:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbVDAWMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 17:12:15 -0500
Received: from alog0074.analogic.com ([208.224.220.89]:24272 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262923AbVDAWJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 17:09:43 -0500
Date: Fri, 1 Apr 2005 17:08:23 -0500 (EST)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Steven Rostedt <rostedt@goodmis.org>
cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clean up kernel messages
In-Reply-To: <1112390785.578.5.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0504011703400.30945@chaos.analogic.com>
References: <20050401200851.GG15453@waste.org> <20050401122641.7c52eaab.akpm@osdl.org>
  <20050401204629.GJ15453@waste.org> <1112390323.578.1.camel@localhost.localdomain>
 <1112390785.578.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2005, Steven Rostedt wrote:

> On Fri, 2005-04-01 at 16:18 -0500, Steven Rostedt wrote:
>> On Fri, 2005-04-01 at 12:46 -0800, Matt Mackall wrote:
>>> On Fri, Apr 01, 2005 at 12:26:41PM -0800, Andrew Morton wrote:
>>>> Matt Mackall <mpm@selenic.com> wrote:
>>>>>
>>>>> This patch tidies up those annoying kernel messages. A typical kernel
>>>>>  boot now looks like this:
>>>>>
>>>>>  Loading Linux... Uncompressing kernel...
>>>>>  #
>>>>>
>>>>>  See? Much nicer. This patch saves about 375k on my laptop config and
>>>>>  nearly 100k on minimal configs.
>>>>>
>>>>
>>>> heh.  Please take a look at
>>>> http://www.uwsg.iu.edu/hypermail/linux/kernel/0004.2/0709.html, see if
>>>> Graham did anything which you missed.
>>>
>>> He's got a bunch of stuff that's not strictly related in there and
>>> stuff I've already dealt with (vprintk and the like) and stuff that's
>>> still forthcoming (panic tweaks, etc.). I also leave in all the APIs
>>> like dmesg, they just no longer do anything.
>>
>> Looking at your other patches, I'm assuming that this is just another
>> April 1st type of patch. Is it?
>
> Arg! I'm too tired.  I took another look at your other patches and they
> look more legit now. On first glance, I thought you were just bluntly
> removing BUGs and error messages to quiet things down. But after taking
> another look, I see that they are more than that.  I wouldn't of thought
> about that on any other day.
>
> Sorry,
>
>
> -- Steve

Methinks he still is kidding. We have "quiet" as a parameter now
to quiet things down on a boot. Now if he would just get rid
of the annoying...
>>>>>  Loading Linux... Uncompressing kernel...
He'd have something.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
