Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTK1Kyk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 05:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTK1Kyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 05:54:40 -0500
Received: from mail.skjellin.no ([80.239.42.67]:65195 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S262116AbTK1Kyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 05:54:39 -0500
Subject: Re: Strange behavior observed w.r.t 'su' command
From: Andre Tomt <lkml@tomt.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031128105750.GA5777@cambrant.com>
References: <3FC707B6.1070704@mailandnews.com> <yw1xekvs3lbt.fsf@kth.se>
	 <20031128105750.GA5777@cambrant.com>
Content-Type: text/plain
Message-Id: <1070016863.29981.28.camel@slurv.pasop.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 28 Nov 2003 11:54:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-11-28 at 11:57, Tim Cambrant wrote:
> On Fri, Nov 28, 2003 at 10:15:50AM +0100, M?ns Rullg?rd wrote:
> > I can't reproduce it on Slackware running 2.6.0-test10.  It's probably
> > a redhat thing.
> 
> This problem also appears on Gentoo 1.4 running 2.6.0-test11. I don't
> know about the rest of the environment, but it's definately not just
> a RedHat thing. Could it have something to do with some library-version
> or something?

For whatever it's worth, I can't reproduce this on a Debian Sid system
with kernel version 2.4.23-rc1. I guess RH/Gentoo isn't killing off the
forked shell when su dies brutally, leaving the root shell and the user
shell fighting for the terminal.


