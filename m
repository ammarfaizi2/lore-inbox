Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUEJTs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUEJTs7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 15:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUEJTs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 15:48:58 -0400
Received: from mail.tmr.com ([216.238.38.203]:44306 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261439AbUEJTsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 15:48:04 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Date: Mon, 10 May 2004 15:49:58 -0400
Organization: TMR Associates, Inc
Message-ID: <c7om3o$akd$1@gatekeeper.tmr.com>
References: <200405061518.i46FIAY2016476@turing-police.cc.vt.edu> <1083858033.3844.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1084218296 10893 192.168.12.100 (10 May 2004 19:44:56 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <1083858033.3844.6.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>It's probably a Bad Idea to push this to Linus before the vendors that have
>>significant market-impact issues (again - anybody other than NVidia here?)
>>have gotten their stuff cleaned up...
> 
> 
> Ok I don't want to start a flamewar but... Do we want to hold linux back
> until all binary only module vendors have caught up ??

My questions is, hold it back from what? Having the 4k option is fine, 
it's just eliminating the current default which I think is undesirable. 
I tried 4k stack, I couldn't measure any improvement in anything (as in 
no visible speedup or saving in memory). For an embedded system, where 
space is tight and the code paths well known, sure, but I haven't been 
able to find or generate any objective improvement, other than some 
posts saying smaller is always better. Nothing slows a system down like 
a crash, even if it isn't followed by a restore from backup.

Feel free to point me at some results showing major improvement from 4k 
stacks, I'm open to data.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
