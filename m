Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVCCLpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVCCLpg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVCCLpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:45:19 -0500
Received: from cmu-24-35-112-99.mivlmd.cablespeed.com ([24.35.112.99]:55287
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261632AbVCCLku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 06:40:50 -0500
Date: Thu, 3 Mar 2005 06:40:40 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Russell Miller <rmiller@duskglow.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <200503022021.00878.rmiller@duskglow.com>
Message-ID: <Pine.LNX.4.61.0503030607370.3775@localhost.localdomain>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
 <422674A4.9080209@pobox.com> <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
 <200503022021.00878.rmiller@duskglow.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005, Russell Miller wrote:

> On Wednesday 02 March 2005 19:37, Linus Torvalds wrote:
>
>> That's the whole point here, at least to me. I want to have people test
>> things out, but it doesn't matter how many -rc kernels I'd do, it just
>> won't happen. It's not a "real release".
>>
>> In contrast, making it a real release, and making it clear that it's a
>> release in its own right, might actually get people to use it.

> I agree with the first part of your mail that I quoted above.  Indeed, the -rc
> releases are not a "real release", and therefore people aren't going to test
> it.

> What you are missing is that if you use the method you have proposed. odd
> numberered kernels will stop being a "real release" as well to a great deal
> of users.

>
> The problem as stated is that people are not downloading and testing the test
> releases.

Define people. Some won't download a thing, they will take whatever the 
distros feed them. Some will download and test the latest patchset 
frequently, especially if someone asks. Some are interested only in a 
particular subsystem or feature.

> Your solution to that problem is to make test releases look like real releases
> and maybe people will test them anyway.

I believe the solution is slowly working its way out.  Previously there 
were only two stark choices, either you could be stable, safe, and boring, 
or you could use the development series and things could break horribly. I 
believe having a place where things could be tried out, such as the -mm 
kernels, was a great idea.

IMHO the 2.5 development series was long enough to be painful almost to 
the point of being counterproductive.  I think part of the problem with 
development series in general is/was a lack of focus. If the announced 
goal of the 2.5 series had been confined to changing module loading and 
latency/scheduling issues at the beginning, it would have been a lot 
shorter, and better.

I would like to see an even/odd stable/development cycle where the 
development cycle is limited to two or three major ideas and APIs don't 
change in stable cycles. New features not likely to cause breakage or new 
driver support could be targeted for the -mm kernels.
