Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWCYPSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWCYPSW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 10:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWCYPSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 10:18:22 -0500
Received: from 4-16-ftth.onsnet.nu ([84.35.16.4]:7177 "EHLO beacon.dhs.org")
	by vger.kernel.org with ESMTP id S1751410AbWCYPSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 10:18:21 -0500
Date: Sat, 25 Mar 2006 16:18:18 +0100
From: Jonathan Black <vampjon@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: uptime increases during suspend
Message-ID: <20060325151818.GA10939@beacon.dhs.org>
References: <20060325150238.GA9023@beacon.dhs.org> <200603251610.16566.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603251610.16566.rjw@sisk.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 04:10:16PM +0100, Rafael J. Wysocki wrote:
> On Saturday 25 March 2006 16:02, Jonathan Black wrote:
> > I'd like to enquire about the following behaviour:
> > 
> > $ uptime && sudo hibernate && uptime
> >  14:18:51 up 1 day, 4:12,  2 users,  load average: 0.58, 3.30, 2.42
> >  14:23:46 up 1 day, 4:17,  2 users,  load average: 20.34, 7.74, 3.91
> > 
> > I.e. the system was suspended to disk for 5 minutes, but the value
> > reported by 'uptime' has increased by as much, as if it had actually
> > continued running during that time.
> > 
> > I'm using Linux 2.6.16 with the latest version of the Suspend 2 patch
> > (2.2.1), but Nigel its maintainer says that this isn't actually related
> > to his suspend code, essentially the same would happen using the swsusp
> > code currently in the kernel, and therefore we need to ask the kernel
> > time code people about this issue.
> 
> Is your system an i386 or x86_64?

It is an i386.
 
-- 
jonathaN
