Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270599AbRHNLzD>; Tue, 14 Aug 2001 07:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270586AbRHNLyQ>; Tue, 14 Aug 2001 07:54:16 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:11012 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S270581AbRHNLxk>; Tue, 14 Aug 2001 07:53:40 -0400
Date: Sat, 11 Aug 2001 11:57:37 +0000
From: Pavel Machek <pavel@suse.cz>
To: george anzinger <george@mvista.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        high-res-timers-discourse@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Schleef <ds@schleef.org>, Mark Salisbury <mbs@mc.com>,
        Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: No 100 HZ timer !
Message-ID: <20010811115737.B35@toy.ucw.cz>
In-Reply-To: <20010410193521.A21133@pcep-jamie.cern.ch> <E14n2hi-0004ma-00@the-village.bc.nu> <20010410202416.A21512@pcep-jamie.cern.ch> <3AD35EFB.40ED7810@mvista.com> <3B675682.3CE51A3D@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B675682.3CE51A3D@mvista.com>; from george@mvista.com on Tue, Jul 31, 2001 at 06:08:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The testing I have done seems to indicate a lower overhead on a lightly
> loaded system, about the same overhead with some load, and much more
> overhead with a heavy load.  To me this seems like the wrong thing to
> do.  We would like as nearly a flat overhead to load curve as we can get

Why? Higher overhead is a price for better precision timers. If you rounded
all times in "tickless" mode, you'd get about same overhead, right?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

