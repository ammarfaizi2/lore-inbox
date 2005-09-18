Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVIRN5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVIRN5q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 09:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVIRN5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 09:57:46 -0400
Received: from sero.dbtech.de ([195.4.70.70]:50697 "HELO mx0.dbtech.de")
	by vger.kernel.org with SMTP id S932067AbVIRN5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 09:57:45 -0400
From: Christian Fischer <Christian.Fischer@fischundfischer.com>
Organization: Fisch+Fischer Veranstaltungstechnik
To: linux-kernel@vger.kernel.org
Subject: x86: mounting scsi-cdrom: kernel panic with vanilla and others, works with ac
Date: Sun, 18 Sep 2005 15:57:37 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8419541.yv7yg6G5B1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509181557.37934.Christian.Fischer@fischundfischer.com>
X-Spam-HITS: -4.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8419541.yv7yg6G5B1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all.

Some days ago I've tried 2.6.12-cko3 and got "Kernel panic - not syncing:=20
=46atal exception in interrupt" by mounting the cdrom (scsi). Known problem=
 I=20
thought, I had this if I tried to switch from 2.6.11-ac7 to 2.6.11-gentoo.=
=20

To point out if this is a problem of gentoo-base patches or cko-patches i=20
tried 2.6.12-vanilla and got Kernel panic.

Mainboard: SuperMicro MBD-P4SCT-0
Chipset: Intel 875
CPU: Intel P4 2,4=20
Memory: ECC
SCSI: Tekram TRM-S1040

CONFIG_X86_GOOD_APIC=3Dy
# CONFIG_X86_UP_APIC is not set

CONFIG_SCSI=3Dy
CONFIG_SCSI_PROC_FS=3Dy
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
CONFIG_SCSI_SPI_ATTRS=3Dm
CONFIG_SCSI_SATA=3Dy
CONFIG_SCSI_ATA_PIIX=3Dy
CONFIG_SCSI_SYM53C8XX_2=3Dm
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=3D16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=3D64
CONFIG_SCSI_QLA2XXX=3Dy
CONFIG_SCSI_DC395x=3Dy
CONFIG_SCSI_DC390T=3Dy


Regards
Christian
=2D-=20

--nextPart8419541.yv7yg6G5B1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDLXJRszmQKstIgt4RAgjTAKDBWtlOr+X6eOdBFMlTYzEDxFMIJACeIXTZ
Sl9ea0g1KpMVmuD95290X6I=
=Gusf
-----END PGP SIGNATURE-----

--nextPart8419541.yv7yg6G5B1--

