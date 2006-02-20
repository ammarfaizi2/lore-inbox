Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWBTNaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWBTNaI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWBTNaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:30:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53729 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030215AbWBTNaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:30:06 -0500
Date: Mon, 20 Feb 2006 14:30:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Matthias Hensler <matthias@wspse.de>,
       Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220133005.GD23277@atrey.karlin.mff.cuni.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060220093911.GB19293@kobayashi-maru.wspse.de> <1140429758.3429.1.camel@mindpipe> <200602202037.31707.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602202037.31707.nigel@suspend2.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi.
> 
> On Monday 20 February 2006 20:02, Lee Revell wrote:
> > On Mon, 2006-02-20 at 10:39 +0100, Matthias Hensler wrote:
> > > > It is slightly slower,
> > >
> > > Sorry, but that is just unacceptable.
> >
> > Um... suspend2 puts extra tests into really hot paths like fork(), which
> > is equally unacceptable to many people.
> 
> It doesn't.
> 
> Fork is only a 'really hot path' if you have a fork bomb running. The 
> scheduler is a really hot path (which Suspend2 patches don't touch, by the 
> way).

Heh, tell that to Andrew and people running configure scripts. With
attitude like this, do you wonder why you can't get a patch merged?

							Pavel
-- 
Thanks, Sharp!
