Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbUCLQNU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 11:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbUCLQNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 11:13:19 -0500
Received: from pop.gmx.de ([213.165.64.20]:1700 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262288AbUCLQMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 11:12:23 -0500
X-Authenticated: #1226656
Date: Fri, 12 Mar 2004 16:59:07 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 on Alpha uninterruptible sleep of processes
Message-Id: <20040312165907.626d4a08@hdg.gigerstyle.ch>
In-Reply-To: <20040312184115.B680@jurassic.park.msu.ru>
References: <20040312154613.7567adab@hdg.gigerstyle.ch>
	<20040312182754.A680@jurassic.park.msu.ru>
	<20040312184115.B680@jurassic.park.msu.ru>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

On Fri, 12 Mar 2004 18:41:15 +0300
Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:

> On Fri, Mar 12, 2004 at 06:27:54PM +0300, Ivan Kokshaysky wrote:
> > -	"	cmovgt	%0,%0,%1\n"
> > +	"	cmovgt	%0,0,%1\n"
> 
> Oops. This is wrong, please ignore.
> Will investigate further.

Too late. Already applied, compiled and booted. Read your message and
rebooted to 2.4:-)

Another question:

Why is there no option to compile a preemptive kernel? Not possible on
alpha or nobody interested to code or...?

Perhaps you can answer yet another question:

In 2.4.23 /prc/meminfo shows always 

Buffers:             0 kB

Is it normal on alpha? 2.6.4 showed a value > 0

Thank you!

Regards

Marc
