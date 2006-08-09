Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWHIMKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWHIMKt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWHIMKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:10:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31382 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161009AbWHIMKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:10:48 -0400
Date: Wed, 9 Aug 2006 14:10:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
Subject: Re: [RFC][PATCH -mm 2/5] swsusp: Use memory bitmaps during resume
Message-ID: <20060809121029.GE3747@elf.ucw.cz>
References: <200608091152.49094.rjw@sisk.pl> <200608091204.36186.rjw@sisk.pl> <20060809114942.GS3308@elf.ucw.cz> <200608091404.56737.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608091404.56737.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > @@ -53,7 +40,7 @@ static inline void pm_restore_console(vo
> > >  static inline int software_suspend(void)
> > >  {
> > >  	printk("Warning: fake suspend called\n");
> > > -	return -EPERM;
> > > +	return -ENOSYS;
> > >  }
> > >  #endif /* CONFIG_PM */
> > >  
> > 
> > Heh, yes, it is right.. it is also totally unrelated and changes
> > userland interface ;-)))... which is probably okay here. But separate
> > would be nice.
> 
> Ah, well, that's a "btw" thing. ;-)  Will separate.

...and probably should go _before_ the hard patches.
								Pavel 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
