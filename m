Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTFCU5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 16:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbTFCU5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 16:57:38 -0400
Received: from gw.netgem.com ([195.68.2.34]:41227 "EHLO gw.dev.netgem.com")
	by vger.kernel.org with ESMTP id S261294AbTFCU5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 16:57:31 -0400
Subject: Re: [BUG] ieee1394 sbp2 driver is broken for kernel >= 2.4.21-rc2
From: Jocelyn Mayer <jma@netgem.com>
To: Ben Collins <bcollins@debian.org>
Cc: Georg Nikodym <georgn@somanetworks.com>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030603192656.GE10102@phunnypharm.org>
References: <1054582582.4967.48.camel@jma1.dev.netgem.com>
	 <20030602163443.2bd531fb.georgn@somanetworks.com>
	 <1054588832.4967.77.camel@jma1.dev.netgem.com>
	 <20030603113636.GX10102@phunnypharm.org>
	 <1054663917.4967.99.camel@jma1.dev.netgem.com>
	 <20030603185421.GB10102@phunnypharm.org>
	 <1054671619.4951.139.camel@jma1.dev.netgem.com>
	 <20030603192656.GE10102@phunnypharm.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054674756.4951.187.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 03 Jun 2003 23:12:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-03 at 21:26, Ben Collins wrote:
> > - Please take a look at this session:
> > First, I reboot the Ibook:
> 
> You didn't read a damn thing.
> 
> Look, things changed around rc2. They changed because the old way of
> sbp2 that allowed sbp2 devices to be detected on module load caused
> oopses. It was very buggy and very bad. Even the old logic didn't work
> when you loaded sbp2 and _then_ plugged the device in.
> 
> I HAVE NOT once said anything about fucking /sbin/hotplug, nor the
> kernel's idea of CONFIG_HOTPLUG. I just said "hotplug", which is a
> generic term for being able to insert devices after the bus has already
> been scanned for them. So stop bring up either of the two previous
> notions that you may have.
> 
> Your behavior is expected, even if it changed and is inconvient to you.
> This time, _really_ read the linux1394-devel mailing list archives. And
> just get the damn script and use it. If you had ever really used sbp2
> previously and wanted to plug/unplug devices without unloading/reloading
> sbp2.o, you would already realize that the script was a must for 2.4.
> Then again, if you had been unloading/loading sbp2 you would have also
> hit the oopses I mentioned before.

Yes, I didn't read the mailing list,
only the SBP2 page.
I did, now, read the thread "initial bus scan gone" and YOU refer this
as a known bug, not as a normal feature.

I may be lucky, but I never had a Ooops.
You're right on one point: I ALWAYS unload/reload the sbp2 driver.
I do this on a PC about once a day and had an 30 days uptime.
I don't do it on the Mac because it's a laptop and I usually
keep the disk mounted until I stop it.
I know that echo to /proc/scsi/scsi is needed for device REMOVAL,
but, as I said before, I NEVER needed it for device's insertion.

I use sbp2 devices every day for monthes, but never tried to know how it
worked since it was working well for me, so please don't tell me I never
used it...

Sorry to have talked to you, making you so angry,
won't disturb you again.

Time to close this thread, now.

-- 
Jocelyn Mayer <jma@netgem.com>

