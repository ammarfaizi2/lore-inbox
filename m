Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130900AbRCWOlj>; Fri, 23 Mar 2001 09:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131028AbRCWOla>; Fri, 23 Mar 2001 09:41:30 -0500
Received: from nilpferd.fachschaften.tu-muenchen.de ([129.187.176.79]:55538
	"HELO nilpferd.fachschaften.tu-muenchen.de") by vger.kernel.org
	with SMTP id <S130900AbRCWOlU>; Fri, 23 Mar 2001 09:41:20 -0500
Date: Fri, 23 Mar 2001 15:40:41 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: <bunk@pluto.fachschaften.tu-muenchen.de>
To: Admin Mailing Lists <mlist@intergrafix.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2-ac21 
In-Reply-To: <Pine.LNX.4.10.10103230910390.27532-100000@athena.intergrafix.net>
Message-ID: <Pine.NEB.4.33.0103231534460.26755-100000@pluto.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Admin Mailing Lists wrote:

> > >It was causing SMP boxes to crash mysteriously after
> > >several hours or days.  Quite a lot of them.  Nobody
> > >was able to explain why, so it was turned off.
> >
> > I know why it was turned off by default.  The annoying this is that now
> > the *only* way to activate the watchdog is via a boot command.  It is
> > not possible to compile a standard debugging kernel with this option
> > turned on, you have to rely on every user setting the boot options for
> > every kernel.  If it is going to be off by default there should be a
> > way to patch the kernel to make it on by default.
> >
>
> i'm troubled by that fact that something the would be used to debug the
> kernel, is something that actually causes crashes. doesn't that kind of
> defeat the purpose..and introduce just another unstable element to the
> problem/crash at hand?


I had some unreproducable system crashes with NO watchdog and NO SMP
enabled that do no longer occure since I compile my kernels without
CONFIG_DEBUG_KERNEL. I don't know if it this is related, but there seems
to be a problem in one of the "Kernel hacking" options that isn't related
to watchdog or SMP.


> -Tony

cu
Adrian

-- 

Nicht weil die Dinge schwierig sind wagen wir sie nicht,
sondern weil wir sie nicht wagen sind sie schwierig.

