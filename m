Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135655AbRD1V0y>; Sat, 28 Apr 2001 17:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135654AbRD1VZ1>; Sat, 28 Apr 2001 17:25:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24198 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S133022AbRD1VYW>;
	Sat, 28 Apr 2001 17:24:22 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15083.13569.900956.701403@pizda.ninka.net>
Date: Sat, 28 Apr 2001 14:24:17 -0700 (PDT)
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPv4 NAT doesn't compile in 2.4.4
In-Reply-To: <20010428222145.I21792@flint.arm.linux.org.uk>
In-Reply-To: <20010428172554.H21792@flint.arm.linux.org.uk>
	<15083.12585.159124.505983@pizda.ninka.net>
	<20010428222145.I21792@flint.arm.linux.org.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Russell King writes:
 > >From x86 vmlinux.lds:
 > 
 >   /* Sections to be discarded */
 >   /DISCARD/ : {
 >         *(.text.exit)
 >         *(.data.exit)
 >         *(.exitcall.exit)
 >         }

Thanks, this is the part I didn't catch.  If you had said this in
the first email, I would have understood fully from the beginning.

Later,
David S. Miller
davem@redhat.com
