Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267597AbTAGXVm>; Tue, 7 Jan 2003 18:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267598AbTAGXVm>; Tue, 7 Jan 2003 18:21:42 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3567 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267597AbTAGXVk>; Tue, 7 Jan 2003 18:21:40 -0500
Date: Wed, 8 Jan 2003 00:30:12 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>, Robert Love <rml@tech9.net>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: observations on 2.5 config screens
Message-ID: <20030107233012.GP6626@fs.tum.de>
References: <Pine.LNX.4.44.0301011435300.27623-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301011435300.27623-100000@dell>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2003 at 02:55:01PM -0500, Robert P. J. Day wrote:
>...
> Processor family
> 
>     It seems that the final option, "Preemptible kernel", does
>   not belong there.  In fact, there seem to be a number of 
>   kernel-related, kind of hacking/debugging options, that
>   could be collected in one place, like preemption, sysctl,
>   hacking, executable file formats, etc.  "Low-level kernel
>   options", perhaps?
>...

Robert, could you comment on whether it's really needed to have the 
preemt option defined architecture-dependant?

After looking through the arch/*/Kconfig files it seems to me that the
most problematic things might be architecture-specific parts of other
architecturs that don't even offer PREEMPT and the depends on CPU_32 in
arch/arm/Kconfig.

>   anyway, just some observations from someone who doesn't
> know any better.

IMHO your comments are very valuable.

> rday

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

