Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131880AbQLQLSR>; Sun, 17 Dec 2000 06:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132471AbQLQLSH>; Sun, 17 Dec 2000 06:18:07 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:63759 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131880AbQLQLR4>; Sun, 17 Dec 2000 06:17:56 -0500
Date: Sun, 17 Dec 2000 04:47:29 -0600
To: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: Anyone having trouble compiling test13-pre1?
Message-ID: <20001217044729.T3199@cadcamlab.org>
In-Reply-To: <20001214224403.B25589@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001214224403.B25589@one-eyed-alien.net>; from mdharm-kernel@one-eyed-alien.net on Thu, Dec 14, 2000 at 10:44:03PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Matthew Dharm]
> I'm having some problems with unresolved symbols in my modules with
> test13-pre1.  This worked just fine before, and the symbols are all
> stuff that I'm sure it there.
> 
> It looks like the modules were compiled for non-versioned symbols,
> while my kernel uses versioned symbols.  The modules are looking for
> things like daemonize, kmalloc, try_inc_mod_count, and other things
> I'd fully expect to be there.  /proc/ksyms shows them as
> __VERSIONED_SYMBOL(daemonize), so I'm not sure what to expect.

There are several MODVERSIONS fixes in test13-pre2.  The "old Makefiles
must die" project is still a WIP but getting there.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
