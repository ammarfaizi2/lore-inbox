Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263450AbUDMQ4T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 12:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbUDMQ4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 12:56:19 -0400
Received: from mail.tmr.com ([216.238.38.203]:64272 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S263450AbUDMQ4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 12:56:17 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] eliminate nswap and cnswap
Date: Tue, 13 Apr 2004 12:56:55 -0400
Organization: TMR Associates, Inc
Message-ID: <c5h5v4$frc$1@gatekeeper.tmr.com>
References: <1081827102.1593.227.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1081875236 16236 192.168.12.100 (13 Apr 2004 16:53:56 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <1081827102.1593.227.camel@cube>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
>>The nswap and cnswap variables counters have never
>>been incremented as Linux doesn't do task swapping.
> 
> 
> I'm pretty sure they were used for paging activity.
> We don't eliminate support for "swap space", do we?
> 
> Somebody must have broken nswap and cnswap while
> hacking on some vm code. I hate to see the variables
> get completely ripped out of the kernel instead of
> getting fixed.

Since Linux doesn't swap, "fixed" would mean returning zero for these 
values. I don't thing even BSD swaps anymore, does it? In any case, 
Linux never did.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
