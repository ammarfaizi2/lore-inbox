Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbTL2Wov (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 17:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbTL2Wou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 17:44:50 -0500
Received: from [24.35.117.106] ([24.35.117.106]:54153 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265100AbTL2Wot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 17:44:49 -0500
Date: Mon, 29 Dec 2003 17:44:46 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Norman Diamond <ndiamond@wta.att.ne.jp>
cc: dan@eglifamily.dnsalias.net, linux-kernel@vger.kernel.org
Subject: Re: Blank Screen in 2.6.0
In-Reply-To: <007101c3cdbc$046a58d0$2fee4ca5@DIAMONDLX60>
Message-ID: <Pine.LNX.4.58.0312291741530.5409@localhost.localdomain>
References: <007101c3cdbc$046a58d0$2fee4ca5@DIAMONDLX60>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003, Norman Diamond wrote:

> Dan wrote:
> 
> > Upgraded to the lastest module-init-tools, and disabled the
> > frame buffer support in the kernel. So the only graphic option enabled is
> > text mode selection. But when I boot I still get a blank screen!
> > My lilo.conf contains a line: vga=773, which works beautifully under
> > RedHat's stock 2.4.20-8.
> 
> In my experience the vga= option worked with every 2.4 kernel in every
> distro that I had used, continued working with 2.6 test* and 0 in Red Hat
> 7.3, but blanked the screen with 2.6 test* and 0 in SuSE 8.1 and SuSE 8.2.
> Haven't tried other configurations with 2.6.
> 
> But now you're getting the same with a Red Hat distro, so it's looking
> pretty random.
> 
> The decision to release 2.6.0 with the same broken vga= option that was
> reported many times in 2.6.0-test* makes me think that vga= is not intended
> to work.

Maybe it has something to do with RedHat 7.3.  I've used RH8, RH9, and 
Fedora Core 1 and haven't had a problem with vga= in any of them during 
the 2.5/2.6 series, right up through the current one.  I've got 
framebuffer support as a module.
