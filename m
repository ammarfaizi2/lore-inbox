Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVGEQPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVGEQPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 12:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVGEQOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 12:14:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37056 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261910AbVGEP6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 11:58:16 -0400
Date: Tue, 5 Jul 2005 08:58:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: Thomas Backlund <tmb@mandriva.org>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Andy <genanr@emsphone.com>
Subject: Re: WARNING : kernel 2.6.11.7 (others) kills megaraid 4e/Si dead
Message-ID: <20050705155808.GI9153@shell0.pdx.osdl.net>
References: <20050503151532.GA1316@thumper2> <20050503190005.GS23013@shell0.pdx.osdl.net> <42CA9E93.1050802@mandriva.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CA9E93.1050802@mandriva.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Backlund (tmb@mandriva.org) wrote:
> Chris Wright wrote:
> >* Andy (genanr@emsphone.com) wrote:
> >
> >>cross posted due to the severity of this issue.
> >>
> >>I have killed two Dell 1850 (x86_64) with megaraid 4e/SI servers using
> >>kernel 2.6.11.7.  When the system boots, it looks like it does not see the
> >>megaraid controller (because it never prints anything about it) and hangs
> >>when it tries to mount root.  When rebooted, the system says no firmware
> >>present for embedded raid controller.  I then try to flash it, the flash
> >>program says the firmware is corrupt and flashes the controller.  However,
> >>upon reboot I still get the no firmware present, thus the machine can no
> >>longer boot off the raid.
> >
> >
> >Not good.  There were no megaraid changes in the -stable series.  What's
> >the last kernel.org kernel that worked for you?
> 
> Any news on this matter?
> I hvr a PE1850 waiting for kernel upgrade, but I'm afraid to do so now...
> 
> I can't break my box with tests since it's in active use...
> For now I'm running a 2.6.8.1 based kernel on the box...

Last known good one (that Andy tested) was 2.6.10.  His was the only
report I've seen, and I haven't found any more details on it.
