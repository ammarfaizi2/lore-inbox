Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSD0UQ1>; Sat, 27 Apr 2002 16:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSD0UQ0>; Sat, 27 Apr 2002 16:16:26 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:53684 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S314451AbSD0UQZ>;
	Sat, 27 Apr 2002 16:16:25 -0400
Date: Sat, 27 Apr 2002 21:15:55 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Matthew M <matthew.macleod@btinternet.com>
cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Microcode update driver
In-Reply-To: <m171YQJ-000GQtC@Wasteland>
Message-ID: <Pine.LNX.4.33.0204272114560.1792-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Apr 2002, Matthew M wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Saturday 27 April 2002 8:51 pm, RS wrote:
> > ok
> >
> > running redhat, I have no microcode_ctl. but still, the kernel tells me
> > 'IA-32 Microcode Update Driver: v1.09 <tigran@veritas.com>' during boot.
> >
> > where can i find it? Do I need it?
>
> microcode_ctl is the userland utility which actually soed the uploading of
> microcode. You will need to get the appropriate package, and this will come

if he is running latest Red Hat beta then it is part of kernel-utils
package:

$ rpm -qif /sbin/microcode_ctl
Name        : kernel-utils                 Relocations: (not relocateable)
Version     : 2.4                               Vendor: Red Hat, Inc.
Release     : 7.4                           Build Date: Tue 02 Apr 2002 18:22:09 BST
Install date: Thu 25 Apr 2002 10:32:35 BST      Build Host: stripples.devel.redhat.com
Group       : System Environment/Base       Source RPM: kernel-utils-2.4-7.4.src.rpm
Size        : 624523                           License: GPL
Packager    : Red Hat, Inc. <http://bugzilla.redhat.com/bugzilla>
URL         : http://www.urbanmyth.org/microcode/
Summary     : Kernel and Hardware related utilities
Description :
kernel-utils contains several utilities that can be used to control
the kernel or your machines hardware. Included are
* dmidecode - gives information about the bios and motherboard revisisons
* microcode_ctl - updates the microcode on Intel cpu's
* smartctl - monitor the health of your disks


> with microcode.dat - then you should actually be able to update your
> microcode. The message in your kernel log is just the driver initialisation.
>
> *MatthewM*
> - --
>
> Sometimes love ain't nothing but a misunderstanding between two fools.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.6 (GNU/Linux)
> Comment: For info see http://www.gnupg.org
>
> iD8DBQE8ywOfoVQMDIAmueURAvGVAJ95OFzC163RQ0veUPfndUqy7QzuWQCeOTKS
> J9hy4k+y8O67Fnk5vPn9R6s=
> =z/wB
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

