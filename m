Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265953AbUBCJHh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 04:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265954AbUBCJHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 04:07:36 -0500
Received: from 213-176-151-74.in.is ([213.176.151.74]:24211 "EHLO
	schpilkas.net") by vger.kernel.org with ESMTP id S265953AbUBCJHf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 04:07:35 -0500
Message-ID: <401F64D3.90501@hi.is>
Date: Tue, 03 Feb 2004 09:07:31 +0000
From: Gunnlaugur Thor Briem <gthb@hi.is>
User-Agent: Mozilla Thunderbird 0.5a (Windows/20040128)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ryan Verner <xfesty@computeraddictions.com.au>
CC: LinuxSA ML <linuxsa@linuxsa.org.au>, linux-kernel@vger.kernel.org
Subject: Re: Promise PDC20269 (Ultra133 TX2) + Software RAID
References: <6FF5C83C-55FA-11D8-AC00-000A95CEEE4E@computeraddictions.com.au> <E9A39380-560F-11D8-8E3C-000A95CEEE4E@computeraddictions.com.au>
In-Reply-To: <E9A39380-560F-11D8-8E3C-000A95CEEE4E@computeraddictions.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Verner wrote:

> On 03/02/2004, at 2:08 PM, Ryan Verner wrote:
>
>> And the machine is randomly locking up, and of course, on reboot, the 
>> raid array is rebuilt.  Ouch.  Any clues as to why?  I'm sure the 
>> hard drive hasn't failed as it's brand new; I suspect a chipset 
>> compatibility problem or something.
>
>
> Definitely seems to be this.  Swapped the drives back over to the 
> onboard-IDE chipset, which is much slower (raid rebuilds at only 
> 7MB/sec instead of 25), but certainly none of these problems.
>
> Known issue?


Yep: http://bugzilla.kernel.org/show_bug.cgi?id=1888

I'm getting this with the Promise 20376. Presumably not a hardware 
problem: I can't reproduce it under Windows XP with Promise's supplied 
Windows driver, and Jeff Garzik calls it a known bug -- "should have a 
fix soon".

Jeff, is it "known" in the sense that you know roughly what goes wrong, 
but just haven't gotten around to fixing it? I'd like to tinker and try 
to fix it, but am "unfamiliar around those parts".

    - Gulli

