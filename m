Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbSKCWO2>; Sun, 3 Nov 2002 17:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbSKCWO2>; Sun, 3 Nov 2002 17:14:28 -0500
Received: from pasky.ji.cz ([62.44.12.54]:17656 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S262450AbSKCWO1>;
	Sun, 3 Nov 2002 17:14:27 -0500
Date: Sun, 3 Nov 2002 23:20:54 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jos Hulzink <josh@stack.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Petition against kernel configuration options madness...
Message-ID: <20021103222054.GC20338@pasky.ji.cz>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	Jeff Garzik <jgarzik@pobox.com>, Jos Hulzink <josh@stack.nl>,
	linux-kernel@vger.kernel.org
References: <200211031809.45079.josh@stack.nl> <3DC56270.8040305@pobox.com> <20021103200704.A8377@ucw.cz> <20021103193734.GC2516@pasky.ji.cz> <20021103211308.B8636@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103211308.B8636@ucw.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Nov 03, 2002 at 09:13:08PM CET, I got a letter,
where Vojtech Pavlik <vojtech@suse.cz> told me, that...
> On Sun, Nov 03, 2002 at 08:37:34PM +0100, Petr Baudis wrote:
> > Dear diary, on Sun, Nov 03, 2002 at 08:07:05PM CET, I got a letter,
> > where Vojtech Pavlik <vojtech@suse.cz> told me, that...
> > > Too bad you don't have any suggestions. I completely agree this should
> > > be simplified, while I wouldn't be happy to lose the possibility of not
> > > compiling AT keyboard support in.
> > 
> > Well, why can't it be enabled by default? Other options are as well, and it's
> > IMHO sane to enable keyboard and mice support by default. It should clear up
> > the initial confusion as well.
> 
> All the needed options ARE enabled by default. (check arch/i386/defconfig)

Yes, but if this will be in the Kconfig as well (I mean adding "default y"
lines, I can make a patch, if there's a desire), it will be offered as default
even when doing make oldconfig, which is what most of the people is going to do
(not make defconfig, most of people doesn't even know it exists and the rest
probably wants to configure 2.5 based on their 2.4 configuration anyway).

-- 
 
				Petr "Pasky" Baudis
.
This host is a black hole at HTTP wavelengths. GETs go in, and nothing
comes out, not even Hawking radiation.
                -- Graaagh the Mighty on rec.games.roguelike.angband
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
