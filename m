Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUHTJmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUHTJmY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 05:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUHTJmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 05:42:23 -0400
Received: from linux2.isphuset.no ([213.236.237.186]:12179 "EHLO
	gtw.mailserveren.com") by vger.kernel.org with ESMTP
	id S261169AbUHTJmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 05:42:22 -0400
Subject: Re: SMP cpu deep sleep
From: Hans Kristian Rosbach <hk@isphuset.no>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200408200458.38591.jeffpc@optonline.net>
References: <1092989207.18275.14.camel@linux.local>
	 <200408200458.38591.jeffpc@optonline.net>
Content-Type: text/plain
Organization: ISPHuset Nordic AS
Message-Id: <1092994933.18271.21.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 11:42:13 +0200
Content-Transfer-Encoding: 7bit
X-Declude-Sender: hk@isphuset.no [195.159.151.115]
X-Note: This E-mail was scanned by Declude JunkMail (www.declude.com) for spam.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 10:58, Jeff Sipek wrote:
> On Friday 20 August 2004 04:06, Hans Kristian Rosbach wrote:
> > While reading through hotplug and speedstep patches
> > I came to think of a feature I think might be useful.
> >
> > In an SMP system there are several cpus, this generates
> > extra heat and power consuption even on idle load.
> > Is there a way to put all cpus but cpu1 into a kind of
> > deep sleep? Cpu1 would have to do all work (including irqs)
> > of course.
> 
> With Rusty's Hotplug CPU, a userspace script should be able to do this
by 
> cat'ing 1 or 0 into the appropriate sysfs file.

Nice, this can be done on non-hotplug motherboards as well?
How much time does it take to take the cpu up again?

It would need to be awakened whenever the activity increases
again, and that delay should not be too long.

Also, what effect does this have on cpu power consumtion
and thermal output? Does it lower it below normal idle?

-HK

