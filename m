Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144361AbRA1WJg>; Sun, 28 Jan 2001 17:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144235AbRA1WJ0>; Sun, 28 Jan 2001 17:09:26 -0500
Received: from argo.starforce.com ([216.158.56.82]:20130 "EHLO
	argo.starforce.com") by vger.kernel.org with ESMTP
	id <S143948AbRA1WJQ>; Sun, 28 Jan 2001 17:09:16 -0500
Date: Sun, 28 Jan 2001 17:08:41 -0500 (EST)
From: Derek Wildstar <dwild+linux_kernel@starforce.com>
X-X-Sender: <dwild@argo.starforce.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dieter Nützel <Dieter.Nuetzel@hamburg.de>,
        Andrew Grover <andrew.grover@intel.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re:  Linux-2.4.1-pre11
In-Reply-To: <Pine.LNX.4.10.10101281346030.4151-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.31.0101281704580.6761-100000@argo.starforce.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 28 Jan 2001, Linus Torvalds wrote:

> On Sun, 28 Jan 2001, Dieter Nützel wrote:
>
> > > I just uploaded it to kernel.org, and I expect that I'll do the final
> > > 2.4.1 tomorrow, before leaving for NY and LinuxWorld. Please test that the
> > > pre-kernel works for you..
> >
> > Hello Linus,
> >
> > can we please see Andrew's latest ACPI fixes ([Acpi] ACPI source release
> > updated: 1-25-2001)  in 2.4.1 final?
>
> Does it fix stuff? Andrew?
>
I just tried adding this to 2.4.1-pre11 and the compile failed, the
problem i've been having with ACPI is the kernel soft-hangs just after
loading the tables.  Using APM or no power management at all doesn't hang.

Hardware: Dell Inspiron 5000e, bios A04 (latest provided by Dell)

I have heard of some bugs in Dell's ACPI implementation, but since so many
people have dell machines it may be worth trying to work around, or even
detect the buggy implementation and disable ACPI with an error printed.

I can donate time if needed, just let me know what needs to be tested.

Thanks,
dwild
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjp0mHAACgkQhazASHM/AFMr0ACgjPE3+hzS05N5gt1qvl5Pgue7
smcAoIITSnkaawBXj+zToaajc9NgfrlK
=n4fr
-----END PGP SIGNATURE-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
