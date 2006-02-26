Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWBZSxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWBZSxi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 13:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWBZSxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 13:53:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62955 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750799AbWBZSxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 13:53:38 -0500
Date: Sun, 26 Feb 2006 19:53:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: improve memory shrinking
Message-ID: <20060226185319.GB2055@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602242122.53763.rjw@sisk.pl> <20060224235548.GB1930@elf.ucw.cz> <200602261627.18012.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602261627.18012.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I did try shrink_all_memory() five times, with .5 second delay between
> > > > them, and it freed more memory at later tries.
> > > 
> > > I wonder if the delays are essential or if so, whether they may be shorter
> > > than .5 sec.
> > 
> > I was using this with some success... (Warning, against old
> > kernel). But, as I said, I consider it ugly, and it would be better to
> > fix shrink_all_memory.
> 
> Appended is a patch against the current -mm.
>   [It also makes
> swsusp_shrink_memory() behave as documented for image_size = 0.
> Currently, if it states there's enough free RAM to suspend, it won't bother
> to free a single page.]

Could we get bugfix part separately?
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
