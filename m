Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbUDGKvq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 06:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbUDGKvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 06:51:46 -0400
Received: from [80.72.36.106] ([80.72.36.106]:25054 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S262541AbUDGKvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 06:51:44 -0400
Date: Wed, 7 Apr 2004 12:51:39 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5: keyboard lockup on a Toshiba laptop
In-Reply-To: <20040407103934.GG20293@charite.de>
Message-ID: <Pine.LNX.4.58.0404071247120.10871@alpha.polcom.net>
References: <200404071222.21397.rjwysocki@sisk.pl>
 <Pine.LNX.4.58.0404071227430.10871@alpha.polcom.net> <20040407103934.GG20293@charite.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2004, Ralf Hildebrandt wrote:

> * Grzegorz Kulewski <kangur@polcom.net>:
> 
> > > FYI, I've just had a keyboard lockup on a Toshiba laptop (Satellite 1400-103) 
> > > with the 2.6.5 kernel.
> 
> I've seen the very same on 2.6.5-rc3 as well!
> Toshiba Satellite Pro 6100
> 
> > Was anything in your logs about that?
> > 
> > I think that maybe you should disable PREEMPTION.
> 
> I see these problems without preemption.
> 
> > Or use different distribution than RH9. They often modify gcc and other 
> > programs, maybe even X - maybe try to compile your kernel on "vanilla" gcc 
> > 3.3.3. I can give you a shell on computer with Gentoo and working gcc. Or 
> > change distribution: Gentoo works ok for me and my friends! :-)
> 
> Debian
> 
> From dmesg:
> input: AT Translated Set 2 keyboard on isa0060/serio0
> input: AT Translated Set 2 keyboard on isa0060/serio0
> input: AT Translated Set 2 keyboard on isa0060/serio0
> input: AT Translated Set 2 keyboard on isa0060/serio0
> input: AT Translated Set 2 keyboard on isa0060/serio0
> input: AT Translated Set 2 keyboard on isa0060/serio0

Did you see these messages 6 times at once? Was it after the boot process 
ended? They only appear at boot time for me (just once of course). Maybe 
your keyboard was disconnected or kernel was thinking that it was 
disconnected and connected again?...


Grzegorz

