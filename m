Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262830AbVHEDJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbVHEDJk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 23:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVHEDJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 23:09:40 -0400
Received: from sccrmhc11.comcast.net ([63.240.76.21]:40185 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262830AbVHEDJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 23:09:34 -0400
Date: Thu, 4 Aug 2005 23:09:47 -0400
From: Frank Peters <frank.peters@comcast.net>
To: Andrew Morton <akpm@osdl.org>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
Message-Id: <20050804230947.36c24139.frank.peters@comcast.net>
In-Reply-To: <20050804162812.29a3f2b2.akpm@osdl.org>
References: <20050624113404.198d254c.frank.peters@comcast.net>
	<42BC306A.1030904@m1k.net>
	<20050624125957.238204a4.frank.peters@comcast.net>
	<42BC3EFE.5090302@m1k.net>
	<20050728222838.64517cc9.akpm@osdl.org>
	<20050729143320.4d30b10a.frank.peters@comcast.net>
	<20050804162812.29a3f2b2.akpm@osdl.org>
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll use bugzilla to report any problems with 2.6.13-rc6.

But since I've included the "usb-handoff" option at boot time,
all my problems (except the long dhcp/eth0 connect time) are
now gone.  Right now I'm using 2.6.13-rc5.

I understand the need to pinpoint the kernel version, but the
"usb-handoff" option has even corrected some problems that
started in linux-2.4.x.  For example, my PS/2 mouse now functions
normally.  It has not worked with this motherboard since some time
in the 2.4.x series.  Also, my keyboard lights were malfunctioning
under X-Window since early 2.6.x, but with the "usb-handoff" option
they are working normally now.

If I had known about the "usb-handoff" option earlier, this thread 
probalby would not even have come into existence.  As long as "usb-handoff"
keeps working, I would consider the issue closed.

Frank Peters


On Thu, 4 Aug 2005 16:28:12 -0700
Andrew Morton <akpm@osdl.org> wrote:

> 
> Frank, if any problems remain in 2.6.13-rc6 could you please raise new
> bugzilla.kernel.org records for them?  That way poor old me will be able to
> keep tabs on progress more easily.
> 
> (It's especially important to identify the most recent kernel version which
> didn't have a particular bug)
> 
> Thanks.
