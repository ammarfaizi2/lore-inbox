Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVHOGQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVHOGQx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 02:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVHOGQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 02:16:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:47027 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932092AbVHOGQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 02:16:52 -0400
Date: Mon, 15 Aug 2005 08:16:46 +0200
From: Olaf Hering <olh@suse.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       ak@suse.de, Jeff Moyer <jmoyer@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, john.ronciak@intel.com,
       rostedt@goodmis.org
Subject: Re: [PATCH 0/8] netpoll: various bugfixes
Message-ID: <20050815061646.GA20762@suse.de>
References: <1.502409567@selenic.com> <20050812172151.GA11104@suse.de> <20050812192152.GJ12284@waste.org> <20050812193109.GA15434@suse.de> <20050814210010.GU12284@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050814210010.GU12284@waste.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Aug 14, Matt Mackall wrote:

> On Fri, Aug 12, 2005 at 09:31:09PM +0200, Olaf Hering wrote:
> >  On Fri, Aug 12, Matt Mackall wrote:
> > 
> > > Does the task dump work without patch 5/8 (add retry timeout)? I'll
> > > try testing it here.
> > 
> > I spoke to soon, worked once, after reboot not anymore. Will try to play
> > with individual patches. Does the task dump work for you, at least?
> 
> Works flawlessly on e1000. Works on tg3 with serial console, but seems
> to cause trouble without. Haven't had time to dig deeper yet.

Can you send me your .config off-list?
I'm using
ftp.suse.com/pub/projects/kernel/kotd/i386/HEAD/kernel-smp.i586.rpm

will check if that nmi_watchdog thing shows anything.
