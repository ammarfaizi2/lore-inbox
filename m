Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293242AbSCZJ0n>; Tue, 26 Mar 2002 04:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293276AbSCZJ0d>; Tue, 26 Mar 2002 04:26:33 -0500
Received: from firewall.synchrotron.fr ([193.49.43.1]:16055 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S293242AbSCZJ0R>;
	Tue, 26 Mar 2002 04:26:17 -0500
Date: Tue, 26 Mar 2002 10:25:57 +0100
From: Samuel Maftoul <maftoul@esrf.fr>
To: Marc-Christian Petersen <mcp@linux-systeme.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Kernel 2.4.18-WOLK3.1
Message-ID: <20020326102557.B25079@pcmaftoul.esrf.fr>
In-Reply-To: <200203251821.g2PIL7oA005522@codeman.linux-systeme.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 
First of all, I'm happy to see such a Patchset, Thanks.
you're version name is WOLK in uppercase.
I would like to ask if there is a naming convention for kernel trees:
make-kpkg, which is the kernel source/image packager of the debian,
doesn't support release names in uppercases:
---------------------------------------------------------------------
Lion:/usr/src/linux# make-kpkg 
debian/rules:966: *** Error. The version number 2.4.18-WOLK3.1 is not
all lowercase. Since the version ends up in the package name of the
kernel image package, this is a Debian policy violation, and the
packaging system shall refuse to package the image. . Stop.
---------------------------------------------------------------------
Could you rename your EXTRAVERSION with wolk ? or is it a Debian
limitation ?

Thanks,
        Sam

On Mon, Mar 25, 2002 at 07:21:07PM +0100, Marc-Christian Petersen wrote:
> Kernel - patched - WOLK3.1 - Base: Linux kernel 2.4.18
> 
> by Marc-Christian Petersen <mcp@linux-systeme.de>
> 
> 
> This is my second public release. WOLK 3.1 is now available as full kernel
> AND as a patchset. There were some requests to do it, so here it is :)
> WOLK 3.1 contains several bugfixes found in WOLK 3.0 (formerly known as
> mcp3-WOLK), reported by users of wolk and found by myself.
> Project name change cause WOLK looks nicer than of mcp-WOLK.
> 
> Thanks to darix <darix@irssi.de> for the project name WOLK :-)
> 
> 
> What is this? Why another patchset/patched kernel?
> 
> Using Linux since years, very tired of there are not really good
> patchsets available. Saw FOLK Patch/Kernel which is still very very buggy.
> Inspired by the jp-Patchsets from Joerg Prante <joerg@infolinux.de>.
> 
> The WOLK's are development kernels/patchsets for testing purpose only.
> !! If you want to use it in production, use it at your own risk !!
> Their purpose is to provide a service for developers and end-users who
> can't be up to date with the latest official stable kernels/patches but
> want to test many features out there linux can use. Maybe, (hopefully)
> some of them will be included into the mainstream kernel 2.4 soon.
> 
> There will always be a new WOLK major release if there is a new final
> kernel released. Minor releases only if someone/me found critical bugs.
> 
> You are missing a patch? Patches will be added by request.
> You think one or more of the patches are fully useless? Tell me why.
> You have minor, major or heavy mega problems, let me know. I will try to fix.
> You think this is great? Let me know too :-)
> 
> You want YOUR patch to be included in WOLK? Let me know :)
> 
> There is also a mailinglist available you can join at:
> https://sourceforge.net/mail/?group_id=49048
> 
> 
> Overview:
> ---------
> For an overview go to http://sf.net/projects/wolk
> The WOLK 3.1 kernel/patchset contains over 90 Patches
> 
> Credits go to all the people who created the patches, working hard on
> improving the quality.
> 
> 
> 
> Changes in WOLK 3.1
> -------------------
> o   removed:    load-kill patch (causes panics)
> o   update:     Tekram DC395 v1.38
> o   update:     Event Logging v1.30
> o   update:     Compressed Cache 0.22 final
> o   update:     Win4Lin  mki-adapter Patch update to 1.07
> o   add:        FTP fs
> o   add:        ISDN LZS Compression
> o   add:        TUX
> o   add:        UML
> o   add:        Linux Trace Toolkit
> o   add:        Broadcom Tigon3 support
> o   small other patches (IDE, RAID ...)
> o   Minor fixes found in WOLK 3.0
> o   moved the tools to an extra package
> 
> 
> 
> Todo for the next releases:
> ---------------------------
> o  Mosix/OpenMosix (why the hell they are so slow to
>    release new patches. Hurry up !!
> o  maybe OpenAFS
> o  maybe OpenGFS
> o  ALSA
> o  grsecurity/preempt + Win4Lin coexistence
>    (Brad/Michael, can you help me with it?)
> o  If 2.4.19 is final: Reverse Mapping VM
> 
> 
> 
> --------------------------------------------------------------------------
> Feel free to send me feedback. Please CC, I am not subscribed to the lkml.
> --------------------------------------------------------------------------
> 
> The next major WOLK (WOLK 4) will be available some days after the 2.4.19
> final kernel release.
> 
> 
> Enjoy!
> 
> Marc-Christian Petersen <mcp@linux-systeme.de>
> Unix/Linux Administrator
> Essen, Germany
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
