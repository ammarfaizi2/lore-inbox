Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132148AbRAWFEt>; Tue, 23 Jan 2001 00:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132173AbRAWFEj>; Tue, 23 Jan 2001 00:04:39 -0500
Received: from argo.starforce.com ([216.158.56.82]:40652 "EHLO
	argo.starforce.com") by vger.kernel.org with ESMTP
	id <S132148AbRAWFE3>; Tue, 23 Jan 2001 00:04:29 -0500
Date: Tue, 23 Jan 2001 00:04:08 -0500 (EST)
From: Derek Wildstar <dwild+linux_kernel@starforce.com>
X-X-Sender: <dwild@argo.starforce.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-test10
In-Reply-To: <3A6CF5B7.57DEDA11@linux.com>
Message-ID: <Pine.LNX.4.31.0101230000120.2343-100000@argo.starforce.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I am having ACPI problems with a dell inspiron 5000e, I hear it has a
broken implementation of APM, so could quite possibly have a broken ACPI
also.  When ACPI is enabled in the kernel (-pre10 and earlier ones also)
the system soft-hangs after loading the ACPI definitions.  both
ctrl-alt-del and alt-sysrq-b will restart the system.  If there is
anything else i can do to provide more info please let me know.  Running
without ACPI or APM is stable, even with the r128 kernel
drivers/XF4.0.2...battery usage is a bit quick, however =)

- -dwild


Linus Torvalds wrote:

> The ChangeLog may not be 100% complete. The physically big things are the
> PPC and ACPI updates, even if most people won't notice.
>
>                 Linus
>
> ----
>
> pre10:
>  - got a few too-new R128 #defines in the Radeon merge. Fix.
>  - tulip driver update from Jeff Garzik
>  - more cpq and DAC elevator fixes from Jens. Looks good.
>  - Petr Vandrovec: nicer ncpfs behaviour
>  - Andy Grover: APCI update
>  - Cort Dougan: PPC update
>  - David Miller: sparc updates
>  - David Miller: networking updates
>  - Neil Brown: RAID5 fixes
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6bRDYmFSlcxy4R48RAjx8AJ9EgM9A8k5sUQWu91w/lt2hZcfW5wCdFYi8
S+lZ54tOtr9BMUSn503hj68=
=d48f
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
