Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288921AbSANTsM>; Mon, 14 Jan 2002 14:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288950AbSANTqt>; Mon, 14 Jan 2002 14:46:49 -0500
Received: from [208.29.163.248] ([208.29.163.248]:41181 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S288952AbSANTpK>; Mon, 14 Jan 2002 14:45:10 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: babydr@baby-dragons.com, linux-kernel@vger.kernel.org
Date: Mon, 14 Jan 2002 11:44:59 -0800 (PST)
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <E16QCc6-0002bb-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0201141139370.22904-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Alan Cox wrote:

> Date: Mon, 14 Jan 2002 19:17:46 +0000 (GMT)
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: babydr@baby-dragons.com
> Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
> Subject: Re: Hardwired drivers are going away?
>
> > > Urban legend.
> > 	I do not agree .  Got proof ?  Yes that is a valid question .
>
> Most of the rootkit type stuff I see nowdays includes code for loading
> patches into module free kernels. Its a real no win. The better ones support
> regexp scanning so they can patch kernels where the sysadmin thinks he/she
> is cool and has hidden or crapped in System.map
>
> > > > case becouse the system can't know where the module will be located IIRC)
> > > I defy you to measure it on x86
> > 	OK ,How about sparc-64/alpha/ia64/... ?
>
> Not generally found in your grandmothers PC

doesn't matter, they are likly to be found on dedicated servers where
the flexibility of modules is not needed and the slight performance
advantage is desired.

making everything modular is fine for desktops/laptops but why should
dedicated servers pay the price?

> > > > 3. simplicity in building kernels for other machines. with a monolithic
> > > > kernel you have one file to move (and a bootloader to run) with modules
> > > > you have to move quite a few more files.
> > > tar or nfs mount; make modules_install.
> > 	Please my laugh'o meter is stuck already .  Sorry .  JimL
>
> Then fix it, because the above works well. Also remember that autoconfig
> tools won't be able to guess remote machines very well 8)

I don't want autoconfig to detect my remote machines I want to specify
them directly. (there are likly to be things on the motherboards of
machines that I don't want to compile into the kernel, sound cards for
servers are one example, video drivers are another, and USB is a third)

autoconfig is supposed to be an option, not the only way to compile a
kernel (or are you saying that you don't want to be able to use your 1.2G
athlon to build the kernel for your 486?)

David Lang
