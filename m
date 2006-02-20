Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWBTOyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWBTOyH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWBTOyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:54:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:36586 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030267AbWBTOyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:54:05 -0500
Date: Mon, 20 Feb 2006 15:54:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: dtor_core@ameritech.net
Cc: Mark Lord <lkml@rtr.ca>, Nigel Cunningham <nigel@suspend2.net>,
       Lee Revell <rlrevell@joe-job.com>, Matthias Hensler <matthias@wspse.de>,
       Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220145405.GD1673@atrey.karlin.mff.cuni.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060220103329.GE21817@kobayashi-maru.wspse.de> <1140434146.3429.17.camel@mindpipe> <200602202124.30560.nigel@suspend2.net> <20060220132333.GB23277@atrey.karlin.mff.cuni.cz> <43F9D0DC.5080302@rtr.ca> <20060220143041.GB1673@atrey.karlin.mff.cuni.cz> <d120d5000602200641i136d9778uf9049355c39451a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000602200641i136d9778uf9049355c39451a9@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2/20/06, Pavel Machek <pavel@ucw.cz> wrote:
> > > Pavel Machek wrote:
> > > ..
> > > >...so yes, it works...
> > >
> > > About 50% of the time for me.  The rest of the time I just
> > > see a complete fresh boot from scratch.  What a pain!
> >
> > Ouch... strange. Does it work reliably from init=/bin/bash boot? Do
> > you see final steps of writing on the screen? Can you submit it to
> > bugzilla.kernel.org?
> >
> 
> I know I am bad for not reporting that earlier but swsusp was working
> OK for me till about 3 month ago when I started getting "soft lockup
> detected on CPU0" with no useable backtrace 3 times out of 4. I
> somehow suspect that having automounted nfs helps it to fail
> somehow...

Disable soft lockup watchdog :-).
							Pavel
-- 
Thanks, Sharp!
