Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030550AbVKPWvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030550AbVKPWvL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030552AbVKPWvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:51:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45251 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030550AbVKPWvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:51:09 -0500
Date: Wed, 16 Nov 2005 23:50:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Greg KH <greg@kroah.com>, "Gross, Mark" <mark.gross@intel.com>,
       Dave Jones <DaveJ@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051116225047.GJ12505@elf.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com> <20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost> <20051116220500.GF12505@elf.ucw.cz> <1132175574.25230.111.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132175574.25230.111.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I've also split the one patch that most people see into what is
> > > currently about 225 smaller patches, each adding only one small part, am
> > > writing descriptions for them all and am preparing to build a git tree
> > > from it.
> > 
> > I'm not sure that gets suspend2 any closer to merging. 225 small
> > patches is still awful lot of code :-(. Now... if something can be
> > done in userspace, it probably should. And I'm trying to show that
> > suspend2 functionality can indeed be done in userspace.
> > 
> > So... to get 225 patches in, you'll need to explain that
> > userland-swsusp can't work. If you can do that, please be nice and do
> > it soon, so that I don't waste too much time on userland-swsusp.
> 
> I thought Dave already did that.

No, I do not think so. He did not like the user<->kernel interface;
but that can be changed (and Rafael has plans to do that). I think we
can present nicer interface to userland without much code. Or maybe
not; but we can certainly limit /dev/kmem for suspend only -- and that
should make it acceptable security-wise.

                                                                Pavel

-- 
Thanks, Sharp!
