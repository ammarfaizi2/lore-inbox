Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWD3GSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWD3GSp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 02:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWD3GSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 02:18:45 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:32523 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750977AbWD3GSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 02:18:44 -0400
Date: Sun, 30 Apr 2006 08:18:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: World writable tarballs
Message-ID: <20060430061842.GA22883@mars.ravnborg.org>
References: <1146356286.10953.7.camel@hammer> <200604300148.12462.s0348365@sms.ed.ac.uk> <bda6d13a0604292159r3187b76fg56b137816480bf2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda6d13a0604292159r3187b76fg56b137816480bf2a@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2006 at 09:59:22PM -0700, Joshua Hudson wrote:
> I've got good reasons
> for compiling the kernel as root (when in the make, install, reboot, test 
> loop it's quite a timesaver).

Care to explain why it is a timesaver to compile your kernel as root?
Other do something like:
make && sudo make modules_install && sudo make install

Or variants of this. In this way we run only a minimal set as root.

	Sam
