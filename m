Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWGCWrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWGCWrx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWGCWrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:47:53 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55190 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751200AbWGCWrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:47:52 -0400
Date: Tue, 4 Jul 2006 08:47:40 +1000
From: Nathan Scott <nathans@sgi.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Huge problem with XFS/iCH7R
Message-ID: <20060704084740.A1462688@wobbly.melbourne.sgi.com>
References: <20060702195145.GA4098@localhost.halifax.rwth-aachen.de> <20060703163216.B1474487@wobbly.melbourne.sgi.com> <44A98A0B.8080203@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <44A98A0B.8080203@tmr.com>; from davidsen@tmr.com on Mon, Jul 03, 2006 at 05:20:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 05:20:11PM -0400, Bill Davidsen wrote:
> >> My system crashes every few days, at the moment daily. The message shown
> >> is (the drive changes about every time, I do not see a pattern here):
> >> ---
> >> ata4: handling error/timeout
> >> ata4: port reset, p_is 0 is 0 pis 0 cmd c017 tf 7f ss 0 se 0
> >> ata4: status=0x50 { DriveReady SeekComplete }
> >> sdd: Current: sense key=0x0
> >> 	ASC=0x0 ASCQ=0x0
> >> Info fid=0x0
> > 
> > FWIW, the above look like hardware/driver problems.
> 
> If the problem doesn't occur before 2.6.16, that makes a hardware 
> problem less likely.  It's not impossible that some buggy feature is now 
> used, but lower probability than the kernel change being the culprit. 

*nod*.

> The bug fix you mention may solve the whole thing, or make it easier to 

I'm certain it wont; that was an XFS problem, and I can see no way it
could cause device/driver issues also.

> General comment: if a kernel version made my system crash once a day I 
> sure wouldn't be using it.

Heh, yes - by definition.

> New features are neat, but I wouldn't put up 
> with that if it made my cat pee holy water.

Not sure what new features you're talking about here?  Nor how your
cat fits into all this.. ;)

cheers.

-- 
Nathan
