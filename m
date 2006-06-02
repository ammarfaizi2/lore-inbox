Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWFBRb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWFBRb2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 13:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWFBRb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 13:31:28 -0400
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:34521 "EHLO
	gw01.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S1751312AbWFBRb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 13:31:27 -0400
Date: Fri, 2 Jun 2006 20:31:25 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
To: Dave Airlie <airlied@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060602173125.GA1366@sci.fi>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605302314.25957.dhazelton@enter.net> <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com> <200605310026.01610.dhazelton@enter.net> <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com> <20060601092807.GA7111@localhost.localdomain> <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com> <21d7e9970606011815y226ebb86ob42ec0421072cf07@mail.gmail.com> <pan.2006.06.02.04.34.36.227639@sci.fi> <21d7e9970606012319s292759bbm6c046f09d6bf5826@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21d7e9970606012319s292759bbm6c046f09d6bf5826@mail.gmail.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 04:19:55PM +1000, Dave Airlie wrote:
> >>> Without specifying a design here are a few requirements I would have:
> >>>
> >>> 1) The kernel subsystem should be agnostic of the display server. The
> >>> solution should not be X specific. Any display system should be able
> >>> to use it, SDL, Y Windows, Fresco, etc...
> >>
> >> of course, but that doesn't mean it can't re-use X's code, they are
> >> the best drivers we have. you forget everytime that the kernel fbdev
> >> drivers aren't even close, I mean not by a long long way apart from
> >> maybe radeon.
> >
> >matroxfb is clearly better than the X driver. atyfb too IMO.
> 
> Okay maybe matroxfb, but if atyfb is the mach64, it really isn't as
> good, the last few times I tried it,

When was that exactly, and what kernel? I've been using atyfb+DirectFB 
exclusively for a few years with chips ranging from VT2 to Rage 
Mobility.

> it just made my LCD bloom, X
> worked,

The X driver probably doesn't touch as much of the hardware as atyfb.

> mach64 is probably the most complex thing as there must be at
> least 15 variations on the theme.... mach64 isn't a chip family so
> much as a chip tribe... I've since burned my mach64 as a sacrifice....

If you ignore the pre-CT chps it isn't too bad.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/
