Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316886AbSGBTZs>; Tue, 2 Jul 2002 15:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316883AbSGBTZr>; Tue, 2 Jul 2002 15:25:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:60188 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316891AbSGBTZq>;
	Tue, 2 Jul 2002 15:25:46 -0400
Date: Tue, 2 Jul 2002 21:27:59 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: amd-smp-idle module avail for testing max 90 W power savings
Message-Id: <20020702212759.47587b23.sebastian.droege@gmx.de>
In-Reply-To: <20020702191454.GA25135@atomide.com>
References: <20020702191454.GA25135@atomide.com>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.1.cjS/8smtF0TF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.1.cjS/8smtF0TF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2002 12:14:54 -0700
Tony Lindgren <tony@atomide.com> wrote:

> Hi all,
> 
> I just posted a module to cut down on the energy bill for people with
> dual Athlon systems, well currently only tested on Tyan S2460, which is
> based on AMD-760MP chipset.
> 
> Amd-smp-idle enables the power savings mode like VCool and LVCool, but
> amd-smp-idle uses the Linux PCI features, and supports currently SMP
> only. So far I've squeezed out maximum 90 Watt power savings out of my
> system :)
> 
> Adding support for other chipsets, and maybe merging the LVCool
> functionality should be easy. Hopefully the core functionality will
> eventually make it to the ACPI to provide C2 support.
> 
> Please note that there's a bug where loading the module for the first
> time after rebooting causes the system to go sleep mode instead of
> the idle mode. To wake up the system, just hit the power button once.
> So, don't try this out on a remote server :)
> 
> The code is following, or you can also download it from:
> 
> http://www.muru.com/linux/amd-smp-idle/
> 
> Cheers,
> 
> Tony
Hi,
Is it possible to do something similar for AMD-751 or VIA-686a (or other UP Athlon chipsets)?

Bye
--=.1.cjS/8smtF0TF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9If7Ce9FFpVVDScsRAqZ9AJwLoPhaTpmhjDrJw64kZ5YObPJJqwCgi+3E
QizY3171UYDXx6GGVvItEdg=
=C3r0
-----END PGP SIGNATURE-----

--=.1.cjS/8smtF0TF--

