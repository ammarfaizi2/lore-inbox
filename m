Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262244AbSKCQbD>; Sun, 3 Nov 2002 11:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262273AbSKCQbD>; Sun, 3 Nov 2002 11:31:03 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:29239 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262244AbSKCQbC>; Sun, 3 Nov 2002 11:31:02 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200211031636.gA3GakF14660@devserv.devel.redhat.com>
Subject: Re: swsusp: don't eat ide disks
To: benh@kernel.crashing.org
Date: Sun, 3 Nov 2002 11:36:46 -0500 (EST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), alan@redhat.com (Alan Cox),
       pavel@ucw.cz (Pavel Machek), torvalds@transmeta.com (Linus Torvalds),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20021103162422.27845@smtp.wanadoo.fr> from "benh@kernel.crashing.org" at Nov 03, 2002 05:24:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >		Jump to PM layer "power off" logic
> >
> >If you do it that way up then no drivers need to be hacked about.
> 
> Hrm... thanks to the miracle of having a BIOS that will deal
> with the grunt work of actually shutting down the chipsets,
> resuming them, etc...

As I said "jump to PM layer power off logic"

So after you have suspended you neatly power it all off

> I really don't like the above as it basically bypasse the
> bus ordering, which is the only sane way I see to deal with
> dependencies when the drivers are actually shutting down HW

Bus ordering applies to power off not to suspend to disk sequence

> Then, I volunteer writing a HOWTO explaining clearly what a
> driver should do for proper PM, and I'm pretty sure that won't
> be that nasty and race prone as you are afraid of ;)

Good. It'll be nice to have suspend to disk in 2.7
