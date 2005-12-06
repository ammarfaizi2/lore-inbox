Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbVLMTtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbVLMTtV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 14:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVLMTtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 14:49:21 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:60493 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932580AbVLMTtU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 14:49:20 -0500
Message-ID: <4395FFA8.1030701@tmr.com>
Date: Tue, 06 Dec 2005 16:16:24 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <20051204170049.GA4179@unthought.net> <20051204223931.GA8914@kroah.com> <20051205151753.GB4179@unthought.net> <20051206174424.GC3084@kroah.com>
In-Reply-To: <20051206174424.GC3084@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Dec 05, 2005 at 04:17:53PM +0100, Jakob Oestergaard wrote:
> 
>>On Sun, Dec 04, 2005 at 02:39:31PM -0800, Greg KH wrote:
>>
>>>On Sun, Dec 04, 2005 at 06:00:49PM +0100, Jakob Oestergaard wrote:
>>>
>>>>In the real world, however, admins currently need to pick out specific
>>>>versions of the kernel for specific workloads (try running a large
>>>>fileserver on anything but 2.6.11.11 for example - any earlier or later
>>>>kernel will barf reliably.
>>>
>>>Have you filed a but at bugzilla.kernel.org about this?  If not, how do
>>>you expect it to get fixed?
>>
>>I don't expect to get it fixed. It's futile. It can get fixed in one
>>version and broken two days later, and it seems the attitude is that
>>that is just fine.
> 
> 
> Huh?  That is just not true at all.  Please give us a bit more credit
> than that.
> 
> 
>>After a long long back-and-forth, 2.6.11 was fixed to the point where it
>>could reliably serve files (at least on uniprocessor configurations -
>>and in my setup I don't see problems on NUMA either, but as far as I
>>know that's just me being lucky).
>>
>>Right after that, someone thought it was a great idea to pry out the PCI
>>subsystem and shovel in something else.  Find, that's great for a
>>development kernel, but for a kernel that's supposed to be stable it's
>>just not something you can realistically do and expect things to work
>>afterwards.  And things broke - try mounting 10-20 XFS filesystems
>>simultaneously on 2.6.14.  Boom - PCI errors.
> 
> 
> What PCI errors are you speaking of?  We did that PCI work to fix a lot
> of other machines that were having problems.  And yes, this did break
> some working machines, and we are very sorry about this.  But in the
> future, changes to this area will not cause this to happen due to the
> changes made.

I don't think it's reasonable to get overly upset about *accidental* 
breakages. People make mistakes, otherwise you don't get progress.

Note that I haven't changed my mind about deliberately removing features 
for which there is no practical alternative.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

