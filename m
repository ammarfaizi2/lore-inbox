Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbTICHpz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 03:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbTICHpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 03:45:55 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:55717 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S261588AbTICHpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 03:45:54 -0400
Date: Wed, 3 Sep 2003 09:45:24 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: keyboard - was: Re: Linux 2.6.0-test4
Message-ID: <20030903074524.GJ29858@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030831120605.08D6.CHRIS@heathens.co.nz> <20030902080733.GA14380@charite.de> <20030902124717.B1221@pclin040.win.tue.nl> <20030902123252.GC22365@charite.de> <20030902234133.A1627@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902234133.A1627@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andries Brouwer <aebr@win.tue.nl>:

> > > > atkbd.c: Unknown key (set 2, scancode 0x9c, on isa0060/serio0) pressed.
> > > > i8042 history: e0 d0 1c 9c 2e ae 10 90 e0 50 e0 d0 e0 d0 1c 9c
> 
> Well, that shows that this particular problem was solved, but there are
> more problems. No doubt we'll understand everything eventually.

Thanks. And I'm happy to apply your patches to my shitty laptop :)
 
> (Unless we remove this i8042_unxlate_seen before understanding all problems.
> It is really very ugly to have two different arrays that both keep the
> "key down" status of the keys, and that can get out of sync.)
> 
> Again, of course, I would like to see the past few dozen scancodes, like you
> gave before, up to the moment the problem arises.
> (If you cannot think of something better, just log every incoming scancode.)

Right now I keep running the laptop with your patch and the keycode
history patch.

Anything in particular that I should do?

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
