Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030886AbWLEUWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030886AbWLEUWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031303AbWLEUWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:22:12 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:53557 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030886AbWLEUWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:22:10 -0500
Date: Tue, 5 Dec 2006 21:09:52 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: Linus Torvalds <torvalds@osdl.org>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, art@usfltd.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ben Collins <ben.collins@ubuntu.com>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.19 git compile error - "current_is_keventd" [drivers/net/phy/libphy.ko]
 undefined 
In-Reply-To: <Pine.LNX.4.64N.0612051824310.7108@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.61.0612052108350.18570@yvahk01.tjqt.qr>
References: <200612050129.kB51TBaC027403@laptop13.inf.utfsm.cl>
 <Pine.LNX.4.64.0612041934270.3476@woody.osdl.org>
 <Pine.LNX.4.64N.0612051824310.7108@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > Also i686, sparc64. At drivers/net/phy/phy.c:590 is the lone reference to
>> > current_is_keventd in that directory.  Still present as of ff51a9...
>> 
>> Yeah, I'm waiting for this whole mess to be either explained or reverted. 
>> There are apparently bigegr issues with it than just the butt-ugly 
>> "current_is_keventd()" crud.
>
> I am very surprised indeed "the mess" has been applied at all in the 
>first place.  The conclusion of the discussion a while ago was to sort out 
>the issue within libphy.  The change should be reverted.

I am more surprised about that "the mess" has not been discovered so 
far. Does no one go test compile an allyesconfig/allmodconfig before 
actually releasing a kernel to the ftp?


	-`J'
-- 
