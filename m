Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279915AbRJ3Lkw>; Tue, 30 Oct 2001 06:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279930AbRJ3Lkn>; Tue, 30 Oct 2001 06:40:43 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:27375
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279925AbRJ3Lk1>; Tue, 30 Oct 2001 06:40:27 -0500
Date: Tue, 30 Oct 2001 03:40:58 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
Message-ID: <20011030034058.B21884@mikef-linux.matchmail.com>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0110292113490.1338-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0110292113490.1338-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 09:38:07PM -0800, Davide Libenzi wrote:
> 2) My Linux Scheduler Stuff Page:
> 	http://www.xmailserver.org/linux-patches/lnxsched.html
> 

Anyone know if this is preempt safe?  It's using processor specific lists,
and might not be.

I tried integrating it into my latest kernel, and had some troubles with:

2.4.13freeswan-1.91+ac5+preempt+netdev_random+vm_freeswap

I'll admit, it was pretty ambitious trying to get it to work with -ac and
preempt at the same time....

When I get some time over the next few days, I'll give it a try with fewer
patches to reduce the interactions...

Oh, btw, the above kernel patch sets have compiled together, now it's just a
matter of rebooting and see if anything breaks. :)

Night guys,

Mike
