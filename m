Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUEQUu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUEQUu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 16:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUEQUu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 16:50:27 -0400
Received: from mail.tmr.com ([216.238.38.203]:49668 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261724AbUEQUuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 16:50:10 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.6-mm2
Date: Mon, 17 May 2004 16:52:20 -0400
Organization: TMR Associates, Inc
Message-ID: <c8b8bk$l5m$1@gatekeeper.tmr.com>
References: <20040513032736.40651f8e.akpm@osdl.org> <20040513114520.A8442@infradead.org> <20040513035134.2e9013ea.akpm@osdl.org> <20040513121206.A8620@infradead.org> <20040513042540.073478ea.akpm@osdl.org> <20040513131842.GC22202@fs.tum.de> <1084455572.2583.395.camel@watt.suse.com> <20040513140939.GF22202@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1084826805 21686 192.168.12.100 (17 May 2004 20:46:45 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20040513140939.GF22202@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, May 13, 2004 at 09:39:32AM -0400, Chris Mason wrote:
> 
>>On Thu, 2004-05-13 at 09:18, Adrian Bunk wrote:
>>
>>>On Thu, May 13, 2004 at 04:25:40AM -0700, Andrew Morton wrote:
>>>
>>>>...
>>>>Wim explained that any application changes now won't be widely deployed for
>>>>another year.  During that period the ability to run existing Oracle setups
>>>>requires that hugepage allocation be available to unprivileged
>>>>applications.
>>>>...
>>>>It means that if people install a kernel.org machine on their database
>>>>server, the database *just won't work*.  This is not good for those users,
>>>>for the kernel developers or for Linux's reputation in general.
>>>>...
>>>
>>>That sounds silly when talking about Oracle.
>>>
>>>Oracle says:
>>>  Which Kernels are supported?
>>>
>>>  Oracle does not support modified or recompiled kernels. Recompiled 
>>>  kernels are not supported with or without source modifications.
>>>
>>>
>>>I doubt there are many "existing Oracle setups" that will risk to lose 
>>>all Oracle support by installing a different kernel.
>>>
>>
>>No, I doubt so as well.  Then again, why force them into a vendor
>>kernel?  At the very least, it would be nice to be able to benchmark
>>vanilla against the vendors.
>>...
> 
> 
> I think I recall times when code contributions to the kernel were only 
> judged by their quality and not by the needs of some non-free apps or 
> what vendors did.
> 
> Either my memory is wrong, or these times are gone now...

I don't see that "quality" and "what vendors did" are mutually 
exclusive. What I don't see is why you think that having a capability 
control this is a bad thing. It would seem to be exactly the type of 
thing capabilities address, giving a selected bit of permission to a 
trusted application.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
