Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWJXICD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWJXICD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWJXICB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:02:01 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22788 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932408AbWJXICA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:02:00 -0400
Date: Tue, 24 Oct 2006 08:01:31 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@osdl.org>, rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061024080130.GB4211@ucw.cz>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231236.54317.rjw@sisk.pl> <1161605379.3315.23.camel@nigel.suspend2.net> <200610231607.17525.rjw@sisk.pl> <20061023095522.e837ad89.akpm@osdl.org> <20061023171450.GA3766@elf.ucw.cz> <20061023105022.8b1dc75d.akpm@osdl.org> <1161644306.7033.18.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161644306.7033.18.camel@nigel.suspend2.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Last time I checked, suspend2 was 15000 lines of code, including its
> > > own plugin system and special user-kernel protocol for drawing
> > > progress bar (netlink based). It also did parts of user interface from
> > 
> > That's different.
> 
> Let's judge those bits when we see them, rather than going on rumour and
> inuendo :)

Ok, but lets not merge patches 'because shiny great future patch may
depend on them'.

> I am seeking to produce patches to merge Suspend2 one bit at a time, as
> has been requested in the past. I'd therefore ask that you do that,
> because even if Pavel and Rafael don't like the overall thrust, it
> doesn't mean you can't cherry pick what is good and useful along the
> way.

Yep, this is indeed way to go.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
