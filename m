Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbUCLUyY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbUCLUxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:53:40 -0500
Received: from imap.gmx.net ([213.165.64.20]:18575 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262515AbUCLUwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:52:17 -0500
X-Authenticated: #1226656
Date: Fri, 12 Mar 2004 21:52:15 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 on Alpha uninterruptible sleep of processes
Message-Id: <20040312215215.1041889a@hdg.gigerstyle.ch>
In-Reply-To: <20040312224649.A750@den.park.msu.ru>
References: <20040312154613.7567adab@hdg.gigerstyle.ch>
	<20040312182754.A680@jurassic.park.msu.ru>
	<20040312184115.B680@jurassic.park.msu.ru>
	<20040312165907.626d4a08@hdg.gigerstyle.ch>
	<20040312224649.A750@den.park.msu.ru>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004 22:46:49 +0300
Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:

> On Fri, Mar 12, 2004 at 04:59:07PM +0100, Marc Giger wrote:
> > Too late. Already applied, compiled and booted. Read your message
> > and rebooted to 2.4:-)
> 
> Well, you can try the appended patch to see whether it's
> a semaphore problem or not.
> BTW, what alpha system do you have?

Right now I'm recompiling the kernel. So you say this patch isn't a fix
but a test? This time I have additionally "semaphore debugging" enabled,
perhaps it's useful for you.
I will inform you as soon as I get new infos.

> 
> > Why is there no option to compile a preemptive kernel? Not possible
> > on alpha or nobody interested to code or...?
> 
> The answer is here:
> http://bugzilla.kernel.org/show_bug.cgi?id=397

That's no answer, that's a statement:-) Do know the exactly reason why
it should be a bad idea? Is it mostly a bad idea on alpha?

> 
> > In 2.4.23 /prc/meminfo shows always 
> > 
> > Buffers:             0 kB
> > 
> > Is it normal on alpha? 2.6.4 showed a value > 0
> 
> No idea. In 2.4.25 I have a non-zero value as well:
> Buffers:          7288 kB

Interestingly. I'm still waiting to the acl patch for 2.4.25. I think I
will rediff it myself.

Thank you for your work!

Regards

Marc
