Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUFVAwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUFVAwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 20:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUFVAwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 20:52:19 -0400
Received: from main.gmane.org ([80.91.224.249]:5034 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266538AbUFVAwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 20:52:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Matroxfb in 2.6 still doesn't work in 2.6.7
Date: Tue, 22 Jun 2004 02:51:24 +0200
Message-ID: <MPG.1b41a0f6b20282e39896d1@news.gmane.org>
References: <20040618211031.GA4048@irc.pl> <20040619190503.GB17053@vana.vc.cvut.cz> <20040619193053.GA3644@irc.pl> <20040619203954.GC17053@vana.vc.cvut.cz> <20040620160437.GA29046@irc.pl> <20040620170114.GA4683@vana.vc.cvut.cz> <20040620213743.GA6974@irc.pl> <20040621013136.GB4683@vana.vc.cvut.cz> <20040621181003.GB28577@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-164-130.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz wrote:
> On Mon, Jun 21, 2004 at 03:31:36AM +0200, Petr Vandrovec wrote:
> > > > > > video=matroxfb:vesa:0x11A,right:48,hslen:112,left:248,hslen:112,lower:1,vslen:3,upper:48
> > > > > > maybe with ',sync:3' if +hsync/+vsync are mandatory for your monitor.
> > 
> > 1280x1024-60 just selects some videomode fbdev subsystem thinks your monitor should use,
> > while vesa:0x11A selects videomode I think you should use.
> 
>  Could fbdev be changed to select the same videomode as vesa: switch?

There is a vesafb-tng (the next generation) on Gentoo. I 
applied it to my 2.6.7; it allows, among other things, to load 
the vesafb driver as a module and to specify resolutions with 
the "usual" (widthxheight-bitdepth@refresh) syntax.

On my video card (GeForce2 Go) it doesn't seem to work very 
well though.

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

