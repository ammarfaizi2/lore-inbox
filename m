Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266065AbTLIQr7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266066AbTLIQr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:47:59 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:35034 "EHLO uni-kl.de")
	by vger.kernel.org with ESMTP id S266065AbTLIQr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:47:58 -0500
Date: Tue, 9 Dec 2003 17:47:39 +0100
From: Eduard Bloch <edi@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
Message-ID: <20031209164738.GA4159@zombie.inka.de>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <pan.2003.12.08.23.04.07.111640@dungeon.inka.de> <20031208233428.GA31370@kroah.com> <1070953338.7668.6.camel@simulacron> <20031209083228.GC1698@kroah.com> <3FD59CED.6090408@portrix.net> <20031209162747.GB8675@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209162747.GB8675@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Greg KH [Tue, Dec 09 2003, 08:27:47AM]:

> Like Matthew stated, either use the udev rc startup script, or put udev
> into your initramfs image to catch all of the early boot messages.
> Doing the initramfs method is still very tough to do right now, but
> people have reported success that way.  I still recommend just using the
> init.d script for now.

Wouln't it be less error-prone to introduce a kind of queing for the
hotplug program so kernel puts all the registered devices in a list and
the list is submitted in one pass when udev asks for it?

MfG,
Eduard.
