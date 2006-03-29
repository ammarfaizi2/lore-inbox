Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWC3U0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWC3U0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWC3U0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:26:37 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:790 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750818AbWC3U0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:26:37 -0500
Message-ID: <442AC258.6010804@tmr.com>
Date: Wed, 29 Mar 2006 12:22:32 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Greg Lee <glee@swspec.com>, linux-kernel@vger.kernel.org
Subject: Re: HZ != 1000 causes problem with serial device shown by git-bisect
References: <0e6601c651f8$9d253b40$a100a8c0@casabyte.com> <20060328081324.GA15222@flint.arm.linux.org.uk>
In-Reply-To: <20060328081324.GA15222@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Mar 27, 2006 at 06:46:02PM -0500, Greg Lee wrote:
>> I have also tried a number of other kernels and the problem exists all
>> the way to 2.6.15.6 but is fixed in 2.6.16, so I am going to git-bisect
>> 2.6.15.6 to 2.6.16, but I thought I would get this message out now in
>> case someone has an inkling of what the problem is.
> 
> Saying that the problem is between 2.6.15.6 and 2.6.16 is rather
> meaningless because you're effectively omitting _all_ the development
> work between 2.6.15 to 2.6.16, and that's likely where the problem
> lies.  Hence, you're omitting all the 2.6.16-rc kernels from your
> testing.

But won't a git bisect cover all the bases even so? Aren't rc versions 
just selected git pulls?
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

