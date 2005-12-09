Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbVLIWxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVLIWxf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 17:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbVLIWxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 17:53:35 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7891 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932497AbVLIWxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 17:53:34 -0500
Date: Fri, 9 Dec 2005 23:53:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: spitz: Real time clock?
Message-ID: <20051209225312.GF4658@elf.ucw.cz>
References: <20051209212850.GE4658@elf.ucw.cz> <1134167947.8092.116.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1134167947.8092.116.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 09-12-05 22:39:06, Richard Purdie wrote:
> On Fri, 2005-12-09 at 22:28 +0100, Pavel Machek wrote:
> > Is there driver for real time clock for spitz? I seem to get default
> > time each time I boot. (And thats bad because means fsck "too much time
> > since last check, check forced).
> 
> There is but its already included with the kernels you have. It doesn't
> survive reboots and this is a limitation of the PXA processor. There's
> not a lot we can do about it I'm afraid.

Ouch, that's bad :-(. So PXA can't keep time properly... could we do
something like storing time on system shutdown and restoring it on
bootup? That way at least time will be monotonic... Ok, that's
userland problem.

Is there way to reboot without "really" rebooting? That would help at
least in my usage case. (Also reboot really does poweroff, not reboot,
but...)

								Pavel
-- 
Thanks, Sharp!
