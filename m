Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423454AbWBBKsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423454AbWBBKsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423455AbWBBKsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:48:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22453 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1423454AbWBBKsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:48:02 -0500
Date: Thu, 2 Feb 2006 11:47:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060202104750.GC1884@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060202100522.GB1981@elf.ucw.cz> <200602022038.16262.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602022038.16262.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This set of patches represents the core of Suspend2's module support.
> > >
> > > Suspend2 uses a strong internal API to separate the method of
> > > determining the content of the image from the method by which it is
> > > saved. The code for determining the content is part of the core of
> > > Suspend2, and transformations (compression and/or encryption) and storage
> > > of the pages are handled by 'modules'.
> >
> > swsusp already has a very strong API to separate image writing from
> > image creation (in -mm patch, anyway). It is also very nice, just
> > read() from /dev/snapshot. Please use it.
> 
> You know that's not an option.

No, I don't... please explain. Switching to this interface is going to
be easier than pushing suspend2 into kernel. Granted, end result may
not be suspend2, it may be something like suspend3, but it will be
better result than u-swsusp or suspend2 is today...
								Pavel
-- 
Thanks, Sharp!
