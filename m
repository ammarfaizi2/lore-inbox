Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVB0IIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVB0IIM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 03:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVB0IIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 03:08:11 -0500
Received: from witte.sonytel.be ([80.88.33.193]:7561 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261366AbVB0IIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 03:08:05 -0500
Date: Sun, 27 Feb 2005 09:07:37 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Olaf Hering <olh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: 2.6.11-rc5
In-Reply-To: <1109380389.15026.112.camel@gaston>
Message-ID: <Pine.LNX.4.62.0502270906420.3143@numbat.sonytel.be>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
 <20050224145049.GA21313@suse.de>  <20050226004137.GA25539@suse.de>
 <1109380389.15026.112.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Feb 2005, Benjamin Herrenschmidt wrote:
> On Sat, 2005-02-26 at 01:41 +0100, Olaf Hering wrote:
> > modedb can not be __init because fb_find_mode() may get db == NULL.
> > fb_find_mode() is called from modules.
> 
> Ahhh, good catch ! I though that was fixed long ago, looks like I was
> wrong.

Yep, I was surprised by this bug as well...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
