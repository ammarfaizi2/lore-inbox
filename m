Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292390AbSBUOak>; Thu, 21 Feb 2002 09:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292391AbSBUOab>; Thu, 21 Feb 2002 09:30:31 -0500
Received: from [208.29.163.248] ([208.29.163.248]:46335 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S292390AbSBUOaR>; Thu, 21 Feb 2002 09:30:17 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: andersen@codepoet.org, Roman Zippel <zippel@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Date: Thu, 21 Feb 2002 06:28:34 -0800 (PST)
Subject: Re: linux kernel config converter
In-Reply-To: <3C74F46F.FEA6F63D@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0202210626210.8696-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. does this handle the cross directory dependancies?

2. does it handle the 'I want this feature, turn on everything I need for
it'?

3. if it handles #2 what does it do if you turn off that feature again
(CML2 turns off anything it turned on to support that feature, assuming
nothing else needs it)

David Lang


On Thu, 21 Feb 2002, Jeff Garzik wrote:

> Date: Thu, 21 Feb 2002 08:21:51 -0500
> From: Jeff Garzik <jgarzik@mandrakesoft.com>
> To: andersen@codepoet.org
> Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
> Subject: Re: linux kernel config converter
>
> Erik Andersen wrote:
> > I like this.  It's simple, its clean, and it keeps all the
> > information in one spot.  I think we can go a bit farther here
> > and add in a list of the .c files that enabling this feature
> > should add to the Makefile (per the current
> >     obj-$(CONFIG_FOO)            += foo.o
> > stuff in the current Makefile).
>
> Hey, you're skipping ahead to the cool chapters!
>
> Seriously, yep, that's exactly where we eventually want to be:  all
> config, makefile, and help text info in one place.  To add a new net
> driver, I want to be able to simply add two files, driver.c and
> driver.conf, and be done with it.
>
> 	Jeff
>
>
>
> --
> Jeff Garzik      | "Why is it that attractive girls like you
> Building 1024    |  always seem to have a boyfriend?"
> MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
>                  |             - BBC TV show "Coupling"
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
