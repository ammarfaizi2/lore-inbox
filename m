Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161102AbWBTULm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbWBTULm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWBTULm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:11:42 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:34451 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161102AbWBTULl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:11:41 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 21:11:52 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, dtor_core@ameritech.net,
       Mark Lord <lkml@rtr.ca>, Nigel Cunningham <nigel@suspend2.net>,
       Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060220145405.GD1673@atrey.karlin.mff.cuni.cz> <1140464704.6722.8.camel@mindpipe>
In-Reply-To: <1140464704.6722.8.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602202111.53804.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 20:45, Lee Revell wrote:
> On Mon, 2006-02-20 at 15:54 +0100, Pavel Machek wrote:
> > > I know I am bad for not reporting that earlier but swsusp was
> > working
> > > OK for me till about 3 month ago when I started getting "soft lockup
> > > detected on CPU0" with no useable backtrace 3 times out of 4. I
> > > somehow suspect that having automounted nfs helps it to fail
> > > somehow...
> > 
> > Disable soft lockup watchdog :-). 
> 
> You do know that message is harmless and doesn't actually do anything
> right?  It's just warning you that the kernel allowed something to hog
> the CPU without rescheduling for a LONG time.

This particular one is almost certainly a false-positive.  Still it doesn't
mean we shouldn't try to get rid of it.

Greetings,
Rafael
