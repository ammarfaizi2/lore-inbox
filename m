Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWAWW2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWAWW2K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 17:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWAWW2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 17:28:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50643 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964965AbWAWW2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 17:28:08 -0500
Date: Mon, 23 Jan 2006 23:26:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Al Boldi <a1426z@gawab.com>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-ID: <20060123222648.GB1739@elf.ucw.cz>
References: <200601212108.41269.a1426z@gawab.com> <20060122123335.GB26683@lnx-holt.americas.sgi.com> <200601232103.07007.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601232103.07007.a1426z@gawab.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 23-01-06 21:03:06, Al Boldi wrote:
> Robin Holt wrote:
> > On Sat, Jan 21, 2006 at 09:08:41PM +0300, Al Boldi wrote:
> > >
> > > Wouldn't it be nice to take advantage of todays 64bit archs and TB
> > > drives, and run a more modern way of life w/o this memory/storage split
> > > personality?
> >
> > Your simple world introduces a level of complexity to the kernel which
> > is nearly unmanageable.  Basically, you are asking the system to intuit
> > your desires.  The swap device/file scheme allows an administrator to
> > control some aspects of their system while giving the kernel developer
> > a reasonable number of variables to work with.  That, at least to me,
> > does not sound schizophrenic, but rather very reasonable.
> >
> > Sorry for raining on your parade,
> 
> Thanks for your detailed response, it rather felt like a fresh breeze.
> 
> Really, I was more thinking about a step by step rather than an all or none 
> approach.  Something that would involve tmpfs merged with swap mapped into 
> linear address space limited by arch bits, and everything else connected as 
> archive.
> 
> The idea here is to run inside swap instead of using it as an addon.
> In effect running inside memory cached by physical RAM.

And if you do not want to run inside swap? For example because your
machine has only RAM? This will not fly.

Having dreams is nice, but please avoid sharing them unless they come
with patches attached.
								Pavel 
-- 
Thanks, Sharp!
