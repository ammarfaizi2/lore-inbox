Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbVCXR4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVCXR4H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 12:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbVCXR4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 12:56:06 -0500
Received: from witte.sonytel.be ([80.88.33.193]:27057 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262641AbVCXR4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 12:56:02 -0500
Date: Thu, 24 Mar 2005 18:55:56 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Vier <tmv@comcast.net>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Pietro Zuco <maillist@zuco.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Squashfs without ./..
In-Reply-To: <20050323174925.GA3272@zero>
Message-ID: <Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be>
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr>
 <Pine.LNX.4.62.0503221656310.2683@dragon.hyggekrogen.localhost>
 <200503231740.09572.maillist@zuco.org> <Pine.LNX.4.61.0503231829570.1481@yvahk01.tjqt.qr>
 <20050323174925.GA3272@zero>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005, Tom Vier wrote:
> On Wed, Mar 23, 2005 at 06:31:24PM +0100, Jan Engelhardt wrote:
> > Which scripts use that? As stated, these two directory entries exist when you 
> > stat() them, they just do not show up in readdir(), and I bet few programs 
> > care for "." and ".." when doing their readdir.
> 
> There's probably a number of apps that skip the first two dirents, instead
> of checking for the dot dirs.

Yep, check `-noleaf' in find(1).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
