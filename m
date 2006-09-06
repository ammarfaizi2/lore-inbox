Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbWIFAdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWIFAdq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 20:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWIFAdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 20:33:46 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:46521 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751520AbWIFAdo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 20:33:44 -0400
Subject: Re: [BUG] no sound on ppc mac mini
From: john stultz <johnstul@us.ibm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1153.153.96.175.159.1154423993.squirrel@secure.sipsolutions.net>
References: <1152821370.6845.9.camel@localhost>
	 <1152831309.23037.31.camel@localhost.localdomain>
	 <1f1b08da0607312337l34eabc56jdee7b056acd9a71a@mail.gmail.com>
	 <1153.153.96.175.159.1154423993.squirrel@secure.sipsolutions.net>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 17:33:22 -0700
Message-Id: <1157502802.28296.58.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 11:19 +0200, Johannes Berg wrote:
> john stultz wrote:
> >> Is this really a current git or an -rc1 snapshot ? The crashes on boot
> >> should have been fixed ... unless there is another problem on the mac
> >> mini. Can you try having them as modules instead ?
> >
> > I know you mentioned there was a fix for this somewhere, but as
> > motivation to get it flowing to mainline, here's what I get w/ the
> > current -rc3-git and the sound bits compiled as modules:
> 
> The fixes are sitting in the alsa mercurial repository waiting to go
> upstream...
> 
> Not My Fault (TM) ;)

Just wanted to report that it seems w/ 2.6.18-rc6 the fix has made it
in, and my system now reports that there is a SoundByLayout alsa device.


However...  ;)

It seems the new device doesn't have any volume control. I know the old
toonie driver used some form of softvol support, but "it just worked",
where as now I have no control over my system's audio volume.

While not the most terrible of regressions, its a bit irritating (waking
to loud mail notifications, specifically :). Is this something that I
have to wait for an alsa userland update to fix, or is the new kernel
driver just not fully functional yet?

thanks
-john


