Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTE0CcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 22:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbTE0CcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 22:32:19 -0400
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:53441 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S262499AbTE0CcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 22:32:07 -0400
Date: Tue, 27 May 2003 04:45:19 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70 (Compiler warnings)
Message-Id: <20030527044519.0014a289.us15@os.inf.tu-dresden.de>
In-Reply-To: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Fiasco-Rulez: Yes
X-Mailer: X-Mailer 5.0 Gold
X-Outlook: <html><form><input type crash></form></html>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.x9J:/MWO_U0fEp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.x9J:/MWO_U0fEp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 May 2003 19:08:45 -0700 (PDT) Linus Torvalds (LT) wrote:

LT> Summary of changes from v2.5.69 to v2.5.70
LT> ============================================
LT> Sam Ravnborg:
LT>   o kbuild: Get more focus on warnings

Hi,

Since this patch went into the kernel, I assume there is a sufficient interest
in fixing compiler warnings before 2.6. is released. So here comes my list of
gcc-3.3. warnings for kernel hackers to look into.

Regards,
-Udo.


fs/fat/inode.c: In function `fat_fill_super':
fs/fat/inode.c:803: warning: comparison is always true due to limited range of data type

fs/smbfs/proc.c: In function `smb_proc_setattr_unix':
fs/smbfs/proc.c:3044: warning: integer constant is too large for "long" type
fs/smbfs/proc.c:3045: warning: integer constant is too large for "long" type
fs/smbfs/proc.c:3046: warning: integer constant is too large for "long" type
fs/smbfs/proc.c:3047: warning: integer constant is too large for "long" type
fs/smbfs/proc.c:3048: warning: integer constant is too large for "long" type

