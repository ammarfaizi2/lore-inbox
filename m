Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130669AbRAHQtj>; Mon, 8 Jan 2001 11:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131119AbRAHQtT>; Mon, 8 Jan 2001 11:49:19 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:22534 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S130669AbRAHQtQ>; Mon, 8 Jan 2001 11:49:16 -0500
Date: Mon, 8 Jan 2001 11:49:29 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: drew@drewb.com, evaner@bigfoot.com, linux-kernel@vger.kernel.org
Subject: Re: The advantage of modules?
Message-ID: <20010108114929.B11682@munchkin.spectacle-pond.org>
In-Reply-To: <20010105225020.A1188@evaner.penguinpowered.com> <14934.44472.612519.658729@champ.drew.net> <20010106110215.C4393@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010106110215.C4393@werewolf.able.es>; from jamagallon@able.es on Sat, Jan 06, 2001 at 11:02:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 11:02:15AM +0100, J . A . Magallon wrote:
> 
> On 2001.01.06 Drew Bertola wrote:
> > My best reasons are...
> > 
> > Development: You don't have to recompile the kernel a billion times
> > while working on a driver, you just recompile the module.  Also, you
> > can debug, unload, fix, recompile, reload a module to add or fix
> > pieces of it all (hopefully) without rebooting.
> > 
> > Practical usage: When I take my laptop on the road I use ppp, so I
> > load it then.  Most of the time I don't need it, so I don't load it.
> > 
> 
> Usage: I have seen drivers which require params to work, and you can
> only give params if the driver is built as a module (ie,
> modprobe xxxxxx io=0x300 irq=5, etc...) because your hard is not
> properly autodetected by the module.

For many devices you can specify the parameters at boot time if you use
something like lilo to boot.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
