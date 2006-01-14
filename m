Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWANRn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWANRn5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 12:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWANRn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 12:43:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49369 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750717AbWANRn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 12:43:57 -0500
Date: Sat, 14 Jan 2006 18:43:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Linux PM <linux-pm@osdl.org>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Message-ID: <20060114174345.GA16427@elf.ucw.cz>
References: <200601122241.07363.rjw@sisk.pl> <200601141040.00088.rjw@sisk.pl> <20060114112950.GA2571@ucw.cz> <200601141319.53573.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601141319.53573.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > to read the value.  However, afterwards I'd have to rescale that value
> > > to megs for swsusp_shrink_memory().  It's just easier to pass the value
> > > in megs using the last argument of ioctl() directly (which is consistent
> > > with the /sys/power/image_size thing, BTW).
> > 
> > Well, I'd be inclined to make image_size in bytes, too. Having
> > each ioctl/sys file in different units seems wrong.
> 
> I'll add these changes to the userland interface patch, then.  There won't
> be too many of them, I think.

Thanks.
									Pavel
-- 
Thanks, Sharp!
