Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282260AbRKWW1L>; Fri, 23 Nov 2001 17:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282266AbRKWW1A>; Fri, 23 Nov 2001 17:27:00 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:61708 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S282260AbRKWW0t>; Fri, 23 Nov 2001 17:26:49 -0500
Message-ID: <3BFECCA6.7459DCAB@linux-m68k.org>
Date: Fri, 23 Nov 2001 23:24:38 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dalecki@evision.ag
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.15-pre6 idt compilation and proc_misc cleanup.
In-Reply-To: <87y9l58pb5.fsf@fadata.bg> <200111171920.fAHJKjJ01550@penguin.transmeta.com> <3BFA6B1A.D91C5703@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Martin Dalecki wrote:

> 2. Killing some code which is dead since ages in proc_misc.c
> [..]
> -#ifdef CONFIG_PROC_HARDWARE
> -               {"hardware",    hardware_read_proc},
> -#endif
> -#ifdef CONFIG_STRAM_PROC
> -               {"stram",       stram_read_proc},
> -#endif

Unfortunately I see this only now, but this isn't dead at all, it's just
not used on i386, please grep more carefully next time.

bye, Roman
