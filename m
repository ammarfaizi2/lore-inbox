Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTIVKPE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 06:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbTIVKPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 06:15:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16619 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263057AbTIVKPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 06:15:00 -0400
Date: Fri, 19 Sep 2003 12:40:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: mru@users.sourceforge.net, kernel list <linux-kernel@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resuming from software suspend
Message-ID: <20030919104011.GB10401@openzaurus.ucw.cz>
References: <1063915370.2410.12.camel@laptop-linux> <yw1xad91nrmd.fsf@users.sourceforge.net> <1063958370.5520.6.camel@laptop-linux> <yw1xu179mc55.fsf@users.sourceforge.net> <1063963914.7253.9.camel@laptop-linux> <yw1xwuc5kt7e.fsf_-_@users.sourceforge.net> <1063965939.7874.6.camel@laptop-linux> <yw1xoexhkrtb.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xoexhkrtb.fsf@users.sourceforge.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> What I want to do is boot, do some things, and then resume the
> suspended state without rebooting between.  Is that possible?  I don't
> see any reason why it should be impossible to do, even if it's not
> currently supported.

Its not impossible, its just pretty tricky. You'd have to kill all
userland and bring devices back to sane state.
(It is also going to be very tricky to *test*.)
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

