Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVADRbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVADRbm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 12:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVADRbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 12:31:37 -0500
Received: from styx.suse.cz ([82.119.242.94]:21719 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261811AbVADRbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 12:31:03 -0500
Date: Tue, 4 Jan 2005 18:32:01 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [bk patches] Long delayed input update
Message-ID: <20050104173201.GB13623@ucw.cz>
References: <20041227142821.GA5309@ucw.cz> <200412271419.46143.dtor_core@ameritech.net> <20050103131848.GH26949@ucw.cz> <Pine.LNX.4.58.0501032148210.2294@ppc970.osdl.org> <20050104135859.GA9167@ucw.cz> <Pine.LNX.4.58.0501040756230.2294@ppc970.osdl.org> <20050104160830.GA13125@ucw.cz> <Pine.LNX.4.58.0501040812420.2294@ppc970.osdl.org> <20050104164025.GA13240@ucw.cz> <d120d50005010409223df70973@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005010409223df70973@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 12:22:17PM -0500, Dmitry Torokhov wrote:
> On Tue, 4 Jan 2005 17:40:25 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Tue, Jan 04, 2005 at 08:14:52AM -0800, Linus Torvalds wrote:
> > 
> > > Ok. I'll re-pull and make it embedded to make that irritating question go
> > > away.
> > 
> > Thanks.
> > 
> 
> Ok, now only couple of things were left out:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110430679525030&w=2
> 08-atkbd-keycode-size.patch
> 	Fix keycode table size initialization that got broken by my changes
> 	that exported 'set' and other settings via sysfs.
> 	setkeycodes should work again now.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110430749420252&w=2
> 06-ps2pp-mouse-name.patch
> 	Set mouse name to "Mouse" instead of leaving it NULL when using
> 	PS2++ protocol and don't have any other information (Wheel, Touchpad)
> 	about the mouse.
> 
> 06 is not too critical but without 08 setkeycodes will not work.
> 
> In any case I'd like the following patches (01-08, see
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110430597110513&w=2) to
> be moved forward as they were also staged in -mm tree for over a month
> and work fine on my 3 boxes.
 
OK, I'll merge them, and prepare yet another pull for Linus.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
