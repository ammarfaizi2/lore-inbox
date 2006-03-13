Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWCMW0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWCMW0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWCMW0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:26:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:975 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964811AbWCMW0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:26:52 -0500
Date: Mon, 13 Mar 2006 17:26:44 -0500
From: Bill Nottingham <notting@redhat.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Andrew Morton <akpm@osdl.org>,
       ambx1@neo.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-ID: <20060313222644.GD1311@devserv.devel.redhat.com>
Mail-Followup-To: Kay Sievers <kay.sievers@vrfy.org>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Andrew Morton <akpm@osdl.org>, ambx1@neo.rr.com,
	linux-kernel@vger.kernel.org
References: <20060301194532.GB25907@vrfy.org> <4406AF27.9040700@drzeus.cx> <20060302165816.GA13127@vrfy.org> <44082E14.5010201@drzeus.cx> <4412F53B.5010309@drzeus.cx> <20060311173847.23838981.akpm@osdl.org> <4414033F.2000205@drzeus.cx> <20060312172332.GA10278@vrfy.org> <20060313165719.GB4147@devserv.devel.redhat.com> <20060313192411.GA23380@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313192411.GA23380@vrfy.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers (kay.sievers@vrfy.org) said: 
> > See:
> >   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=178998
> > 
> > This doesn't work for everything.
> 
> Sure not, and I don't think "everything" in PnP will ever work. :) But
> it does the same as the modalias patch to the kernel we are talking about.
> There are device table entries completely missing and some other don't
> match. Some of them can be fixed by adding the aliases as modprobe.conf
> entries.

Well, it's just that if this is the solution proposed, I'd like it if
it worked for any of the people who are seeing problems - in our bugs,
it hasn't helped any of them yet.

Bill
