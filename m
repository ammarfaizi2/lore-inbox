Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVLJW7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVLJW7x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 17:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVLJW7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 17:59:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61638 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751290AbVLJW7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 17:59:52 -0500
Date: Sat, 10 Dec 2005 23:59:30 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Stefan Seyfried <seife@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Andy Isaacson <adi@hexapodia.org>
Subject: Re: [RFC/RFT] swsusp: image size tunable (was: Re: [PATCH][mm] swsusp: limit image size)
Message-ID: <20051210225928.GB5187@elf.ucw.cz>
References: <200512072246.06222.rjw@sisk.pl> <200512101421.57918.rjw@sisk.pl> <20051210160641.GB5047@elf.ucw.cz> <200512102106.41952.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512102106.41952.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +static ssize_t image_size_store(struct subsystem * subsys, const char * buf, size_t n)
> > > +{
> > > +	int len;
> > > +	char *p;
> > > +	unsigned int size;
> > > +
> > > +	p = memchr(buf, '\n', n);
> > > +	len = p ? p - buf : n;
> > 
> > len and p are unused.
> 
> Right.  BTW, the same applies to resume_store().

Thanks, fixed locally.
								Pavel
-- 
Thanks, Sharp!
