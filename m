Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131498AbRDBMoU>; Mon, 2 Apr 2001 08:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132328AbRDBMoK>; Mon, 2 Apr 2001 08:44:10 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:47119 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131498AbRDBMnv>;
	Mon, 2 Apr 2001 08:43:51 -0400
Date: Mon, 2 Apr 2001 14:42:41 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
   Benjamin Herrenschmidt <benh@kernel.crashing.org>,
   Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
   Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Recent problems with APM and XFree86-4.0.1
Message-ID: <20010402144241.B17319@pcep-jamie.cern.ch>
In-Reply-To: <20010331021514.A6784@pcep-jamie.cern.ch> <200103310537.f2V5bDO06729@pcug.org.au> <20010331162513.C7946@pcep-jamie.cern.ch> <20010401234156.B15813@pcep-jamie.cern.ch> <3AC7AC2F.D390C923@neuronet.pitt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AC7AC2F.D390C923@neuronet.pitt.edu>; from raffo@neuronet.pitt.edu on Sun, Apr 01, 2001 at 06:31:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael E. Herrera wrote:
> > I've noticed other changes in suspend/resume.  I'm running Gnome now,
> > and it insists on running xscreensaver whenever I close the lid.
> > Somehow it is noticing the APM event, because this is very consistent.
> > Does anyone know how to disable this?  The setting "No screensaver"
> > under the list of screensavers didn't help -- it just runs a blank
> > screensaver which is even more confusing, because the computer appears
> > not to have resumed (when it's just a black screensaver).
> 
> Look at the s option in the man pages for xset, that may help.

That is about when to blank/power down the display isn't it?

I know that xscreensaver watches for that (according to the man page),
and doesn't draw anything while the monitor's powered down.

But how do I stop xscreensaver from being started in the first place?

-- Jamie

