Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266967AbUBGQdt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 11:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266971AbUBGQdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 11:33:49 -0500
Received: from port-212-202-157-212.reverse.qsc.de ([212.202.157.212]:53129
	"EHLO bender.portrix.net") by vger.kernel.org with ESMTP
	id S266967AbUBGQd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 11:33:26 -0500
Message-ID: <402512C4.4030903@portrix.net>
Date: Sat, 07 Feb 2004 17:31:00 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031022 Debian/1.5-1.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: Juergen Rose <rose@rz.uni-potsdam.de>
CC: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: drivers/pnp/isapnp/Kconfig not found performing configure for
 linux-2.6.2-mm1
References: <1076168521.24931.2.camel@moen.bioinf.mdc-berlin.de>
In-Reply-To: <1076168521.24931.2.camel@moen.bioinf.mdc-berlin.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Juergen Rose wrote:
| Hi,
|
| I can't configure linux-2.6.2-mm1, because of a missing
| drivers/pnp/isapnp/Kconfig. I patched a plain linux-2.6.2 with
| 2.6.2-mm1.bz2:
|
| vilm:/usr/src/linux(40)#make menuconfig
| make[1]: `scripts/fixdep' is up to date.
| scripts/kconfig/mconf arch/i386/Kconfig
| drivers/pnp/Kconfig:34: can't open file "drivers/pnp/isapnp/Kconfig"
| make[1]: *** [menuconfig] Error 1
|
| What can I do?

Works here:

$ ls -l drivers/pnp/isapnp/Kconfig
- -rw-r--r--    1 jdittmer jdittmer      291 Feb  7 00:04 
drivers/pnp/isapnp/Kconfig

$ head -4 Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 2
EXTRAVERSION = -mm1

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAJRK/LqMJRclVKIYRAp85AJ4u5UAM/nGyGy7fJ2+WT4vKcXAq9gCdHajO
eP+oPEN5IK4Y8qtzXROF18U=
=n/8H
-----END PGP SIGNATURE-----

