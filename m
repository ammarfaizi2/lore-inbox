Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWFYCdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWFYCdO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 22:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWFYCdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 22:33:14 -0400
Received: from hegel.brightdsl.net ([66.219.128.245]:29414 "EHLO
	hegel.brightdsl.net") by vger.kernel.org with ESMTP
	id S1751292AbWFYCdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 22:33:14 -0400
Subject: Re: 2.6.17-...: looong writeouts
From: Donald Parsons <dparsons@brightdsl.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Kernel <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
In-Reply-To: <1151194288.4469.4.camel@danny.parsons.org>
References: <1151166629.4409.18.camel@danny.parsons.org>
	 <1151167852.3181.65.camel@laptopd505.fenrus.org>
	 <20060624173658.GB7565@martell.zuzino.mipt.ru>
	 <1151194288.4469.4.camel@danny.parsons.org>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 22:33:04 -0400
Message-Id: <1151202784.4469.8.camel@danny.parsons.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 20:11 -0400, Donald Parsons wrote:
> On Sat, 2006-06-24 at 21:36 +0400, Alexey Dobriyan wrote:
> > On Sat, Jun 24, 2006 at 06:50:52PM +0200, Arjan van de Ven wrote:
> > > just a random question to rule things out: can you check if laptop mode
> > > is enabled? (see the /proc/sys/vm/laptop_mode file). Laptop mode will
> > > have the effect of grouping writes together, so if that got enabled
> > > accidentally for some reason, that could explain the behavior you are
> > > seeing. (and it would narrow down the "what broke" search problem to
> > > something that is a lot easier to work on)
> > 
> > Mine is not laptop and I've never enabled it.
> > 
> 
> Mine is a laptop T43 running FC3 and the mode is not enabled:
> 
> # cat /proc/sys/vm/laptop_mode
> 0
> 
> I have rebooted to 2.6.17 and the problem is there too.  It
> happened when I tried to paste the above path from the mail.
> 
> Don

Another data point (now 2.6.17):

I started up Streamtuner to see if it was affected.  It is not.
While I was trying to get a window to respond for many seconds
I noticed sound continued on with no interference at all.

Don

