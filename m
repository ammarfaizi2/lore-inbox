Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbVLEXDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbVLEXDd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbVLEXDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:03:33 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:27118 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751489AbVLEXDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:03:33 -0500
Message-ID: <4394C745.2020802@tmr.com>
Date: Mon, 05 Dec 2005 18:03:33 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Collins <bcollins@ubuntu.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de> <1133620264.2171.14.camel@localhost.localdomain>
In-Reply-To: <1133620264.2171.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:

> What you're suggesting sounds just like going back to the old style of
> development where 2.<even>.x is stable, and 2.<odd>.x is development.
> You might as well just suggest that after 2.6.16, we fork to 2.7.0, and
> 2.6.17+ will be stable increments like we always used to do.

I'll let him speak to what he intended, but my idea of stable is to keep 
the features of 2.6.0 in 2.6.N for any value of N. Adding new stuff 
rapidly hasn't been nearly the problem people feared, but that's largely 
due to the efforts of akpm to act as throttle, and somehow get more 
people to try his versions and knock the corners off the new code before 
it goes mainline.

I do think the old model was better; by holding down major changes for 
six months or so after a new even release came out, people had a chance 
to polich the stable release, and developers had time to recharge their 
batteries so to speak, and to sit and think about what they wanted to 
do, without feeling the pressure to write code and submit it right away. 
Knowing that there's no place to send code for six months is a great aid 
to generating GOOD code.

The other advantage of a development tree was that features could be 
added and removed without the argument that it would break this or that. 
It was development, no one was supposed to use it for production, no one 
could claim that there was even an implied promise of things working or 
even existing. ipchains could have gone out of 2.6 with no more fuss 
than xiafs departing. The people who really want it stay with the old 
kernel.

To a large extent -mm has become the development kernel, and as neat as 
that is, a development model which depends on a small number of 
dedicated and talented people to make it work is fragile.

Just my thoughts, I think we had it right before, I think it's less 
inherently stable now.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
