Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263276AbTJKLtl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 07:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263278AbTJKLtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 07:49:41 -0400
Received: from gprs147-20.eurotel.cz ([160.218.147.20]:47488 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263276AbTJKLtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 07:49:40 -0400
Date: Sat, 11 Oct 2003 13:49:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       marcelo.tosatti@cyclades.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] laptop mode
Message-ID: <20031011114913.GA516@elf.ucw.cz>
References: <200310091103.h99B31ug014566@hera.kernel.org> <3F856A7E.2010607@pobox.com> <20031009140547.GD1232@suse.de> <20031009141734.GB23545@redhat.com> <20031009142632.GI1232@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031009142632.GI1232@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Right now laptopmode/aam is just a suspect. There are still 1-2 other
> > small patches against IDE which could be the reason.  We've dropped
> > laptopmode/aam for the time being to see if the folks seeing repeatable
> > corruption suddenly start behaving again.
> 
> aam patch is far more risky, it's a far more likely suspect. That patch
> never reall did go out of beta. Dropping laptop-mode and aam at the same
> time is bad engineering practice :).
> 
> laptop-mode cannot cause corruption that cannot show otherwise.

Well, if fireballs have data-corrupting that happens just after spinup
(for example), I can see how laptop-mode affects that. W/o
laptop-mode, disk is spinning all the time so sleep bugs can not
manifest themselves. You add laptop-mode, and...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
