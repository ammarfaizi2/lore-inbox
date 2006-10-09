Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932956AbWJIT1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932956AbWJIT1e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933006AbWJIT1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:27:34 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:19353 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S932956AbWJIT1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:27:32 -0400
Date: Mon, 9 Oct 2006 21:27:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roger While <simrw@sim-basis.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: menuconfig bust in 2.6.19rc1-git5
Message-ID: <20061009192731.GB9937@uranus.ravnborg.org>
References: <6.1.1.1.2.20061009092219.02b0bec0@192.168.6.12> <20061009094609.GA6703@uranus.ravnborg.org> <6.1.1.1.2.20061009125614.02a6e000@192.168.6.12>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.1.1.1.2.20061009125614.02a6e000@192.168.6.12>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 01:03:07PM +0200, Roger While wrote:
> Aaagh, sorry, false alarm.
> There was a dud (0 byte) /usr/include/ncurses/ncurses.h on the system :-(
> (However /usr/include/ncurses.h is perfectly OK)
Thanks for the feedback.

> Maybe check-lxdialog.sh should 'test -s' the includes ?
This is an uncommon bug - and we cannot check for all sorts of busted
systems. So unless this proves to be common I will resist to include
such a check.

	Sam
