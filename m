Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbUDGKjn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 06:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbUDGKjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 06:39:43 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:3026 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S262473AbUDGKjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 06:39:41 -0400
Date: Wed, 7 Apr 2004 12:39:34 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5: keyboard lockup on a Toshiba laptop
Message-ID: <20040407103934.GG20293@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200404071222.21397.rjwysocki@sisk.pl> <Pine.LNX.4.58.0404071227430.10871@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0404071227430.10871@alpha.polcom.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Grzegorz Kulewski <kangur@polcom.net>:

> > FYI, I've just had a keyboard lockup on a Toshiba laptop (Satellite 1400-103) 
> > with the 2.6.5 kernel.

I've seen the very same on 2.6.5-rc3 as well!
Toshiba Satellite Pro 6100

> Was anything in your logs about that?
> 
> I think that maybe you should disable PREEMPTION.

I see these problems without preemption.

> Or use different distribution than RH9. They often modify gcc and other 
> programs, maybe even X - maybe try to compile your kernel on "vanilla" gcc 
> 3.3.3. I can give you a shell on computer with Gentoo and working gcc. Or 
> change distribution: Gentoo works ok for me and my friends! :-)

Debian

>From dmesg:
input: AT Translated Set 2 keyboard on isa0060/serio0
input: AT Translated Set 2 keyboard on isa0060/serio0
input: AT Translated Set 2 keyboard on isa0060/serio0
input: AT Translated Set 2 keyboard on isa0060/serio0
input: AT Translated Set 2 keyboard on isa0060/serio0
input: AT Translated Set 2 keyboard on isa0060/serio0

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
