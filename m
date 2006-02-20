Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbWBTQcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWBTQcC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbWBTQcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:32:02 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64140 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161012AbWBTQb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:31:59 -0500
Date: Mon, 20 Feb 2006 13:56:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matthias Hensler <matthias@wspse.de>
Cc: Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220125629.GD16165@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602091926.38666.nigel@suspend2.net> <20060209232453.GC3389@elf.ucw.cz> <200602110116.57639.sebas@kde.org> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz> <20060220093911.GB19293@kobayashi-maru.wspse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220093911.GB19293@kobayashi-maru.wspse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It is slightly slower,
> 
> Sorry, but that is just unacceptable.

Eh? Slower suspend is not acceptable while slowing runtime system is
acceptable?

> > > The only con I see is the complexity of the code, but then again,
> > > Nigel
> > 
> > ..but thats a big con.
> 
> So why is that? From what I see, most of the code is completly independ
> of the rest of the kernel, and just does not affect if it is disabled.
> 
> It won't do any harm to the kernel, and again, Nigel is constantly
> improving that situation, so for sure, that is no _big_ con.

14000 lines is a lot of code to maintain.

> > > From a user, and contributor, point of view, I really do not
> > > understand why not even trying to push a working implementation into
> > > mainline (I know that you cannot just apply the Suspend 2 patches
> > > and shipping it,
> > 
> > It is less work to port suspend2's features into userspace than to
> > make suspend2 acceptable to mainline. Both will mean big changes, and
> > may cause some short-term problems, but it will be less pain than
> > maintaining suspend2 forever. Please help with the former...
> 
> These "big changes" is something I have a problem with, since it means
> to delay a working suspend/resume in Linux for another "short-term" (so
> what does it mean: 1 month? six? twelve?). It is painful to get these
> things to work reliable, I have followed this for nearly 1.5 years. And
> again: today there is a working implementation, so why not merge it and
> have something today, and then start working on the other things.

swsusp is reliable; suspend2 is faster... If you can't wait six months
for uswsusp (which is as fast, today)... help me with uswsusp.

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
