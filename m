Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135200AbRAYCOV>; Wed, 24 Jan 2001 21:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135349AbRAYCOM>; Wed, 24 Jan 2001 21:14:12 -0500
Received: from hs-gk.cyberbills.com ([216.35.157.254]:56840 "EHLO
	hs-mail.cyberbills.com") by vger.kernel.org with ESMTP
	id <S135272AbRAYCOB>; Wed, 24 Jan 2001 21:14:01 -0500
Date: Wed, 24 Jan 2001 18:13:54 -0800 (PST)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0ac11
In-Reply-To: <5.0.2.1.2.20010125015343.00a8fe10@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.31ksi3.0101241810290.605-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, Anton Altaparmakov wrote:

Don't be silly. I do not use RedHat (I do my own distribution, KSI Linux)
and their mkinitrd is just a script. Furthermore, I don't have ext2fs in the
kernel so their mkinitrd won't work. I do not have ide in the kernel
either...


> As I don't use initrd at all I am a bit out of my depth here but
> according
> to Documentation/Changes you need a new mkinitrd and the version
> suggested
> seems to be 2.8-1. Checking my up-to-date RedHat 7.0 workstation it has
> mkinitrd version 2.6-1, so this might be your problem?
>
> Best regards,
>
>          Anton
>
> At 01:39 25/01/2001, Sergey Kubushin wrote:
> >On Wed, 24 Jan 2001, Alan Cox wrote:
> >
> >Modules don't load. I do usually compile heavily modular kernels, with
> ide
> >and ext2fs being also modular. When trying to load them from initrd, I
> have
> >the following output:
> >
> >=== Cut ===
> >ide-mod.o: Can't handle sections of type 32131
> >ide-probe-mod.o: Can't handle sections of type 256950710
> >ext2.o: Can't handle sections of type 688840897
> >=== Cut ===
> >
> >I suspect that all modules are affected, but can't check it because
> kernel
> >is unable to mount root filesystem.
> >
> >All of ac9-ac11 behave the same. ac4, vanilla 2.4.0 and a whole bunch
> of
> >pre's are fine, so it looks like something was broken between ac4 and
> ac9 (I
> >didn't compile anything inbetween).
> >
> >I use gcc-2.95.2, binutils-2.10.1.0.4, modutils-2.4.2, glibc-2.2.1.
> The
> >initrd image is romfs. I don't think something was broken in romfs,
> 'coz
> >all the programs run just fine outta the image (static ash, static
> insmod).
> >
> >Config is available and can be sent on request. Please let me know if
> I can
> >help to find out what causes such a bug.
> [snip]
>
>
> --
>     "Programmers never die. They do a GOSUB without RETURN." - Unknown
> source
> --
> Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
> Linux NTFS Maintainer
> ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
>
>

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8890
Henderson, NV, 89014

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