fs/smbfs/ioctl.c: In function `smb_ioctl':
fs/smbfs/ioctl.c:36: warning: comparison is always false due to limited range of data type
fs/smbfs/ioctl.c:36: warning: comparison is always false due to limited range of data type
fs/smbfs/ioctl.c:36: warning: comparison is always false due to limited range of data type
fs/smbfs/ioctl.c:36: warning: comparison is always false due to limited range of data type

crypto/sha512.c:51: warning: integer constant is too large for "long" type
crypto/sha512.c:51: warning: integer constant is too large for "long" type
crypto/sha512.c:51: warning: integer constant is too large for "long" type
crypto/sha512.c:52: warning: integer constant is too large for "long" type
crypto/sha512.c:52: warning: integer constant is too large for "long" type
crypto/sha512.c:52: warning: integer constant is too large for "long" type
crypto/sha512.c:53: warning: integer constant is too large for "long" type
crypto/sha512.c:53: warning: integer constant is too large for "long" type
crypto/sha512.c:53: warning: integer constant is too large for "long" type
crypto/sha512.c:54: warning: integer constant is too large for "long" type
crypto/sha512.c:54: warning: integer constant is too large for "long" type
crypto/sha512.c:54: warning: integer constant is too large for "long" type
crypto/sha512.c:55: warning: integer constant is too large for "long" type
crypto/sha512.c:55: warning: integer constant is too large for "long" type
crypto/sha512.c:55: warning: integer constant is too large for "long" type
crypto/sha512.c:56: warning: integer constant is too large for "long" type
crypto/sha512.c:56: warning: integer constant is too large for "long" type
crypto/sha512.c:56: warning: integer constant is too large for "long" type
crypto/sha512.c:57: warning: integer constant is too large for "long" type
crypto/sha512.c:57: warning: integer constant is too large for "long" type
crypto/sha512.c:57: warning: integer constant is too large for "long" type
crypto/sha512.c:58: warning: integer constant is too large for "long" type
crypto/sha512.c:58: warning: integer constant is too large for "long" type
crypto/sha512.c:58: warning: integer constant is too large for "long" type
crypto/sha512.c:59: warning: integer constant is too large for "long" type
crypto/sha512.c:59: warning: integer constant is too large for "long" type
crypto/sha512.c:59: warning: integer constant is too large for "long" type
crypto/sha512.c:60: warning: integer constant is too large for "long" type
crypto/sha512.c:60: warning: integer constant is too large for "long" type
crypto/sha512.c:60: warning: integer constant is too large for "long" type
crypto/sha512.c:61: warning: integer constant is too large for "long" type
crypto/sha512.c:61: warning: integer constant is too large for "long" type
crypto/sha512.c:61: warning: integer constant is too large for "long" type
crypto/sha512.c:62: warning: integer constant is too large for "long" type
crypto/sha512.c:62: warning: integer constant is too large for "long" type
crypto/sha512.c:62: warning: integer constant is too large for "long" type
crypto/sha512.c:63: warning: integer constant is too large for "long" type
crypto/sha512.c:63: warning: integer constant is too large for "long" type
crypto/sha512.c:63: warning: integer constant is too large for "long" type
crypto/sha512.c:64: warning: integer constant is too large for "long" type
crypto/sha512.c:64: warning: integer constant is too large for "long" type
crypto/sha512.c:64: warning: integer constant is too large for "long" type
crypto/sha512.c:65: warning: integer constant is too large for "long" type
crypto/sha512.c:65: warning: integer constant is too large for "long" type
crypto/sha512.c:65: warning: integer constant is too large for "long" type
crypto/sha512.c:66: warning: integer constant is too large for "long" type
crypto/sha512.c:66: warning: integer constant is too large for "long" type
crypto/sha512.c:66: warning: integer constant is too large for "long" type
crypto/sha512.c:67: warning: integer constant is too large for "long" type
crypto/sha512.c:67: warning: integer constant is too large for "long" type
crypto/sha512.c:67: warning: integer constant is too large for "long" type
crypto/sha512.c:68: warning: integer constant is too large for "long" type
crypto/sha512.c:68: warning: integer constant is too large for "long" type
crypto/sha512.c:68: warning: integer constant is too large for "long" type
crypto/sha512.c:69: warning: integer constant is too large for "long" type
crypto/sha512.c:69: warning: integer constant is too large for "long" type
crypto/sha512.c:69: warning: integer constant is too large for "long" type
crypto/sha512.c:70: warning: integer constant is too large for "long" type
crypto/sha512.c:70: warning: integer constant is too large for "long" type
crypto/sha512.c:70: warning: integer constant is too large for "long" type
crypto/sha512.c:71: warning: integer constant is too large for "long" type
crypto/sha512.c:71: warning: integer constant is too large for "long" type
crypto/sha512.c:71: warning: integer constant is too large for "long" type
crypto/sha512.c:72: warning: integer constant is too large for "long" type
crypto/sha512.c:72: warning: integer constant is too large for "long" type
crypto/sha512.c:72: warning: integer constant is too large for "long" type
crypto/sha512.c:73: warning: integer constant is too large for "long" type
crypto/sha512.c:73: warning: integer constant is too large for "long" type
crypto/sha512.c:73: warning: integer constant is too large for "long" type
crypto/sha512.c:74: warning: integer constant is too large for "long" type
crypto/sha512.c:74: warning: integer constant is too large for "long" type
crypto/sha512.c:74: warning: integer constant is too large for "long" type
crypto/sha512.c:75: warning: integer constant is too large for "long" type
crypto/sha512.c:75: warning: integer constant is too large for "long" type
crypto/sha512.c:75: warning: integer constant is too large for "long" type
crypto/sha512.c:76: warning: integer constant is too large for "long" type
crypto/sha512.c:76: warning: integer constant is too large for "long" type
crypto/sha512.c:76: warning: integer constant is too large for "long" type
crypto/sha512.c:77: warning: integer constant is too large for "long" type
crypto/sha512.c:77: warning: integer constant is too large for "long" type
crypto/sha512.c: In function `sha512_init':
crypto/sha512.c:182: warning: integer constant is too large for "long" type
crypto/sha512.c:183: warning: integer constant is too large for "long" type
crypto/sha512.c:184: warning: integer constant is too large for "long" type
crypto/sha512.c:185: warning: integer constant is too large for "long" type
crypto/sha512.c:186: warning: integer constant is too large for "long" type
crypto/sha512.c:187: warning: integer constant is too large for "long" type
crypto/sha512.c:188: warning: integer constant is too large for "long" type
crypto/sha512.c:189: warning: integer constant is too large for "long" type
crypto/sha512.c: In function `sha384_init':
crypto/sha512.c:198: warning: integer constant is too large for "long" type
crypto/sha512.c:199: warning: integer constant is too large for "long" type
crypto/sha512.c:200: warning: integer constant is too large for "long" type
crypto/sha512.c:201: warning: integer constant is too large for "long" type
crypto/sha512.c:202: warning: integer constant is too large for "long" type
crypto/sha512.c:203: warning: integer constant is too large for "long" type
crypto/sha512.c:204: warning: integer constant is too large for "long" type
crypto/sha512.c:205: warning: integer constant is too large for "long" type

drivers/char/vt_ioctl.c: In function `do_kdsk_ioctl':
drivers/char/vt_ioctl.c:85: warning: comparison is always false due to limited range of data type
drivers/char/vt_ioctl.c:85: warning: comparison is always false due to limited range of data type
drivers/char/vt_ioctl.c: In function `do_kdgkb_ioctl':
drivers/char/vt_ioctl.c:211: warning: comparison is always false due to limited range of data type

drivers/char/keyboard.c: In function `k_fn':
drivers/char/keyboard.c:663: warning: comparison is always true due to limited range of data type

drivers/i2c/i2c-sensor.c: In function `i2c_detect':
drivers/i2c/i2c-sensor.c:54: warning: `__check_region' is deprecated (declared at include/linux/ioport.h:113)

drivers/ide/ide-probe.c: In function `hwif_check_region':
drivers/ide/ide-probe.c:642: warning: `__check_region' is deprecated (declared at include/linux/ioport.h:113)
drivers/ide/ide-probe.c:644: warning: `__check_region' is deprecated (declared at include/linux/ioport.h:113)

drivers/serial/8250.c: In function `serial8250_set_termios':
drivers/serial/8250.c:1428: warning: comparison is always false due to limited range of data type

arch/i386/boot/setup.S: Assembler messages:
arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 0x37ffffff


--=.x9J:/MWO_U0fEp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+0tE/nhRzXSM7nSkRAr0iAJkBP2GtLNBfnOPeG33lga0ZJ9bFrQCePlSB
thBxMgUOw3cQtjIrPBpVxU4=
=U/pV
-----END PGP SIGNATURE-----

--=.x9J:/MWO_U0fEp--
