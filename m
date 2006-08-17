Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWHQL5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWHQL5u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWHQL5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:57:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:41103 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964833AbWHQL5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:57:49 -0400
Date: Thu, 17 Aug 2006 04:52:50 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC][PATCH 3/3] PM: Remove PM_TRACE from Kconfig
Message-ID: <20060817115250.GA6843@kroah.com>
References: <200608151509.06087.rjw@sisk.pl> <20060816104143.GC9497@elf.ucw.cz> <200608161304.51758.rjw@sisk.pl> <200608161314.11128.rjw@sisk.pl> <20060817044011.GB14127@kroah.com> <20060817091238.GA17899@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060817091238.GA17899@elf.ucw.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 11:12:38AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Remove the CONFIG_PM_TRACE option, which is dangerous and should only be used
> > > by people who know exactly what they are doing, from Kconfig.
> > 
> > No, don't remove this, that's not acceptable at all.  This is useful for
> > others (and one specifically who will be pissed to see this removed...)
> 
> Yep, while it breaks suspend for every pool soul that enables it by
> mistake. (And in hard-to-debug way, too).
> 
> This option has EXACTLY ONE USER... or more precisely used to have one
> user when he was debugging his mac mini...

I tried it out for a bit when having problems with resume, which I have
yet to resolve properly, so I'll need it again when I get the chance.

And you go tell that "ONE USER" that you disabled his feature :)

thanks,

greg k-h
