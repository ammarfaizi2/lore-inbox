Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTIGNyS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 09:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263251AbTIGNyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 09:54:18 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:50318 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263250AbTIGNyR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 09:54:17 -0400
Date: Sun, 7 Sep 2003 14:53:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, nagendra_tomar@adaptec.com,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Kars de Jong <jongk@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030907135337.GF19977@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309032134040.25093-100000@localhost.localdomain> <1062674382.21667.32.camel@dhcp23.swansea.linux.org.uk> <20030905212420.GD220@elf.ucw.cz> <20030906230911.GA12392@mail.jlokier.co.uk> <20030907131010.GB18067@atrey.karlin.mff.cuni.cz> <20030907133543.GD19977@mail.jlokier.co.uk> <20030907134020.GC18067@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030907134020.GC18067@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Perhaps weak ordering matters when you are writting to the MMIO, too?

Perhaps, but the code in arch/i386/kernel/cpu/centaur.c seems to try
hard to set weak ordering for RAM, not the whole address space.

-- Jamie
