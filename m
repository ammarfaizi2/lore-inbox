Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135328AbRAYCD4>; Wed, 24 Jan 2001 21:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135349AbRAYCDq>; Wed, 24 Jan 2001 21:03:46 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:53218 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S135328AbRAYCDk>; Wed, 24 Jan 2001 21:03:40 -0500
Message-Id: <5.0.2.1.2.20010125015343.00a8fe10@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Thu, 25 Jan 2001 02:04:06 +0000
To: "Sergey Kubushin" <ksi@cyberbills.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Linux 2.4.0ac11
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31ksi3.0101241721470.605-100000@nomad.cyberbill
 s.com>
In-Reply-To: <E14LOAm-0006z0-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I don't use initrd at all I am a bit out of my depth here but according 
to Documentation/Changes you need a new mkinitrd and the version suggested 
seems to be 2.8-1. Checking my up-to-date RedHat 7.0 workstation it has 
mkinitrd version 2.6-1, so this might be your problem?

Best regards,

         Anton

At 01:39 25/01/2001, Sergey Kubushin wrote:
>On Wed, 24 Jan 2001, Alan Cox wrote:
>
>Modules don't load. I do usually compile heavily modular kernels, with ide
>and ext2fs being also modular. When trying to load them from initrd, I have
>the following output:
>
>=== Cut ===
>ide-mod.o: Can't handle sections of type 32131
>ide-probe-mod.o: Can't handle sections of type 256950710
>ext2.o: Can't handle sections of type 688840897
>=== Cut ===
>
>I suspect that all modules are affected, but can't check it because kernel
>is unable to mount root filesystem.
>
>All of ac9-ac11 behave the same. ac4, vanilla 2.4.0 and a whole bunch of
>pre's are fine, so it looks like something was broken between ac4 and ac9 (I
>didn't compile anything inbetween).
>
>I use gcc-2.95.2, binutils-2.10.1.0.4, modutils-2.4.2, glibc-2.2.1. The
>initrd image is romfs. I don't think something was broken in romfs, 'coz
>all the programs run just fine outta the image (static ash, static insmod).
>
>Config is available and can be sent on request. Please let me know if I can
>help to find out what causes such a bug.
[snip]


-- 
    "Programmers never die. They do a GOSUB without RETURN." - Unknown source
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
