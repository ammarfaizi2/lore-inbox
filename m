Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262064AbSJHLuY>; Tue, 8 Oct 2002 07:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262096AbSJHLuY>; Tue, 8 Oct 2002 07:50:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60655 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262064AbSJHLuY>; Tue, 8 Oct 2002 07:50:24 -0400
Date: Tue, 8 Oct 2002 13:56:00 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>, <James.Bottomley@HansenPartnership.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.41-ac1
In-Reply-To: <200210080003.g9803T010141@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0210081352470.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Alan Cox wrote:

>....
> Linux 2.5.40-ac1
>...
> +	Voyager support					(James Bottomley)
>...

It seems at least one file is missing, the following compile error occurs
when trying to compile 2.5.41-ac1 with both CONFIG_VOYAGER and CONFIG_SMP
enabled:

<--  snip  -->

...
make[1]: *** No rule to make target `arch/i386/mach-voyager/trampoline.o',
needed by `arch/i386/mach-voyager/built-in.o'.  Stop.
make: *** [arch/i386/mach-voyager] Error 2

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

