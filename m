Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVE3IEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVE3IEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 04:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVE3IEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 04:04:12 -0400
Received: from witte.sonytel.be ([80.88.33.193]:53931 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261553AbVE3IDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 04:03:54 -0400
Date: Mon, 30 May 2005 10:03:09 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Dave Airlie <airlied@linux.ie>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] DRM depends on ???
In-Reply-To: <64148E06-2DFA-41A5-9D86-5F34DCAAF9F4@mac.com>
Message-ID: <Pine.LNX.4.62.0505301002400.22798@numbat.sonytel.be>
References: <Pine.LNX.4.62.0505282333210.5800@anakin> <20050528215005.GA5990@redhat.com>
 <1FA58BE7-0EE6-432B-9383-F489F9854DBE@mac.com> <Pine.LNX.4.58.0505290809180.9971@skynet>
 <Pine.LNX.4.62.0505292157130.12948@numbat.sonytel.be>
 <64148E06-2DFA-41A5-9D86-5F34DCAAF9F4@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 May 2005, Kyle Moffett wrote:
> On May 29, 2005, at 15:58:10, Geert Uytterhoeven wrote:
> > > What Kyle said is the correct answer... we either keep this lovely
> > > construct (I'll add a comment for 2.6.13) or we go back to the old
> > > intermodule or module_get stuff... DRM built-in with modular AGP is always
> > > wrong... or at least I'll get a hundred e-mails less every month if I
> > > say it is ..
> > 
> > And what if we don't have AGP at all? Or no PCI?
> 
> Then DRM detects that at configure time and excludes the code that requires
> AGP.  Basically, the following are valid configurations:

OK. So we still need the dependency on PCI.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
