Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265118AbSJaC4i>; Wed, 30 Oct 2002 21:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265122AbSJaC4i>; Wed, 30 Oct 2002 21:56:38 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:63873 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S265118AbSJaC4g>; Wed, 30 Oct 2002 21:56:36 -0500
Date: Thu, 31 Oct 2002 04:03:01 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.45
Message-Id: <20021031040301.265c8d97.us15@os.inf.tu-dresden.de>
In-Reply-To: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.10; )
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="xnNBi=.nTfITA0QB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--xnNBi=.nTfITA0QB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2002 16:56:29 -0800 (PST) Linus Torvalds (LT) wrote:

LT> Summary of changes from v2.5.44 to v2.5.45
LT> ============================================

drivers/acpi/sleep.c: In function `acpi_system_suspend':
drivers/acpi/sleep.c:209: warning: implicit declaration of function `do_suspend_lowlevel'
drivers/acpi/sleep.c: In function `acpi_sleep_init':
drivers/acpi/sleep.c:707: `sysrq_acpi_poweroff_op' undeclared (first use in this function)
drivers/acpi/sleep.c:707: (Each undeclared identifier is reported only once
drivers/acpi/sleep.c:707: for each function it appears in.)
make[3]: *** [drivers/acpi/sleep.o] Error 1

CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y                                         
CONFIG_ACPI_PROCESSOR=y                                   
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y 
# CONFIG_PM is not set                  <=====

Regards,
-Udo.

--xnNBi=.nTfITA0QB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9wJ1lnhRzXSM7nSkRAvdnAJ48QAnnk2C4CUrivuYzKYj9/pwaXACfcHAd
f2UFsthROovBZ+9i9dKDajU=
=yPsz
-----END PGP SIGNATURE-----

--xnNBi=.nTfITA0QB--
