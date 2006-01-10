Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932629AbWAJVBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbWAJVBe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbWAJVBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:01:34 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:50445 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932629AbWAJVBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:01:33 -0500
Date: Tue, 10 Jan 2006 22:01:15 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] kconfig: factor out ncurses check in a shell script
Message-ID: <20060110210115.GA16250@mars.ravnborg.org>
References: <11368426843316@foobar.com> <Pine.LNX.4.61.0601102127230.16049@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601102127230.16049@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 09:27:42PM +0100, Jan Engelhardt wrote:
> >
> >Cleaning up the lxdialog Makefile by factoring out the
> >ncurses compatibility checks.
> >This made the checks much more obvious and easier to extend.
> 
> BTW, do you know a nice way to detect ncursesw?
Hi Jan.

I had ncursesw in my mind too when I did this.
If you look at the test implemented to check for ncurses it
should be simple to use same principle to check if one can use
ncursesw. If gcc does not fail then ncursesw is present.

Care to give it a spin?
Otherwise I will try later this week.

	Sam
