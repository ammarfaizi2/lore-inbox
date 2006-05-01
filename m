Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWEASdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWEASdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 14:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWEASdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 14:33:24 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:518 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751024AbWEASdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 14:33:24 -0400
Message-ID: <44565443.3020000@shadowen.org>
Date: Mon, 01 May 2006 19:32:35 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev@ozlabs.org, lkml <linux-kernel@vger.kernel.org>,
       ak@suse.de
Subject: Re: 2.6.17-rc2-mm1
References: <4450F5AD.9030200@google.com>	 <20060428012022.7b73c77b.akpm@osdl.org> <44561A1E.7000103@google.com>	 <20060501100731.051f4eff.akpm@osdl.org>	 <1146503960.317.1.camel@dyn9047017100.beaverton.ibm.com>	 <445644B7.7060807@google.com> <1146506105.317.4.camel@dyn9047017100.beaverton.ibm.com> <44564BEC.1040803@google.com>
In-Reply-To: <44564BEC.1040803@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
> Badari Pulavarty wrote:
> 
>> On Mon, 2006-05-01 at 10:26 -0700, Martin Bligh wrote:
>>
>>>> I ran mtest01 multiple times with various options on my 4-way AMD64
>>>> box.
>>>> So far couldn't reproduce the problem (2.6.17-rc3-mm1).
>>>>
>>>> Are there any special config or test options you are testing with ?
>>>
>>>
>>> Config is here:
>>>
>>> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/amd64
>>>
>>> It's just doing "runalltests", I think.
>>
>>
>>
>> FWIW, I tried your config file on my 4-way AMD64 (melody) box and ran
>> latest "mtest01" fine.
>>
>> I am now trying runalltests. I guess, its time to bi-sect :(
> 
> 
> There was a panic on PPC64 during LTP too, but it seems to have gone
> away with rc3-mm1. Not sure if it was really fixed, or just intermittent.
> 
> http://test.kernel.org/abat/29675/debug/console.log

I think its more intermittant than gone.  I've got another machine which
runs the same tests, and she threw a very similar failure on 2.6.18-rc3-mm1.

-apw
