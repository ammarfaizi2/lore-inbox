Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268479AbTBNVXF>; Fri, 14 Feb 2003 16:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268465AbTBNVUq>; Fri, 14 Feb 2003 16:20:46 -0500
Received: from [81.2.122.30] ([81.2.122.30]:14088 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S268409AbTBNVUd>;
	Fri, 14 Feb 2003 16:20:33 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302142131.h1ELVX4U004986@darkstar.example.net>
Subject: Re: Sparc IDE in 2.4.20
To: zaitcev@redhat.com (Pete Zaitcev)
Date: Fri, 14 Feb 2003 21:31:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200302142106.h1EL6Do29394@devserv.devel.redhat.com> from "Pete Zaitcev" at Feb 14, 2003 04:06:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is IDE known to be broken on Sparc in 2.4.20?  I just got this compile
> > failiure:
> > sparc-linux-ld -T arch/sparc/vmlinux.lds arch/sparc/kernel/head.o
> > arch/sparc/kernel
> > drivers/ide/idedriver.o: In function `ide_end_drive_cmd':
> > drivers/ide/idedriver.o(.text+0x11d4): undefined reference to `inw_p'
> 
> I tested it in 2.4.7 for the last time. It probably bitrotted.
> Why do you care? I posess the only IDE capable sparc on this planet.
> Just configure it out, and be happy.

I'm thinking of building a machine based around Sun's Netra AX-1105
motherboard, which I thought had a supported IDE controller built in,
but I could be wrong.

> Are you sure you did not want to compile for sparc64, hint, hint?

Oh, I'm just testing my newly compiled Sparc cross compiler :-), I
will be compiling for sparc64 eventually.  I've decided not to use any
Linux distribution on the new box, and instead just to build it up
from scratch, but at the moment, I'm still trying to build a native
Sparc GCC on an X86 box, (as opposed to a cross-compiler). 

John.
