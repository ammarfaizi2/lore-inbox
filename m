Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316837AbSFKGAB>; Tue, 11 Jun 2002 02:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316840AbSFKGAA>; Tue, 11 Jun 2002 02:00:00 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:43471 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316837AbSFKGAA>;
	Tue, 11 Jun 2002 02:00:00 -0400
Date: Tue, 11 Jun 2002 07:56:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Chris Faherty <rallymonkey@bellsouth.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Logitech Mouseman Dual Optical defaults to 400cpi
Message-ID: <20020611075643.C6425@ucw.cz>
In-Reply-To: <20020608165243Z317422-22020+923@vger.kernel.org> <200206101057.20259.bhards@bigpond.net.au> <20020610232637.A4589@ucw.cz> <20020611045213.8B1FA59D354@kerberos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 12:52:52AM -0400, Chris Faherty wrote:
> On Monday 10 June 2002 05:26 pm, Vojtech Pavlik wrote:
> 
> > Intellimouse 1.0 uses Agilent HDNS-2000, 2.0 uses ADNS-2001, and 3.0
> > uses a chip made by SGS Thompson, under a secret contract with Microsoft
> > that has only 400 dpi, but up to one meter per second maximal tracking
> > speed.
> 
> Hmm interesting, that Microsoft has no 800dpi mouse.  Glad I picked Logitech 
> then.  I assumed they were equivalent resolution since most reviews give the 
> Intellimouse the nod, but I don't know how the heck a 400dpi can compete 
> with a 800dpi.

Simply: If you move the Logitech too fast, it'll lose track. The reason
why the Duial Optical has two sensors to help exactly this problem - a
diagonally oriented sensor can cope up with 41% faster movement.

Thus they get about 50 centimeters per second maximum tracking speed. If
you move the mouse fast, it'll lose track, and the pointer will move
randomly.

With the Explorer 3.0, it's almost impossible to get it lose track, at
100 centimeters/second maximum tracking speed.

It might be that due to the 800 dpi resolution you won't need to move it
so fast ...

> Running the Logitech @ 800 on a black surface, it's flawless.  I just can't 
> get it to fail a twitch test, despite having fewer pictures per second.  I 
> did notice it doing a little pixel dance one time on a blue pad, but it's 
> not ever done that with my black vinyl surface.

Btw, for more frequent reporting it's enough to modify the irq interrupt
rate in the HID driver, works for any mouse.

-- 
Vojtech Pavlik
SuSE Labs
