Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbTABBMh>; Wed, 1 Jan 2003 20:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbTABBMh>; Wed, 1 Jan 2003 20:12:37 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:61374 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S265275AbTABBMg>; Wed, 1 Jan 2003 20:12:36 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Paul Jakma <paul@clubi.ie>
Cc: Rik van Riel <riel@conectiva.com.br>, Hell.Surfers@cwctv.net,
       linux-kernel@vger.kernel.org, rms@gnu.org
Date: Wed, 1 Jan 2003 17:08:26 -0800 (PST)
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
In-Reply-To: <Pine.LNX.4.44.0301012356270.8691-100000@fogarty.jakma.org>
Message-ID: <Pine.LNX.4.44.0301011706400.21656-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well libc uses the kernel headers and basicly all userspace programs use
libc so that makes oracle a derivitive work of the kernel??????

luckly that's not how things actually work.

David Lang

On Thu, 2 Jan 2003, Paul Jakma wrote:

> Date: Thu, 2 Jan 2003 00:31:13 +0000 (GMT)
> From: Paul Jakma <paul@clubi.ie>
> To: Rik van Riel <riel@conectiva.com.br>
> Cc: Hell.Surfers@cwctv.net, linux-kernel@vger.kernel.org, rms@gnu.org
> Subject: Re: Why is Nvidia given GPL'd code to use in closed source
>     drivers?
>
> On Wed, 1 Jan 2003, Rik van Riel wrote:
>
> > Copyright law is pretty explicit about the situations the GPL
> > applies to.  If something can be reasonably considered to be a
> > "derivative work" of a GPL work, the GPL applies and the new work
> > needs to be GPL.
>
> and:
>
> > but only a song.  If nvidia's driver only uses some simple
> > declarations from include files and no large (>7 lines? >10lines?
> > what's large?) inline functions AND the nvidia driver uses only the
> > standard interfaces to hook into the Linux kernel, then it's not a
> > derivative work and nvidia gets to choose the license.
>
> It has long been held that linking to GPL code is suffient to
> consitute 'derived work' status, hence the existence of the LGPL.
>
> The NVidia shim makes use of several kernel subsystems, the PCI
> device layer, the VM, the module system (well really, the kernel
> makes of use of the functions the module provides :) ), IRQ
> subsystem, the VFS, etc.. These systems are rather large bodies of
> code - without which the NVidia kernel driver could not work.
>
> So I am not quite sure on what basis one could argue the NVidia
> driver is not a derivative work, and hence it seems to me the NVidia
> driver is technically in material breach of GPL.
>
> You seem to be basing your opinion on:
>
>  "the nvidia driver uses only the standard interfaces to hook into
>  the Linux kernel"
>
> How are the standard interfaces not covered by the GPL?
>
> I know Linus' has often posted to l-k that he doesnt care about
> binary only modules as long as they stick to the exported interfaces.
> However, are all the kernel developers agreed on this? And if so, can
> this exception be formalised and put into the COPYING file? If not,
> then is NVidia not in breach of the kernel's licence?
>
> > Rik
>
> regards,
> --
> Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
> 	warning: do not ever send email to spam@dishone.st
> Fortune:
> Programmers do it bit by bit.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
