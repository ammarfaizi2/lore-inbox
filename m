Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbVHJTgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbVHJTgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 15:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVHJTgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 15:36:40 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:16397 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030216AbVHJTgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 15:36:39 -0400
Message-ID: <42FA5848.809@tmr.com>
Date: Wed, 10 Aug 2005 15:40:56 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove support for gcc < 3.2
References: <20050731222606.GL3608@stusta.de> <20050731.153631.70217457.davem@davemloft.net>
In-Reply-To: <20050731.153631.70217457.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Adrian Bunk <bunk@stusta.de>
> Date: Mon, 1 Aug 2005 00:26:07 +0200
> 
> 
>>- my impression is that the older compilers are only rarely
>>  used, so miscompilations of a driver with an old gcc might
>>  not be detected for a longer amount of time
> 
> 
> Many people still use 2.95 because it's still the fastest
> way to get a kernel build done and that's important for
> many people.
> 
> And with 4.0 being a scary regression in the compile time
> performance area compared to 3.4, this becomes even more
> important to keep around.

I don't mean to offend anyone, but it seems that the gcc project, at 
least WRT x86, has lost its way a bit. The compiler is getting slower, 
and the generated code is not getting correspondingly faster. Or 
smaller. I'm not sure about more correct...

Keeping 2.95 might not be a bad idea.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
