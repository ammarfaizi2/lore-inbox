Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVEXQbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVEXQbt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVEXQbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:31:40 -0400
Received: from mail.timesys.com ([65.117.135.102]:47689 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262145AbVEXQ3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:29:22 -0400
Message-ID: <429355FD.9030803@timesys.com>
Date: Tue, 24 May 2005 12:27:41 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dwalker@mvista.com
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       john cooper <john.cooper@timesys.com>
Subject: Re: RT patch acceptance
References: <1116890066.13086.61.camel@dhcp153.mvista.com>	 <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu>	 <4292DFC3.3060108@yahoo.com.au>  <20050524081517.GA22205@elte.hu> <1116949498.28841.19.camel@dhcp153.mvista.com>
In-Reply-To: <1116949498.28841.19.camel@dhcp153.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 May 2005 16:22:58.0703 (UTC) FILETIME=[D940A1F0:01C5607C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> The main reason for my email is that I know Andrew and Linus don't want
> interrupts in threads. Without that there is no PREEMPT_RT . If you want
> to narrow the discussion to just interrupts in threads that's fine with
> me, cause that's what I'm concerned about.

Again, what are the technical arguments against scheduled
interrupts causing these folks concern?  All in all it is
just a different locking paradigm where interrupt-initiated
scheduling is moved closer to the metal.

-john

-- 
john.cooper@timesys.com
