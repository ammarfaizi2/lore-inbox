Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265704AbTIJTvi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265712AbTIJTvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:51:38 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:52748 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265704AbTIJTvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:51:36 -0400
Date: Wed, 10 Sep 2003 21:51:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: Multiple configuration support
Message-ID: <20030910195135.GC5723@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel@vger.kernel.org
References: <20030909192918.GA2933@mars.ravnborg.org> <20030910202132.I30046@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910202132.I30046@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 08:21:32PM +0100, Russell King wrote:
> On Tue, Sep 09, 2003 at 09:29:18PM +0200, Sam Ravnborg wrote:
> > boardconfig should be very simple, only including delta to the
> > default configuration.
> 
> The delta is going to be fairly large for ARM - it doesn't make sense
> to have a default core configuration and per-board deltas.

OK.
I already dropped my current implementation (got it working by patching
a bit in kconfig, but realised the same can be achived by preprocessing
the config files).
So to make it clear - the above functionality is NOT implemented in the
patchset I just sent to Linus.

	Sam
