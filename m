Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSD2PrX>; Mon, 29 Apr 2002 11:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312684AbSD2PrW>; Mon, 29 Apr 2002 11:47:22 -0400
Received: from slarti.muc.de ([193.149.48.10]:7174 "HELO slarti.muc.de")
	by vger.kernel.org with SMTP id <S312619AbSD2PrV> convert rfc822-to-8bit;
	Mon, 29 Apr 2002 11:47:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Stephan Maciej <stephan@maciej.muc.de>
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
Subject: Re: Sony Vaio Laptop problems
Date: Mon, 29 Apr 2002 16:30:22 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200204261728.39745.stephan@maciej.muc.de> <20020429002811.GB3108@arthur.ubicom.tudelft.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200204291630.22969.stephan@maciej.muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 April 2002 02:28, Erik Mouw wrote:
> > ERROR
> > 0211: Keyboard Error
> >
> > I do have the option to use <F2> to enter Setup, but due to some strange
> > 0211 keyboard error it just won't work. The only proper way for
> > restarting my machine is to power it off and turn it on again.
> >
> > What can I do?
>
> 1) Update the BIOS, my laptop shipped with an old version and a BIOS
>    update fixed some keyboard related problems. (you need to boot into
>    windows for this)

Can I do this with a DOS bootdisk? I remember that most of the Flash updates 
require you to startup the computer in a real DOS environment, at least those 
I have seen for my ASUS P5A and A7V boards.

Windows XP didn't live long on my system - I just booted it after I bought 
that thingy, then I installed Linux on the whole disk. I can live with the 
reboot problem, as long as I'd have to install XP or some other Microsoft 
shit on it to fix it.

> 2) Apply the latest ACPI patch.

I'll try. Is anyone interested in getting positive feedback? You?

> [...]
> My FX505 doesn't need the sonypi driver. With APM I can suspend the
> computer but the CPU fan won't turn off; with ACPI the CPU fan turns
> off, but I can't suspend the computer. Anyway, the latest ACPI patch
> makes it a lot more quiet.

That's right. With APM, I had the problem that the fan didn't turn on if it 
wasn't on after a power-on. Twice, my machine went off because it overheated.

> [...]
> Use the ALSA-0.9 series driver instead of the kernel driver.

I'll try that, too.

> > So, just for completeness, here's my system configuration:
> >
> > Mobile AMD Duron Processor, 1GHz
> > 256MB RAM
> > IDE hard disk and CD/DVD ROM
>
> You forgot to tell which kernel version you are currently using.
> Anyway, linux-2.4.19-pre5 + acpi-20020329-2.4.18 works for me.

Umm, I really forgot that. I am currently using a vanilla 2.5.9 kernel and I 
am quite happy with it.

Thanks,

Stephan
