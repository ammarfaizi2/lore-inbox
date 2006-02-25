Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932651AbWBYAnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbWBYAnV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWBYAnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:43:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48798 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932651AbWBYAnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:43:21 -0500
Date: Sat, 25 Feb 2006 01:43:02 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060225004302.GD1930@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602250911.54850.ncunningham@cyclades.com> <20060224235321.GA1930@elf.ucw.cz> <200602251022.43453.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602251022.43453.ncunningham@cyclades.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We are trying to catch a bug here. suspend2 or not, it is a bug and it
> > should be fixed (or at least understood).
> >
> > [Also please try to tone down your messages. Your suspend2 may be more
> > user-friendly, you do not want to start that flamewar again, do you?
> > Saying "don't bother fixing that" is not nice thing to do.]
> 
> What's the bug?

shrink_all_memory() returns zero, even throught there are still pages
freeable.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
