Return-Path: <linux-kernel-owner+w=401wt.eu-S1030791AbWLPIpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030791AbWLPIpy (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 03:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030794AbWLPIpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 03:45:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2618 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030791AbWLPIpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 03:45:53 -0500
Date: Sat, 16 Dec 2006 08:45:42 +0000
From: Pavel Machek <pavel@ucw.cz>
To: James Lockie <bjlockie@lockie.ca>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: escape key]
Message-ID: <20061216084542.GD4049@ucw.cz>
References: <1166058290.2964.15.camel@monteirov> <20061213214140.df6111f5.randy.dunlap@oracle.com> <4580E985.2090208@lockie.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4580E985.2090208@lockie.ca>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>From: James Lockie <bjlockie@lockie.ca>
> >>>To: linux-x86_64@vger.kernel.org
> >>>Subject: escape key
> >>>Date: 	Tue, 12 Dec 2006 14:57:57 -0500
> >>>
> >>>I can't use the escape key to exit a menu with make 
> >>>menuconfig on kernel-2.6.19 or .1
> >>>It works on 2.6.18. :-(
> >>>      
> >
> >Is this a problem?
> >
> >You can exit a menu by selecting <Exit> and pressing 
> >Enter
> >or (as the help text at the top of the screen says:)
> >pressing <Esc><Esc> (2 times).  Yes, pressing <Esc> one 
> >time
> >and then waiting for 1-2 seconds used to exit a menu.
> >
> >One could argue that it has been "fixed" to match the 
> >help text.

> Two escapes works now. :-)

Actually could we fix our consoles, somehow, to make esc usable?
Having important key like esc unusable on consoles is quite ugly.

ioctl(console_fd, AM_I_IN_THE_MIDDLE_OF_ESCAPE_SEQUENCE_?) would do
the trick at least for vt consoles...
							Pavel
-- 
Thanks for all the (sleeping) penguins.
