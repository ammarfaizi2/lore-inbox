Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVKUOOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVKUOOx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 09:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVKUOOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 09:14:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46031 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932299AbVKUOOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 09:14:52 -0500
Date: Mon, 21 Nov 2005 15:14:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: Stefan Rompf <stefan@loplof.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] userland swsusp
Message-ID: <20051121141421.GA1655@elf.ucw.cz>
References: <200511161700.27239.stefan@loplof.de> <20051116190715.GF2193@spitz.ucw.cz> <200511210023.51457.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511210023.51457.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'm curious on the restrictions the userspace part would have to accept.
> > > Can /usr/swsusp.c write to a file? Currently, you allow it, but I doubt
> >
> > No. Writing to file would trash the filesystem. But you can bmap the file,
> > then write to the block device.
> 
> Do/should all the filesystems get remounted read-only as a precaution?  Or is 
> that overkill?

You may not do that. remounting the filesystem writes to it... and
that's no-no.
								Pavel
-- 
Thanks, Sharp!
