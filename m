Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264073AbUE3QVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbUE3QVG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 12:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUE3QVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 12:21:06 -0400
Received: from main.gmane.org ([80.91.224.249]:39114 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264073AbUE3QUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 12:20:35 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: SERIO_USERDEV patch for 2.6
Date: Sun, 30 May 2004 18:10:52 +0200
Message-ID: <MPG.1b2425f8267124609896ab@news.gmane.org>
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de> <xb7aczq9he1.fsf@savona.informatik.uni-freiburg.de> <20040530134246.GA1828@ucw.cz> <200405301009.21202.dtor_core@ameritech.net> <20040530155821.GC1479@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-78-129.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Sun, May 30, 2004 at 10:09:18AM -0500, Dmitry Torokhov wrote:
> 
> > On Sunday 30 May 2004 08:42 am, Vojtech Pavlik wrote:
> > > 
> > > Anyway, looking at the patch, it's not bad, and it's quite close to what
> > > I was considering to write. I'd like to keep it separate from the
> > > serio.c file, although it's obvious it'll require to be linked to it
> > > statically, because it needs hooks there - it cannot be a regular serio
> > > driver.
> > > 
> > 
> > Do we really have to have this stuff directly in serio? How about being able
> > to mark some serio ports as working in raw mode (i8042.raw=0,1,1,0) and have
> > separate (serio_raw?) module bind to such ports
> 
> We don't have to. But it'd be rather convenient to have it. It would
> work for all serio ports, not just i8042, etc, etc.
> 
> And if kept in a separate file (serio-dev.c), it wouldn't mess up things
> too much.

I'm starting to get nervous about testing this stuff ... do you 
think it will it make to 2.6.7? :)

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

