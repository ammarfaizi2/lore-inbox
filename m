Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277152AbRJQUgF>; Wed, 17 Oct 2001 16:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277154AbRJQUfz>; Wed, 17 Oct 2001 16:35:55 -0400
Received: from [209.195.52.30] ([209.195.52.30]:40228 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S277152AbRJQUfr>;
	Wed, 17 Oct 2001 16:35:47 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: pierre@lineo.com, linux-kernel@vger.kernel.org
Date: Wed, 17 Oct 2001 12:14:34 -0700 (PDT)
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <3BCDEAD9.DEC2415F@redhat.com>
Message-ID: <Pine.LNX.4.40.0110171213360.7368-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

but there is a difference between a 'binary only' module and a 'GPL
module'

the current process mixes the two up.

David Lang


On Wed, 17 Oct 2001, Arjan van de Ven wrote:

> Date: Wed, 17 Oct 2001 21:32:25 +0100
> From: Arjan van de Ven <arjanv@redhat.com>
> To: pierre@lineo.com, linux-kernel@vger.kernel.org
> Subject: Re: GPLONLY kernel symbols???
>
>
> > The real question is whether or not the kernel
> > code should be encumbered with legal issues. The
> > fact that this or that piece of code is or isn't GPL
> > should be in a text file attached to the kernel
> > tarball. This sort of thing has no place in the
> > code : countless patches with useful code that
> > should live in userland have been (rightfully)
> > rejected as having no place inside the kernel, why
> > should code that deals with legal issues and is
> > pretty much dead weight from a technical standpoint
> > be allowed in ?
>
> It's not legal issues. It's 1 integer and 1 sysctl variable
> that allow easy filtering of nvidia and other bugreports.
> THAT is the purpose of "tainted". Show in the oops that
> binary only modules are used. (this assumes all gpl modules to
> have a MODULE_LICENSE() line which doesn't result in code
> and isn't loaded into kernel memory; recent kernels have over 99%
> coverage for in-kernel drivers and lots of external drivers have
> it as well).
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
