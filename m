Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266054AbTGMNUz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 09:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbTGMNUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 09:20:55 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:30868 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S266054AbTGMNUy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 09:20:54 -0400
Date: Sun, 13 Jul 2003 14:35:17 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Linus Torvalds <torvalds@transmeta.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030713133517.GD19132@mail.jlokier.co.uk>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net> <20030712225143.GA1508@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712225143.GA1508@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> And no escape. Doing something from keyboard is *ugly*. Magic sysrq is
> ugly, too, but its usefull enough to outweight that.

Can't you just use the Suspend button? :)

I'd be inclined to initiate suspend-to-disk when the laptop's lid is
closed, or when I press the suspend button if ACPI would be so
accomodating.  After closing the lid, if I change my mind there's only
two inputs I can do quickly: press the Suspend button, or open the
lid.  SysRq-Escape would take a couple of seconds longer due to
needing to open the lid.

Of those, I'd be worried about the fragile lid switch occasionally
bouncing as I moved the laptop, causing it to fail to suspend in my
bag.  The button is well protected.

-- Jamie
