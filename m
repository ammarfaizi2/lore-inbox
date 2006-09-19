Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752049AbWISUgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbWISUgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWISUgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:36:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30359 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751278AbWISUgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:36:22 -0400
Date: Tue, 19 Sep 2006 13:36:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-rc7-mm1
Message-Id: <20060919133606.f0c92e66.akpm@osdl.org>
In-Reply-To: <200609192225.21801.rjw@sisk.pl>
References: <20060919012848.4482666d.akpm@osdl.org>
	<200609192225.21801.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006 22:25:21 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > - It took maybe ten hours solid work to get this dogpile vaguely
> >   compiling and limping to a login prompt on x86, x86_64 and powerpc. 
> >   I guess it's worth briefly testing if you're keen.
> 
> It's not that bad, but unfortunately the networking doesn't work on my system
> (HPC nx6325 + SUSE 10.1 w/ updates, 64-bit).  Apparently, the interfaces don't
> get configured (both tg3 and bcm43xx are affected).

Is there anything interesting in the dmesg output?

Perhaps an `strace -f ifup' or whatever would tell us what's failing.
