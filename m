Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbWBCEpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWBCEpc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 23:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWBCEpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 23:45:32 -0500
Received: from thunk.org ([69.25.196.29]:54680 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964908AbWBCEpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 23:45:31 -0500
Date: Thu, 2 Feb 2006 23:45:09 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Dave Jones <davej@redhat.com>, Michael Loftis <mloftis@wgops.com>,
       David Weinehall <tao@acc.umu.se>, Doug McNaught <doug@mcnaught.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
       dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060203044509.GA23382@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Sam Ravnborg <sam@ravnborg.org>, Dave Jones <davej@redhat.com>,
	Michael Loftis <mloftis@wgops.com>,
	David Weinehall <tao@acc.umu.se>, Doug McNaught <doug@mcnaught.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
	dtor_core@ameritech.net,
	James Courtier-Dutton <James@superbug.co.uk>,
	linux-kernel@vger.kernel.org
References: <20060120200051.GA12610@flint.arm.linux.org.uk> <5793EB6F192350088E0AC4CE@d216-220-25-20.dynip.modwest.com> <87slrio9wd.fsf@asmodeus.mcnaught.org> <25D702FB62516982999D7084@d216-220-25-20.dynip.modwest.com> <20060202121653.GI20484@vasa.acc.umu.se> <67A0AFFBC77C32B9DEE25EFA@dhcp-2-206.wgops.com> <20060202201008.GD11831@redhat.com> <20060202220519.GA8712@mars.ravnborg.org> <20060202221023.GJ11831@redhat.com> <20060202221922.GB8712@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202221922.GB8712@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 11:19:22PM +0100, Sam Ravnborg wrote:
> On Thu, Feb 02, 2006 at 05:10:25PM -0500, Dave Jones wrote:
> > 
> > -rw-r--r--    1 davej    davej        4613 Dec 15 23:31 linux-2.6-build-nonintconfig.patch
> > 
> > Adds a 'nonintconfig' target that behaves like oldconfig, but doesn't
> > ask any questions (takes the default answer), and prints out a list
> > at the end of all the options it didn't know about.
> > (Handy when rebasing, as it means I get to add all the new options
> >  in one swoop).
> I have this around somewhere. hch did it but recall Roman did not
> like it. It's in my pile of 'when I am in kconfig hacking mode' which
> happens now and then.

It'd be nice if this one was included; we're using this in a set of
kernel patches which we deliver to a customer who needs a real-time
Linux solution, and we're using it for the same reason that
RHEL/Fedora is; it's really handy when rebasing to the latest kernel.

(Note to Michael Loftis re: the original thread: ++ to a list of "real
companies" that are using and tracking bleeding edge kernels for a
customer deliverable.  It _is_ doable if you aren't spending all of
your time whining....)

						- Ted
