Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317579AbSGOSci>; Mon, 15 Jul 2002 14:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317580AbSGOSch>; Mon, 15 Jul 2002 14:32:37 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:29237 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317579AbSGOScf>; Mon, 15 Jul 2002 14:32:35 -0400
Date: Mon, 15 Jul 2002 14:35:25 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: szepe@pinerecords.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: [sparc32] reserve nocache based on RAM size
Message-ID: <20020715143525.B27814@devserv.devel.redhat.com>
References: <200207151333.g6FDXF001511@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207151333.g6FDXF001511@devserv.devel.redhat.com>; from zaitcev@redhat.com on Mon, Jul 15, 2002 at 09:33:15AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Tomas Szepe <szepe@pinerecords.com>
> Newsgroups: rhat.general.linux-kernel
> Date: Sun, 14 Jul 2002 17:38:05 +0200

> Since there's no official sparc32 maintainer, I'm sending this patch
> directly to you. It has now been tested in various configurations
> (released in the default Aurora 0.3 kernel) and appears to be causing
> no undesired side effects.

Would you mind to send me 3-4 /proc/meminfos and /proc/cpuinfos
from your Aurora boxes with this patch, preferably after some uptime?

Also, did you think about a deadlock-free runtime resizing of the
nocache memory? I did not even bother with boot-time resizing,
because run-time resizing sounds doable and certainly nobler.

-- Pete
