Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSJHPaB>; Tue, 8 Oct 2002 11:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbSJHPaB>; Tue, 8 Oct 2002 11:30:01 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3820 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261238AbSJHPaA>; Tue, 8 Oct 2002 11:30:00 -0400
Date: Tue, 8 Oct 2002 17:35:36 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.41-ac1 
In-Reply-To: <200210081501.g98F1DR02225@localhost.localdomain>
Message-ID: <Pine.NEB.4.44.0210081732250.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, James Bottomley wrote:

> bunk@fs.tum.de said:
> > make[1]: *** No rule to make target `arch/i386/mach-voyager/
> > trampoline.o', needed by `arch/i386/mach-voyager/built-in.o'.  Stop.
> > make: *** [arch/i386/mach-voyager] Error 2
>
> That one's pulled in from ../kernel by the vpath in mach-voyager (or should
> be).  It builds for me, so it could be the version of make you are using?

Ah, then Kai's changes to the build system in 2.5.41 broke it.

Kai, what's the recommended way to get this working again?

> James

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

