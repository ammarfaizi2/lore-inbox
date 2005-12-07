Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbVLGMSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbVLGMSc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbVLGMSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:18:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62926 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750913AbVLGMSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:18:32 -0500
Date: Wed, 7 Dec 2005 13:18:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andy Isaacson <adi@hexapodia.org>, linux-kernel@vger.kernel.org
Subject: Re: swsusp: how much memory to free? [was Re: swsusp performance problems in 2.6.15-rc3-mm1]
Message-ID: <20051207121804.GH2563@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org> <200512071253.54055.rjw@sisk.pl> <20051207115952.GF2563@elf.ucw.cz> <200512071316.58351.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512071316.58351.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Looks good to me.
> > 
> > > Index: linux-2.6.15-rc5-mm1/kernel/power/swsusp.c
> > > ===================================================================
> > > --- linux-2.6.15-rc5-mm1.orig/kernel/power/swsusp.c	2005-12-05 22:07:12.000000000 +0100
> > > +++ linux-2.6.15-rc5-mm1/kernel/power/swsusp.c	2005-12-07 12:40:27.000000000 +0100
> > > @@ -626,6 +626,7 @@
> > >  
> > >  int swsusp_shrink_memory(void)
> > >  {
> > > +	unsigned long size;
> > >  	long tmp;
> > 
> > Perhaps both should be long, or both unsigned long?
> 
> tmp has to be signed.  Both can be long, though.
> 
> Should I test it and post for merging?

Yes..
							Pavel

-- 
Thanks, Sharp!
