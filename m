Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262843AbVHED4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbVHED4U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 23:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbVHED4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 23:56:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46730 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262843AbVHED4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 23:56:18 -0400
Date: Thu, 4 Aug 2005 20:54:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, frank.peters@comcast.net, vojtech@suse.cz
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
Message-Id: <20050804205441.0a90f637.akpm@osdl.org>
In-Reply-To: <200508042220.27480.dtor_core@ameritech.net>
References: <20050624113404.198d254c.frank.peters@comcast.net>
	<20050804162812.29a3f2b2.akpm@osdl.org>
	<20050804230947.36c24139.frank.peters@comcast.net>
	<200508042220.27480.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> On Thursday 04 August 2005 22:09, Frank Peters wrote:
> > I'll use bugzilla to report any problems with 2.6.13-rc6.
> > 
> > But since I've included the "usb-handoff" option at boot time,
> > all my problems (except the long dhcp/eth0 connect time) are
> > now gone.  Right now I'm using 2.6.13-rc5.
> > 
> > I understand the need to pinpoint the kernel version, but the
> > "usb-handoff" option has even corrected some problems that
> > started in linux-2.4.x.  For example, my PS/2 mouse now functions
> > normally.  It has not worked with this motherboard since some time
> > in the 2.4.x series.  Also, my keyboard lights were malfunctioning
> > under X-Window since early 2.6.x, but with the "usb-handoff" option
> > they are working normally now.
> > 
> > If I had known about the "usb-handoff" option earlier, this thread 
> > probalby would not even have come into existence.  As long as "usb-handoff"
> > keeps working, I would consider the issue closed.
> > 
> 
> We really really need to make usb-handoff default. Even if there known boxes
> that don't like it the blacklist would be rather short, much shorter than
> a whitelist.

Sounds like a fun thing for post-2.6.13.

What does usb-handoff do, precisely?
