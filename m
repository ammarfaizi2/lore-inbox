Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313124AbSDIKtY>; Tue, 9 Apr 2002 06:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313126AbSDIKtX>; Tue, 9 Apr 2002 06:49:23 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:47623 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S313124AbSDIKtX>;
	Tue, 9 Apr 2002 06:49:23 -0400
Date: Tue, 9 Apr 2002 06:49:20 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: Corey Minyard <minyard@acm.org>
cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Further WatchDog Updates
In-Reply-To: <3CB26D1F.50500@acm.org>
Message-ID: <Pine.LNX.4.33.0204090645240.17511-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Apr 2002, Corey Minyard wrote:

> Rob Radez wrote:
>
> >Ok, new version of watchdog updates is up at
> >http://osinvestor.com/bigwatchdog-4.diff
> >
> Could the timeout be in milliseconds?  A lot of watchdogs have lower
> resolution, and I have written applications that require a lower
> resolution than a second.  Milliseconds is small enough to not cause
> problems, but big enough to give a good range of time.

Not in 2.4, and I wonder if that might be too fine-grained for some
drivers which have an upper limit of 255 seconds.  I also wonder if it
would be considered ugly to extend WDIOC_SETOPTIONS to have a
WDIOS_TIMEINMILLI bit.

Regards,
Rob Radez

