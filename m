Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWC3Lzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWC3Lzp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWC3Lzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:55:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932078AbWC3Lzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:55:44 -0500
Date: Thu, 30 Mar 2006 13:55:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
Subject: Re: Suspend2-2.2.2 for 2.6.16.
Message-ID: <20060330115519.GN8485@elf.ucw.cz>
References: <200603281601.22521.ncunningham@cyclades.com> <200603292050.33622.ncunningham@cyclades.com> <20060330092627.GG8485@elf.ucw.cz> <200603301944.27188.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603301944.27188.ncunningham@cyclades.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Please do try code at suspend.sf.net. It should be as fast and not
> > > > needing big kernel patch.
> > >
> > > Don't bother suggesting that to x86_64 owners: compilation is currently
> > > broken in vbetool/lrmi.c (at least).
> >
> > It seems to work at least for some users. I do not have x86-64 machine
> > easily available, so someone else will have to fix that one.
> >
> > (Also it should be possible to compile suspend without s2ram support,
> > avoiding the problem).
> 
> I just found the line saying pciutils-devel is needed. Maybe that will make 
> the difference.

I do not see missing includes, so I'm not sure it will help. Can you
try adding 

ARCH=x86_64

to Makefile?
								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
