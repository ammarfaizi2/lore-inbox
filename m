Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129853AbRB0UpG>; Tue, 27 Feb 2001 15:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129854AbRB0Uo5>; Tue, 27 Feb 2001 15:44:57 -0500
Received: from mail.inf.tu-dresden.de ([141.76.2.1]:32888 "EHLO
	mail.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S129853AbRB0Uol>; Tue, 27 Feb 2001 15:44:41 -0500
Date: Tue, 27 Feb 2001 21:44:40 +0100
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quick reboot on i386
Message-ID: <20010227214440.A31566@ugly.wh8.tu-dresden.de>
In-Reply-To: <20010226124931.A20095@ugly.wh8.tu-dresden.de> <20010227011325.A1798@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010227011325.A1798@bug.ucw.cz>; from pavel@suse.cz on Tue, Feb 27, 2001 at 01:13:25AM +0100
From: Oswald Buddenhagen <ob6@inf.tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > remember quarterdeck's quickreboot from "good" (*cough*) old D{o|O}S
> > days? here it is for linux! it's only of limited use, especially
> > in it's current state, but some people might find it useful.
> 
> Hmm, I'm probably going to apply this one, as I hate behaviour of my
> bios: if you power off during POST it will not come up next time
> asking for you to adjust CPU frequency.
> 
"nice" bios ... :-/
so now pray, that your hardware configuration allows a second boot
without being reset. (yes, this is the downside of qreboot).
to make it work always, we would need a "deep" reset of at least the 
pci and isa-pnp busses, presumably a chipset reset. sadly, i have
no idea, how to do this. possibly this would require an additional
reset function for every chipset. anyone can add something useful here?

best regards

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
--
Nothing is fool-proof to a sufficiently talented fool.
