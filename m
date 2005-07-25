Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVGYTs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVGYTs0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVGYTsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:48:20 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:13316 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261370AbVGYTsN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:48:13 -0400
Message-ID: <42E542F4.8020808@tmr.com>
Date: Mon, 25 Jul 2005 15:52:20 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ciprian <cipicip@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6 speed
References: <20050724191211.48495.qmail@web53608.mail.yahoo.com>	 <f89941150507241403234949be@mail.gmail.com> <1122245346.27064.4.camel@mindpipe>
In-Reply-To: <1122245346.27064.4.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sun, 2005-07-24 at 17:03 -0400, Florin Malita wrote:
> 
>>the x86 timer interrupt
>>frequency has increased from 100Hz to 1KHz (it's about to be lowered
>>to 250Hz)
> 
> 
> This is by no means a done deal.  So far no one has posted ANY evidence
> that dropping HZ to 250 helps (except one result on a atypically large
> system), and there's plenty of evidence that it doesn't.

If nothing else it does seem to make media applications unhappy under 
some loads.

I personally think 1k should stay the default and let people with 
special needs use the other. Nice to select at boot time, people who 
need accuracy above all could use 866 (or whatever tick rate near that 
was the lowest error).
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
