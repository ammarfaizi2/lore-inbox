Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265907AbTLaAd4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 19:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265916AbTLaAd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 19:33:56 -0500
Received: from [24.35.117.106] ([24.35.117.106]:32384 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265907AbTLaAdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 19:33:54 -0500
Date: Tue, 30 Dec 2003 19:33:06 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Roger Luethi <rl@hellgate.ch>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Andy Isaacson <adi@hexapodia.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
In-Reply-To: <20031230222403.GA8412@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.58.0312301921510.3193@localhost.localdomain>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
 <20031230012551.GA6226@k3.hellgate.ch> <Pine.LNX.4.58.0312292031450.6227@localhost.localdomain>
 <20031230132145.B32120@hexapodia.org> <20031230194051.GD22443@holomorphy.com>
 <20031230222403.GA8412@k3.hellgate.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Dec 2003, Roger Luethi wrote:

> I'm not sure how to classify the bk export. It may be the qsbench type
> or something new. If it is the former, then 2.5.39 performs a lot worse
> than 2.5.38 (and 2.6.0, for that matter).
> 
> It would also be interesting to see the numbers for 2.5.27: That's when
> physical scanning was introduced -- IMO that performance should be the
> minimal goal for 2.6.


It seems to me that the bk export test is a measure of memory pressure and 
io performance.  On my good system with plenty of resources I see very 
little difference between 2.4 and 2.6.  On my laptop with a slower 
processor, less memory, and a slower hard drive I get dramatic 
differences, depending on workload.  

I'm not sure what to think of the bk export test to tell you the truth.  
i've noticed for some time that 2.6 seemed to perform worse than 2.4.  It 
was a simple "real world" test that I could use to gather real performance 
data.  

If I am understanding you, you would like data on 2.5.27, 2.5.38, and 
2.5.39.  I'll do it if it will help something.  I'll look at it in the 
next couple of days.
