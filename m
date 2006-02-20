Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932651AbWBTThB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbWBTThB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 14:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWBTTg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 14:36:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:941 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932649AbWBTTgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 14:36:55 -0500
Date: Mon, 20 Feb 2006 20:36:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: Olivier Galibert <galibert@pobox.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220193628.GJ19156@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602201513.23849.rjw@sisk.pl> <20060220153922.GA17362@dspnet.fr.eu.org> <200602201816.56232.rjw@sisk.pl> <20060220181657.GD33155@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220181657.GD33155@dspnet.fr.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 20-02-06 19:16:57, Olivier Galibert wrote:
> On Mon, Feb 20, 2006 at 06:16:55PM +0100, Rafael J. Wysocki wrote:
> > On Monday 20 February 2006 16:39, Olivier Galibert wrote:
> > > On Mon, Feb 20, 2006 at 03:13:23PM +0100, Rafael J. Wysocki wrote:
> > > Stuff that is _already_ _done_ and working.
> > 
> > Functionality-wise, your right.  The problem is how it's done, I think, and
> > that is not so obvious.
> 
> Heh.  It obviously has been way too long out of mainline.  Pavel's
> reviews being 90% "you should do all that in userspace" are a little
> tiring after a while though.

That does not make them wrong... having to review code that does not
need to be in kernel in the first place is tiring, too.

Feel free to review that code yourself, and clean it up with Nigel;
but it is useless as long as it contains stuff such as "press 'C' to
continue, or any other key to reboot".
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
