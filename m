Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbTAPMzR>; Thu, 16 Jan 2003 07:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbTAPMzR>; Thu, 16 Jan 2003 07:55:17 -0500
Received: from [66.70.28.20] ([66.70.28.20]:16910 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S267048AbTAPMzR>; Thu, 16 Jan 2003 07:55:17 -0500
Date: Thu, 16 Jan 2003 13:58:43 +0100
From: DervishD <raul@pleyades.net>
To: Jon Burgess <Jon_Burgess@eur.3com.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030116125843.GD1358@DervishD>
References: <80256CB0.003F4ECF.00@notesmta.eur.3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80256CB0.003F4ECF.00@notesmta.eur.3com.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jon :)

> It is easy to do a mount() system call, the rootfs can be ro.

    Yes, but you still need a mountpoint. Lot of worries for
something as trivial and useless as changing the ps identity ;))

> > What if /proc/self/exe is not part form procfs,
> > but from some evil user ;))
> Would the user not need root privilegdes to mess with /proc?

    /proc/self/exe doesn't need to be in procfs... If proc is not
mounted... Anyway it was just an example. The degree of evil-user
intrusion in a machine for doing something like that is quite high.
There are simpler ways of attacking a machine if you can forge
/proc/self/exe :))

> Is there any good reason why init should not be executable
> by root only?

    My init refuses to run if not called by the superuser ;) because
I think the same as you and anyway my init doesn't need a shutdown
command, it works with a keycombo that root controls.

    Raúl
