Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbVCIV3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbVCIV3Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVCIVZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:25:16 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:19851 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262446AbVCIUeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:34:14 -0500
Message-ID: <422F5F0B.3080407@tmr.com>
Date: Wed, 09 Mar 2005 15:39:39 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vintya@excite.com
CC: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
Subject: Re: Random number generator in Linux kernel
References: <20050307231853.9F661B6E7@xprdmailfe20.nwk.excite.com>
In-Reply-To: <20050307231853.9F661B6E7@xprdmailfe20.nwk.excite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vineet Joglekar wrote:
> Hi all,
> 
> Can someone please tell me where can I find and which
> random/pseudo-random number generator can I use inside the linux
> kernel? (2.4.28)
> 
> I found out 1 function get_random_bytes() in
> linux/drivers/char/random.c but thats not what I want.
> 
> I want a function where I will be supplying a seed to that function
> as an input, and will get a random number back. If same seed is used,
> same number should be generated again.

Without knowing what you're doing I can't say if it justifies having all 
that extra code around, but the stuff from the library, like srand48, 
will do this. You can add the code to your module.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
