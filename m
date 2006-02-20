Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWBTNXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWBTNXf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWBTNXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:23:35 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61152 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030207AbWBTNXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:23:34 -0500
Date: Mon, 20 Feb 2006 14:23:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Matthias Hensler <matthias@wspse.de>,
       Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220132333.GB23277@atrey.karlin.mff.cuni.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060220103329.GE21817@kobayashi-maru.wspse.de> <1140434146.3429.17.camel@mindpipe> <200602202124.30560.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602202124.30560.nigel@suspend2.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi.
> 
> On Monday 20 February 2006 21:15, Lee Revell wrote:
> > On Mon, 2006-02-20 at 11:33 +0100, Matthias Hensler wrote:
> > > That is all I
> > > complain about, it means throwing away everything that is working, or
> > > easy to get it working, and delaying working hibernate support for
> > > another time.
> >
> > But we have not established that the current implementation does not
> > work!  That's a pretty strong assertion to make with zero evidence.
> 
> ...and that requires defining 'works'.
> 
> If we define it as "writes an image of some part of ram to a swap partition 
> that can be and does normally get restored on the next boot", then yes, we 
> have a working version in the existing vanilla kernel. If however you start 
> talking about multiple swap partitions or swap files or ordinary files, about 
> reliability or the ability to tune it to fit your system and preferences, 
> about the responsiveness of the system post resume or the security of the 
> image (IIRC, encryption support has just been removed from swsusp), about the 
> ability to get help when you run into trouble or documentation, swsusp 
> becomes less of a candidate for 'works'.

...so yes, it works, and the rest of features can be implemented in
userspace. Feel free to help with documentation or userspace parts.
								Pavel
-- 
Thanks, Sharp!
