Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266714AbUBGK0T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 05:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUBGK0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 05:26:19 -0500
Received: from pop.gmx.de ([213.165.64.20]:19099 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266714AbUBGK0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 05:26:12 -0500
X-Authenticated: #18225946
Message-ID: <001701c3ed64$dd8f1480$0100a8c0@lone>
From: "Peter Gruber" <pegruber@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: installation issue
Date: Sat, 7 Feb 2004 11:26:30 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2727.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

I seem to have a kernel installation problem.

When I try to boot ANY kind of linux boot disk, after starting syslinux,
the system halts with the error message "wrong loader, giving up".

I already discussed the problem with Peter Anvin, developer of
syslinux, and he thinks I should address you with the problem.

I hope you will be able to help me...

Peter


Here's what I wrote to him:





hello there,

my problem is as follows:


i tried to install debian on my old system. downloaded the boot disks and
let them boot.
i followed the installation instructions!
this is the produced error message:

===============================
boot:
Loading linux.bin ................ ready.
Wrong loader: giving up.
===============================

after having tried different floppies, even different floppy drives, using
different memory and other things... i figured out it is a syslinux problem.
i also tried to install suse - same error message.

i ran a few google searches, but didnt find any help anywhere.
i hope you can help me with my problem!

looking forward to hearing from you guys...

Peter



more information about the computer here:

BIOS ID    : 2A5IIG0BC-00
BIOS TYPE  : Award Software Inc.
BIOS DATE  : 09/08/97
CHIPSET ID : SiS-5582-W877
OEM INFO   : AUTO DETECT INTEL(R) SERIES CPU START Ver.1.5

64MB EDO RAM (2x 32MB)
AMD K6 200 MHz Family 5 Model 6 Step 2
L1 CPU Cache 64K
L2 M/B Cache 32K

HD:
406,55 MB
Cyls/Hd/Spt 826/16/63

Video:
Ati Rage 3d II +



===================================



Hello Mr. Anvin!

Thanks for the quick response!
I have the feeling that there's some misunderstanding here.
Please take a breath and read this...

This is a directory list of what's on my debian rescue disk:

15.05.2002  22:16             3.952 CONFIG.GZ
15.05.2002  22:16             1.139 DEBIAN.TXT
15.05.2002  22:16               804 F1.TXT
15.05.2002  22:16               763 F10.TXT
15.05.2002  22:16               752 F2.TXT
15.05.2002  22:16             1.071 F3.TXT
15.05.2002  22:16             1.209 F4.TXT
15.05.2002  22:16             1.214 F5.TXT
15.05.2002  22:16             1.337 F6.TXT
15.05.2002  22:16               899 F7.TXT
15.05.2002  22:16             1.348 F8.TXT
15.05.2002  22:16             1.269 F9.TXT
15.05.2002  22:16             1.520 INSTALL.SH
15.05.2002  22:16             7.060 LDLINUX.SYS
15.05.2002  22:16         1.005.181 LINUX.BIN
15.05.2002  22:16               650 RDEV.SH
15.05.2002  22:16               902 README.TXT
15.05.2002  22:16            81.847 SYS_MAP.GZ
15.05.2002  22:16             1.402 SYSLINUX.CFG
15.05.2002  22:16                 7 TYPE.TXT
              21 Datei(en)      1.114.431 Bytes
               0 Verzeichnis(se),        327.168 Bytes frei

As you can read here, the linux kernel is named "LINUX.BIN". This disk was
generated
by rawwrite2 from the image

ftp://ftp.debian.org/debian/dists/woody/main/disks-i386/3.0.23-2002-05-21/im
ages-1.44/rescue.bin

As already said, this disk comes from debian, works for thousands of people!
There doesn't seem to
be anything wrong with it! If you read the installation manual, it says:

1. Download the necessary files
2. Rawwrite them to a formatted disk
3. Boot the disk and wait for further instructions

When I insert the disk into my workstation computer (Duron 900, 512MB RAM
etc)
it boots nicely and fast - the way it apparently should be!

When I insert it into my old AMD K6 200 it boots until the boot prompt,
where you can enter
some boot arguments I guess:

boot:                                                            <-- Here I
press "enter"
Loading linux.bin ................ ready.               <-- Apparently,
linux.bin is loading!
Wrong loader: giving up.                               <-- What the heck?
Help me with this one!!!

First I thought it might be a floppy disk error, so I exchanged the floppy
drive and tried other
floppies. That was not the reason for not working!
So I exchanged the memory of the computer. No difference.
I took out all ISA and PCI cards not needed for booting. No difference.
I took out the hard disk. No difference.
I tried booting from a DOS bootdisk. Yes, that works!

I tried installing SuSe - but the same error occurs as with Debian!

So I downloaded SYSLINUX from your website, formatted a floppy disk, copied
the linux kernel from

ftp://ftp.debian.org/debian/dists/woody/main/disks-i386/3.0.23-2002-05-21/li
nux.bin

onto this disk and did a syslinux a:

Works fine, so I boot the computer from this disk:
Same error message!

So I guess two things:
1. SYSLINUX is the reason for the error message (as there is nothing else on
the disk!)
2. You are the only person who seems to be able to help me, as you coded the
error message
and know what the problem is!

Yes, I read the link you gave me.
But I cannot see why you think this is my problem!
As already mentioned, I download a complete rescue/boot disk image, I guess
it is intended
to be written to a disk and then booted, not to be changed in any way unless
said!

If you read my error message

boot:
Loading linux.bin ................ ready.
Wrong loader: giving up.

then you will see that it apparently is not the problem. linux.bin is
loading, so it is not named incorrectly!

I hope I made myself clear this time and I'm looking forward to hearing from
you!

Sincerely,

Peter Gruber


----- Original Message -----
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Peter Gruber" <ichbinsingleunddu@gmx.net>
Cc: <syslinux@zytor.com>
Sent: Thursday, February 05, 2004 4:37 PM
Subject: Re: [syslinux] problems with syslinux


> Peter Gruber wrote:
> > hello there,
> >
> > my problem is as follows:
> >
> >
> > i tried to install debian on my old system. downloaded the boot disks
and
> > let them boot.
> > i followed the installation instructions!
> > this is the produced error message:
> >
> > ===============================
> > boot:
> > Loading linux.bin ................ ready.
> > Wrong loader: giving up.
> > ===============================
> >
>
> Please see: http://syslinux.zytor.com/errors.php
>
> -hpa
>
> _______________________________________________
> SYSLINUX mailing list
> Submissions to SYSLINUX@zytor.com
> Unsubscribe or set options at:
> http://www.zytor.com/mailman/listinfo/syslinux
> Please do not send private replies to mailing list traffic.
>

==================================

Thanks for helping!
So who will I have to address my problem to?
The kernel dev team?

I also tried a syslinux -s, no difference...


