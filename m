Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278433AbRJSPck>; Fri, 19 Oct 2001 11:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278432AbRJSPc3>; Fri, 19 Oct 2001 11:32:29 -0400
Received: from [208.132.17.2] ([208.132.17.2]:13828 "HELO aegis.indstorage.com")
	by vger.kernel.org with SMTP id <S278431AbRJSPcV>;
	Fri, 19 Oct 2001 11:32:21 -0400
From: n0ano@indstorage.com
Date: Fri, 19 Oct 2001 09:52:07 -0600
To: Ryan Sweet <rsweet@atos-group.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: random reboots of diskless nodes - 2.4.7 (fwd)
Message-ID: <20011019095207.F13141@tlaloc.indstorage.com>
In-Reply-To: <Pine.LNX.4.30.0110160228000.18043-100000@core-0>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.30.0110160228000.18043-100000@core-0>; from rsweet@atos-group.nl on Tue, Oct 16, 2001 at 02:28:46AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My first guess would be power.  You said you tested the power source.
Can you get ahold of a power line monitor with a strip chart recorder?
You might have a situation where the power is normally fine but for some
reason it could fluctuate at times and kick a machine into reset.
I assume you've eliminated the possibility of the janitor who unplugs
a machine to find an outlet for his floor polisher (don't laugh, it's
happened).

How's the temperature on the machines?  Even if it's OK it would be
good to get another strip chart recorder on it to make sure the temp
stays within bounds 24hrs/day.

Also, do you have a serial console attached to each machine?  This is
the only reliable way to make sure you have every console message that
came out right before the reboot.

On Tue, Oct 16, 2001 at 02:28:46AM +0200, Ryan Sweet wrote:
> 
> I've posted about this problem before, but in the meantime I've managed to
> test under several different configurations to help rule out some possible
> causes.
> 
> Short version: 2.4.7 on nfsroot diskless nodes randomly re-boots and I
> don't think it is a hardware problem or a problem with the server (which
> is stable).  Rather than "try this, try that..." I (and more importantly
> my boss) would really like to find (and then hopefully fix) the root cause
> of the problem.
> 
>
>...
>
> 	- upgraded (replaced) the power supply in all nodes
> 	- tested power source to computer room, moved to another computer
> room with better available power, etc...

-- 
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
n0ano@indstorage.com
Ph: 303/652-0870x117
