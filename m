Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261182AbRELFTg>; Sat, 12 May 2001 01:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261183AbRELFT0>; Sat, 12 May 2001 01:19:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56990 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261182AbRELFTT>;
	Sat, 12 May 2001 01:19:19 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15100.51153.711892.548545@pizda.ninka.net>
Date: Fri, 11 May 2001 22:19:13 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mauelshagen@sistina.com,
        linux-kernel@vger.kernel.org, mge@sistina.com
Subject: Re: LVM 1.0 release decision
In-Reply-To: <20010512045456.E8259@athlon.random>
In-Reply-To: <20010511162745.B18341@sistina.com>
	<E14yDyI-0000yE-00@the-village.bc.nu>
	<20010511171124.M30355@athlon.random>
	<15100.18375.367656.3591@pizda.ninka.net>
	<20010512032453.A8259@athlon.random>
	<15100.37367.477922.66043@pizda.ninka.net>
	<20010512045456.E8259@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > you _must_ know very well what the mainteinance of that code means ;).

Which is why I added the facility by which such ioctl conversions can
be registered at runtime by the subsystem/driver itself.

 > BTW, it would be nice if somebody would take care of unifying the
 > large sharable parts of the emulation code between
 > x86-64/sparc64/ia64/mips64, this was mentioned by Andi several times but
 > nothing is been done in that direction yet, they for large part do the
 > same things and somehow we duplicate efforts across all those ports (if
 > we exclude the regs maniuplation in the ELF_PLAT_DATA and friends that
 > can be localized easily). If we do that kind of sharing all the other
 > ports would probably get the 32bit emulation for the lvm ioctl for free
 > from the sparc64 effort for example.

I'm already planning on doing this, but it is a 2.5.x project.
Dave Mosberger agrees with this as has anyone else I've mentioned
the idea to, so consider it basically done in 2.5.x sometime.

Later,
David S. Miller
davem@redhat.com
