Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264293AbTEGV4I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 17:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTEGV4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 17:56:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35342 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264293AbTEGV4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 17:56:02 -0400
Date: Wed, 7 May 2003 15:07:34 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Ben Collins <bcollins@debian.org>, James Simmons <jsimmons@infradead.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.69 
In-Reply-To: <Pine.GSO.4.21.0305072138510.12013-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.44.0305071504470.3543-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 May 2003, Geert Uytterhoeven wrote:
> On Sun, 4 May 2003, Linus Torvalds wrote:
> > Summary of changes from v2.5.68 to v2.5.69
> > ============================================
> > 
> > Ben Collins:
> >   o [VIDEO]: Revert cfbimgblt.c back to a working state on 64-bit
> >   o [VIDEO]: Revert atyfb back to known working clean base
> 
> For future changes, could you please run these `reversals' through 
> linux-fbdev-devel, instead of silently passing them behind our backs? Thanks!

As mentioned already, this was done by several people, including the 
maintainer.

But even if it wasn't, the fact is that new additions that break major 
architectures _will_ be reverted. No ifs, buts or maybes about it. If new 
code shows itself to be broken, it's going to get reverted, and the sooner 
the better. And in this case, the code was not just slightly broken, it 
was totally non-working, in ways that made it clear that it had NEVER 
worked as intended.

			Linus

