Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262586AbTCYWo0>; Tue, 25 Mar 2003 17:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262653AbTCYWo0>; Tue, 25 Mar 2003 17:44:26 -0500
Received: from fionet.com ([217.172.181.68]:55424 "EHLO service")
	by vger.kernel.org with ESMTP id <S262586AbTCYWoZ>;
	Tue, 25 Mar 2003 17:44:25 -0500
Subject: Re: System time warping around real time problem - please help
From: Fionn Behrens <fionn@unix-ag.org>
To: linux-kernel@vger.kernel.org
Cc: george anzinger <george@mvista.com>
In-Reply-To: <3E80D4CC.4000202@mvista.com>
References: <1048609931.1601.49.camel@rtfm>
	 <Pine.LNX.4.53.0303251152080.29361@chaos> <1048627013.2348.39.camel@rtfm>
	 <3E80D4CC.4000202@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: United Fools of Bugaloo
Message-Id: <1048632934.1355.12.camel@rtfm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Mar 2003 23:55:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 2003-03-25 at 23:14, george anzinger wrote:
> Fionn Behrens wrote:

> > Summary:
> >        - No apparent hardware issue.
> >        - System runs stable as long as you dont for (;;) gettimeofday();
> >        - notsc being evaluated. I will get back to you later.
> >          Does not resolve the odd test software crash, though.

> This all sounds very much like the TSCs are drifting WRT each other. 
> Is it possible that you have some power management code (or hardware) 
> that is slowing one cpu and not the other?

Well, I still don't really know what TSCs actually are (or what TSC
stands for).

The only suspect in that case would be the amd76x_pm.o kernel module
which I am admittedly using. It saves about 90Watts of power when the
machine is idle...

I'll check what happens when the system boots without amd76x_pm.
Will report back tomorrow.

Thanks to all for keeping the suggestions going!

Regards,
	F. Behrens
