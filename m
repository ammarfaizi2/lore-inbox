Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbUJYVZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUJYVZw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUJYVV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:21:58 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:58513 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261991AbUJYVRl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 17:17:41 -0400
Message-ID: <417D6CD9.2090702@tmr.com>
Date: Mon, 25 Oct 2004 17:15:05 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Willy Tarreau <willy@w.ods.org>, espenfjo@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: My thoughts on the "new development model"
References: <20041022225703.GJ19761@alpha.home.local><20041022225703.GJ19761@alpha.home.local> <20041023000956.GI17038@holomorphy.com>
In-Reply-To: <20041023000956.GI17038@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> We aren't just stabilizing 2.6. We're moving it forward. Part of moving
> forward is preventing backportmania depravity. Backporting is the root
> of all evil.

Damn! And I thought it was closed source software...

Let me just put forward my single criterion for stable vs. not, and that 
is that if I am running a stable kernel and upgrade to a new version to 
gain a feature or security fix my existing programs don't break. That 
means to me that if Reiser4 goes in, Reiser3 doesn't exit. If something 
more please to theoretical cryptographers than cryptoloop comes out, 
cryptoloop doesn't go away. Etc, these are just examples.

It doesn't bother me (and I believe most users of kernel.org releases) 
when a new features comes in, until it breaks something even though I 
don't use the new feature. It's when there is an incompatible change, 
like the rewrite of modules, that I think a development kernel is needed.

I don't see the need for a development kernel, and it is desirable to be 
able to run kernel.org kernels. I would like to hope that other people 
agree that stable need not mean static, as long as changes don't 
deliberately break existing apps.

I note that BSD has another serious fork and that people are actually 
moving to Linux after installing SP2 and finding it disfunctional with 
non-MS software. Nice to see people looking at Linux as the stable 
choice. I would like to hope that continues.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
