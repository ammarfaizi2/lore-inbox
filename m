Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129806AbRAFKCt>; Sat, 6 Jan 2001 05:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130407AbRAFKCj>; Sat, 6 Jan 2001 05:02:39 -0500
Received: from jalon.able.es ([212.97.163.2]:36008 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129806AbRAFKCX>;
	Sat, 6 Jan 2001 05:02:23 -0500
Date: Sat, 6 Jan 2001 11:02:15 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: drew@drewb.com
Cc: evaner@bigfoot.com, linux-kernel@vger.kernel.org
Subject: Re: The advantage of modules?
Message-ID: <20010106110215.C4393@werewolf.able.es>
In-Reply-To: <20010105225020.A1188@evaner.penguinpowered.com> <14934.44472.612519.658729@champ.drew.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <14934.44472.612519.658729@champ.drew.net>; from drew@drewb.com on Sat, Jan 06, 2001 at 06:31:36 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.06 Drew Bertola wrote:
> My best reasons are...
> 
> Development: You don't have to recompile the kernel a billion times
> while working on a driver, you just recompile the module.  Also, you
> can debug, unload, fix, recompile, reload a module to add or fix
> pieces of it all (hopefully) without rebooting.
> 
> Practical usage: When I take my laptop on the road I use ppp, so I
> load it then.  Most of the time I don't need it, so I don't load it.
> 

Usage: I have seen drivers which require params to work, and you can
only give params if the driver is built as a module (ie,
modprobe xxxxxx io=0x300 irq=5, etc...) because your hard is not
properly autodetected by the module.

-- 
J.A. Magallon                                         $> cd pub
mailto:jamagallon@able.es                             $> more beer

Linux werewolf 2.4.0-ac2 #6 SMP Sat Jan 6 01:38:26 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
