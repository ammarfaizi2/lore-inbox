Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129489AbRBCX1L>; Sat, 3 Feb 2001 18:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129758AbRBCX1B>; Sat, 3 Feb 2001 18:27:01 -0500
Received: from felix.convergence.de ([212.84.236.131]:1297 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S129489AbRBCX0o>;
	Sat, 3 Feb 2001 18:26:44 -0500
Date: Sun, 4 Feb 2001 00:26:27 +0100
From: Felix von Leitner <leitner@convergence.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
Message-ID: <20010204002627.A9527@convergence.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E14OoD8-0007GI-00@the-village.bc.nu> <3A7BC808.E9BF5B44@linux.com> <20010203110053.C1766@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010203110053.C1766@werewolf.able.es>; from jamagallon@able.es on Sat, Feb 03, 2001 at 11:00:53AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake J . A . Magallon (jamagallon@able.es):
> > How about a simple patch to the top level makefile that checks the gcc
> > version then prints a distinct message ..'this compiler hasn't been approved
> > for compiling the kernel', sleeping for one second, then continuing on.  This
> > solution doesn't stop compiling and makes a visible indicator without forcing
> > anything.
> Or a config option like CONFIG_TRUSTED_COMPILER, and everyone that wants
> can bracket his code in 'if [ $TRUSTED = "y" ] ... fi', so if some driver-fs
> fails with untrusted compilers it is just not selectable.

What kind of crap is this?
It is not the kernel's job to work around RedHat bugs.
If RedHat ships a broken compiler, it is their responsibility to tell
their customers and provide a working one.

This kind of compatibility crap has caused commercial Unices to
suffocate in their own bloat.  We don't need this.  And we don't want
this.

Felix
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
