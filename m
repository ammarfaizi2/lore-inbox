Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265399AbTIESE7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 14:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265434AbTIESE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 14:04:59 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:43281 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265399AbTIESE6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 14:04:58 -0400
Date: Fri, 5 Sep 2003 20:05:00 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <aradorlinux@yahoo.es>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: azarah@gentoo.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm5
Message-Id: <20030905200500.1ab4d931.aradorlinux@yahoo.es>
In-Reply-To: <3F58B712.5070003@cyberone.com.au>
References: <20030902231812.03fae13f.akpm@osdl.org>
	<20030904010852.095e7545.diegocg@teleline.es>
	<3F569641.9090905@cyberone.com.au>
	<20030904202319.7f9947c9.diegocg@teleline.es>
	<1062776174.3376.26.camel@workshop.saharacpt.lan>
	<3F58B712.5070003@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 06 Sep 2003 02:17:22 +1000 Nick Piggin <piggin@cyberone.com.au> escribió:

[chaging email to avoid smart spam detectors]

> I think Martin is right here. I don't know what would be a good reason
> for wanting X to work nicely with a make -j25 running. X typically
> needs at least 75% CPU on my box to be nicely interactive when moving
> a window or scrolling something complex. This gives only 1% to each
> cc1.

I know; obiously it has not sense to ask that people makes -j25
smooth here; there's no way of doing that (with gcc 3.x :)

I just pointed out that -mm4 was a bit better under that load, specially
mp3 skips.


> So I've found I'm getting more consistent behaviour, but it is now
> very dependant on nice to get X running well under load. I'm
> concentrating on getting it working well with make -j <= 6.

I just hope 2.6 is shipped with a "decent" scheduler. Mp3 players are
probably the most important apps nowadays :P




