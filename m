Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267594AbTAHAQW>; Tue, 7 Jan 2003 19:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267598AbTAHAQV>; Tue, 7 Jan 2003 19:16:21 -0500
Received: from cibs9.sns.it ([192.167.206.29]:39435 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S267594AbTAHAQU>;
	Tue, 7 Jan 2003 19:16:20 -0500
Date: Wed, 8 Jan 2003 01:24:45 +0100 (CET)
From: venom@sns.it
To: Matthias Andree <matthias.andree@gmx.de>
cc: linux-kernel@vger.kernel.org, <andre@linux-ide.org>
Subject: Re: Honest does not pay here ...
In-Reply-To: <20030107232820.GB24664@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.43.0301080059460.24706-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What really surprises me is that in this thread, nor in the other one about
NVIDIA module, none made a mantion about the 2.5 modules infrastructure
of next 2.6 kernels using runqueue instead of task queues and tasklets.

In very semplicistic words:
In 2.5/2.6 kernels, non GPL modules have a big
penalty, because they cannot create their own queue, but have to use a default
one.

(tasklets still remains, so that I can use with 2.5 kernel tha NVIDIA
modules with the patch fronm www.minion.de.)

I saw just a very defuse mention from Andre Hedrick.

That would be an important point, because some term of the discussion changes.

First of all, I do not mnd about binary only modules, and fixed ones like
nvidia, I was knowing I would had to use them when I bought those cards.

I do also agree with reasons of Andre Hedrick.

But this particular new modules infrastructures is a big penality for binary
only modules, AND SO IS A STRONG POSITION OF THE LINUX KERNEL AS A WHOLE
ABOUT THIS TOPIC.

This is a good incentive for company to GPL the drivers, and for users to use
GPL ones. This is a fact, and every one forgot it.

Then, if a developers wants to release a binary only modules, and then release
the sources when his work is repaid,
he can do so. I will be happy to use this module, if I need it, if it is stable
and works with the kernel version i choice (if not, I simply will go for
another hardware if I can),
and happier when it will be GPL
also because potentially it could work even better.

On the other side, the the linux kernel has implemented the just one smart
incentive for all to release modules under GPL, and who instead
choiche to release binary only modules knows very well that he will have
to face some true limitation. The developers has a serious reason to GPL
the code when he is "repaid".


For big companies like NVIDIA situation is slighly different.
They are already repaid by hardware, and they have all the interess
to have drivers that work at best. Image is important for them,
and performance gain too.
So they are strongly pushed since the
beginning to GPL the code, to avoid any kind of penalty.

how could they loose costumers just because a worse hardware works better
because of a GPL driver?

maybe my samples are too extreme (of course they are, ad every
provocation), but I was tired
to listen all
discussion about ideological points, and none considering
a pragmatic technical argument.

Luigi Genoni

On Wed, 8 Jan 2003, Matthias Andree wrote:

> Date: Wed, 8 Jan 2003 00:28:20 +0100
> From: Matthias Andree <matthias.andree@gmx.de>
> To: linux-kernel@vger.kernel.org
> Subject: Re: Honest does not pay here ...
>
> On Tue, 07 Jan 2003, Dana Lacoste wrote:
>
> > On Mon, 2003-01-06 at 18:41, Matthias Andree wrote:
> >
> > > You're at the author's mercy if you need to upgrade your kernel or if
> > > the driver doesn't work for you. I'd rather know before buying a product
> > > (modem, GFX board, ...) if there's either non-NDA'd documentation or
> > > better an OpenSource driver or at least support for such.
> >
> > Which is why you chose an open source driver over a closed source
> > driver, but you're STILL ignoring the "any driver is better than none"
> > argument.
>
> Depends on the driver quality. If it's stable, then it might qualify. If
> it confuses my computer, then I'll rather sell the hardware to someone
> who doesn't use Linux and buy a hardware that is documented and has
> decent OpenSource drivers.
>
> --
> Matthias Andree
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


