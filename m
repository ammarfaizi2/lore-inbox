Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbTDRDOc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 23:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTDRDOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 23:14:32 -0400
Received: from evrtwa1-ar9-4-65-254-215.evrtwa1.dsl-verizon.net ([4.65.254.215]:53189
	"EHLO omgwallhack.org") by vger.kernel.org with ESMTP
	id S262785AbTDRDO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 23:14:28 -0400
Subject: ACPI Problem
From: Julian Blake Kongslie <jblake@omgwallhack.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xGKwoQ+C5slTWKt7XL2H"
Organization: 
Message-Id: <1050636363.1889.13.camel@festa.omgwallhack.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Apr 2003 20:26:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xGKwoQ+C5slTWKt7XL2H
Content-Type: multipart/mixed; boundary="=-cyCcaJjxSNsFtESDQbRj"


--=-cyCcaJjxSNsFtESDQbRj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I asked this a while ago, but I didn't get a fix, and the problem still
exists...

I'm on an IBM Thinkpad a30p laptop, using a 2.5.66 kernel, and I can't
use ACPI. On bootup, ACPI tables are found, but there is a problem in
the ECDT, and ACPI disables itself. Exerpt from my dmesg is attached.

This problem is not in 2.4 (because the ECDT isn't used?), but it is in
kernels as early as 2.5.50. I haven't checked earlier kernels, but I can
if someone honestly thinks that would help.

I've gotten several emails from other people with similar systems, all
IBM laptops, regarding my earlier posts on this problem, asking if I
found a solution. This leads me to believe that it is an incompatability
with the ACPI implementation on IBM laptops. I, personally, am willing
to accept partial functionality because of a broken BIOS, but right now
I get no ACPI support at all, which is really disappointing.

ACPI section of .config is attached.

I can provide any other details that may be needed, and I will gladly
test bogus patches and dangerous fixes ;-) -- IBM gave me an awesome
warranty on this laptop, and I don't mind losing it for a few days if
they need to replace it.

Thanks in advance.

--=20

-Julian Blake Kongslie
<jblake@omgwallhack.org>

Herre Gud! Jeg har en o/ks i hodet!


--=-cyCcaJjxSNsFtESDQbRj
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ACPI: Subsystem revision 20030228
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquire=
d
Parsing all Control Methods:...............................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
.......................................
Table [DSDT] - 1259 Objects with 63 Devices 386 Methods 18 Regions
Parsing all Control Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c05d8b5c
evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode successf=
ul
   evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 000000=
0000001028
   evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to GPE=
15
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with metho=
d _L18 is not valid
   evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 000000=
000000102C
   evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE16 to GP=
E31
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with metho=
d _L18 is not valid
ACPI: Found ECDT
ACPI: Could not use ECDT
evxfevnt-0137 [06] acpi_disable          : ACPI mode disabled
 utalloc-0986 [05] ut_dump_allocations   : No outstanding allocations.

--=-cyCcaJjxSNsFtESDQbRj
Content-Disposition: attachment; filename=config
Content-Type: text/plain; name=config; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

#
# ACPI Support
#
CONFIG_ACPI=3Dy
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_SLEEP_PROC_FS=3Dy
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_THERMAL=3Dy
CONFIG_ACPI_TOSHIBA=3Dy
CONFIG_ACPI_DEBUG=3Dy
CONFIG_ACPI_BUS=3Dy
CONFIG_ACPI_INTERPRETER=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_PCI=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_APM=3Dy
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=3Dy
CONFIG_APM_CPU_IDLE=3Dy
CONFIG_APM_DISPLAY_BLANK=3Dy
CONFIG_APM_RTC_IS_GMT=3Dy
CONFIG_APM_ALLOW_INTS=3Dy
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

--=-cyCcaJjxSNsFtESDQbRj--

--=-xGKwoQ+C5slTWKt7XL2H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+n3BL+6o3+Z/zOlURAuKhAJsH70jEaxdZg2YKw59EdB/tTN314ACfcUmu
RclsWiqsWIX0c7SvBBkujQ8=
=2pLc
-----END PGP SIGNATURE-----

--=-xGKwoQ+C5slTWKt7XL2H--
