Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263485AbTLXJOR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 04:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbTLXJOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 04:14:17 -0500
Received: from cibs9.sns.it ([192.167.206.29]:55557 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S263485AbTLXJOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 04:14:15 -0500
Date: Wed, 24 Dec 2003 10:13:47 +0100 (CET)
From: venom@sns.it
To: pZa1x <pZa1x@rogers.com>
cc: Karol Kozimor <sziwan@hell.org.pl>, <linux-kernel@vger.kernel.org>
Subject: Re: Laptops and 2.6.0 - momentum? (was Re: 2.6.0 release + ALSA +
 suspend = not work)
In-Reply-To: <3FE8388F.1020302@rogers.com>
Message-ID: <Pine.LNX.4.43.0312241011410.5141-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


same problem with alsa on CS4236B ISA card, and sound is horrible.
no problems with OSS.

alsa work fine on Maestro pci and old good SB16 ISA.

So, probably depends on the specific driver.

Luigi

On Tue, 23 Dec 2003, pZa1x wrote:

> Date: Tue, 23 Dec 2003 12:43:59 +0000
> From: pZa1x <pZa1x@rogers.com>
> To: Karol Kozimor <sziwan@hell.org.pl>
> Cc: linux-kernel@vger.kernel.org
> Subject: Laptops and 2.6.0 - momentum? (was Re: 2.6.0 release + ALSA +
>     suspend = not work)
>
> Well, I'm volunteering time to do testing on my notebook for 2.6.0. I
> wonder if there is anyway to generate some momentum for it? If the aim
> is enterprise, doesn't enterprise use thousands of notebooks? I got mine
> refurbished from some large business. There are many organizations that
> collect thousands of old notebooks used by businesses, refurbish them
> and re-sell them. It's a great way of acquiring a durable, light
> business-class notebook at bargain prices.
>
> This is a great target for Linux especially as it runs fine (even with
> the infamous Gnome) on my 700Mhz T20 Thinkpad. ie. a multi-gigahertz
> system seems a complete waste of money and a risk re weight and build
> quality.
>
> I couldn't code a hello world to save my life but I can test patches and
> collect data. Currently, I am running 2.4.22 on my notebook because on
> 2.6.0:
>
> (a) suspend kills ALSA and ALSA mut be restarted
> (b) suspend fails to function if yenta_socket (PCMCIA services) is running
>
>
> Karol Kozimor wrote:
> > Thus wrote pZa1x:
> >
> >>ALSA stops producing sound after any time I suspend my Thinkpad T20
> >>notebook. I am using 2.6.0 release and the snd-cs46xx driver.
> >>
> >>I have to log out of Gnome and remove the sound card module and re
> >>modprobe it then restart Gnome to get sound back.
> >>
> >>No problems with 2.4.20 with OSS drivers.
> >
> >
> > I have a similar problem here (ICH3M, CS4299, snd-intel8x0). In my case,
> > using OSS emulation in userspace and ALSA modules in kernel works fine, so
> > it must be a locking problem of some kind, anyway probably something
> > trivial to fix.
> > A similar problem occurs under 2.4, FYI.
> > Best regards,
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

