Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311262AbSDBL6R>; Tue, 2 Apr 2002 06:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311424AbSDBL6G>; Tue, 2 Apr 2002 06:58:06 -0500
Received: from ns.suse.de ([213.95.15.193]:45584 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311262AbSDBL56>;
	Tue, 2 Apr 2002 06:57:58 -0500
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UP IO-APIC with ACPI table but no MP table?
In-Reply-To: <15529.39198.444056.901156@kim.it.uu.se.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 02 Apr 2002 13:57:54 +0200
Message-ID: <p731ydytirg.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> Is it possible to get the kernel to recognise and utilise the
> chipset's IO-APIC if the BIOS has no MP table but does list the
> IO-APIC in the ACPI table(s)?

The new Intel ACPI implementation now merged into 2.5 should support 
this. Of course it may still not work on your particular BIOS.

> If it's possible, is it also meaningful to do this on UP?

Using the IO-APIC makes a lot of sense, because it is a much more
efficient interface to the interrupt controller.

-Andi
