Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbUKDUPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbUKDUPB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUKDUM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:12:29 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:31108 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262393AbUKDUI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:08:29 -0500
Message-ID: <418A8CD2.3050107@tmr.com>
Date: Thu, 04 Nov 2004 15:10:58 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mitchell Blank Jr <mitch@sfgoth.com>
CC: Russell Miller <rmiller@duskglow.com>, linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411031945.20894.rmiller@duskglow.com><200411031945.20894.rmiller@duskglow.com> <20041104015959.GA54786@gaz.sfgoth.com>
In-Reply-To: <20041104015959.GA54786@gaz.sfgoth.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitchell Blank Jr wrote:
> Russell Miller wrote:
> 
>>Couldn't ring 1 be used to make 
>>sure an errant driver doesn't drop the kernel, at least on x86 machines?
> 
> 
> Not really -- drivers could still do things like mis-program their associated
> hardware making it do DMA writes all over kernel memory (just as one example)
> 
> Basically it'd add a lot of complexity (and inefficiency) without adding
> much real safety.

It would be nice on x86 to run ring 1 for kernel debugging, getting 
faults at appropriate points. Sorry, I'm an old MULTICS guy, wish 
Honeywell would OS it.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
