Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSH0NEB>; Tue, 27 Aug 2002 09:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSH0NEB>; Tue, 27 Aug 2002 09:04:01 -0400
Received: from 24-148-63-229.na.21stcentury.net ([24.148.63.229]:21090 "HELO
	wotke.danapple.com") by vger.kernel.org with SMTP
	id <S315279AbSH0NEA>; Tue, 27 Aug 2002 09:04:00 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1[89] boot problem 
In-Reply-To: Your message of "Fri, 23 Aug 2002 01:07:11 CDT."
             <20020823060716.020F1107D9@wotke.danapple.com> 
From: "Daniel I. Applebaum" <kernel@danapple.com>
Date: Tue, 27 Aug 2002 08:08:05 -0500
Message-Id: <20020827130810.1A04F111F0@wotke.danapple.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been tracking down my booting problem, and while reviewing old
email, found that in trying to track down (and never succeeding) a VM
problem last fall, I determined that any kernel after 2.4.15-pre2
would not boot on my machine.  So, something changed between
2.4.15-pre2 and 2.4.15-pre3 that means linux will not boot.  The
symptom is that the boot sequence displays "Loading linux-2.4.19..."
but never display "Uncompressing".  I've enclosed the 2.4.15-pre3
Changelog.  Any ideas which of the changes would have affected
booting?

pre3:
 - Al Viro: sanity-check user arguments, zero-terminated strings etc.
 - Urban Widmark: smbfs update (server/client cache coherency etc)
 - Rik van Riel, Marcelo Tosatti: VM updates
 - Cort Dougan: PPC updates
 - Neil Brown: raid1/5 failed drive fixups, NULL ptr checking, md error cleanup
 - Neil Brown: knfsd fix for 64-bit architectures, and filehandle resolveir
 - Ken Brownfield: workaround for menuconfig CPU selection glitch
 - David Miller: sparc64 MM setup fix, arpfilter forward port
 - Keith Owens: Remove obsolete IPv6 provider based addressing
 - Jari Ruusu: block_write error case cleanup fix
 - Jeff Garzik: netdriver update

Thanks!

Dan.
