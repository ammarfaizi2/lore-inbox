Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262947AbUKRUg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbUKRUg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbUKRUeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:34:25 -0500
Received: from smtp.kisikew.org ([66.11.160.83]:45700 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S262917AbUKRUdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:33:02 -0500
Date: Thu, 18 Nov 2004 15:32:58 -0500
From: simon@nuit.ca
To: linux-kernel@vger.kernel.org
Subject: follow-up to: OOPS in tulip 2.6.10-rc2-bk2
Message-ID: <20041118203258.GC7555@nuit.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux
X-GPG-Key-Server: x-hkp://subkeys.pgp.net
User-Agent: Mutt/1.5.6+20040907i
X-Scan-Signature: smtp.nuit.ca 1CUsxf-0005w9-6q 76ff9aebdf7701fb2614e7fd1df76642
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


i get build warnings:

drivers/net/appletalk/ipddp.c:292: warning: `MODULE_PARM_' is deprecated (d=
eclared at include/linux/module.h:562)
  CC [M]  drivers/net/tulip/de2104x.o
drivers/net/tulip/de2104x.c:61: warning: `MODULE_PARM_' is deprecated (decl=
ared at include/linux/module.h:562)
drivers/net/tulip/de2104x.c:72: warning: `MODULE_PARM_' is deprecated (decl=
ared at include/linux/module.h:562)
  CC [M]  drivers/net/tulip/eeprom.o
  CC [M]  drivers/net/tulip/interrupt.o
  CC [M]  drivers/net/tulip/media.o
  CC [M]  drivers/net/tulip/timer.o
  CC [M]  drivers/net/tulip/tulip_core.o
drivers/net/tulip/tulip_core.c:118: warning: `MODULE_PARM_' is deprecated (=
declared at include/linux/module.h:562)
drivers/net/tulip/tulip_core.c:119: warning: `MODULE_PARM_' is deprecated (=
declared at include/linux/module.h:562)
drivers/net/tulip/tulip_core.c:120: warning: `MODULE_PARM_' is deprecated (=
declared at include/linux/module.h:562)
drivers/net/tulip/tulip_core.c:121: warning: `MODULE_PARM_' is deprecated (=
declared at include/linux/module.h:562)
drivers/net/tulip/tulip_core.c:122: warning: `MODULE_PARM_' is deprecated (=
declared at include/linux/module.h:562)
drivers/net/tulip/tulip_core.c:123: warning: `MODULE_PARM_' is deprecated (=
declared at include/linux/module.h:562)

and:

drivers/net/mace.c:1050: warning: `MODULE_PARM_' is deprecated (declared at=
 include/linux/module.h:562)
  CC [M]  drivers/net/3c59x.o
drivers/net/3c59x.c:281: warning: `MODULE_PARM_' is deprecated (declared at=
 include/linux/module.h:562)
drivers/net/3c59x.c:282: warning: `MODULE_PARM_' is deprecated (declared at=
 include/linux/module.h:562)
drivers/net/3c59x.c:283: warning: `MODULE_PARM_' is deprecated (declared at=
 include/linux/module.h:562)
drivers/net/3c59x.c:284: warning: `MODULE_PARM_' is deprecated (declared at=
 include/linux/module.h:562)
drivers/net/3c59x.c:285: warning: `MODULE_PARM_' is deprecated (declared at=
 include/linux/module.h:562)
drivers/net/3c59x.c:286: warning: `MODULE_PARM_' is deprecated (declared at=
 include/linux/module.h:562)
drivers/net/3c59x.c:287: warning: `MODULE_PARM_' is deprecated (declared at=
 include/linux/module.h:562)
drivers/net/3c59x.c:288: warning: `MODULE_PARM_' is deprecated (declared at=
 include/linux/module.h:562)
drivers/net/3c59x.c:289: warning: `MODULE_PARM_' is deprecated (declared at=
 include/linux/module.h:562)
drivers/net/3c59x.c:290: warning: `MODULE_PARM_' is deprecated (declared at=
 include/linux/module.h:562)
drivers/net/3c59x.c:291: warning: `MODULE_PARM_' is deprecated (declared at=
 include/linux/module.h:562)
drivers/net/3c59x.c:292: warning: `MODULE_PARM_' is deprecated (declared at=
 include/linux/module.h:562)
drivers/net/3c59x.c:293: warning: `MODULE_PARM_' is deprecated (declared at=
 include/linux/module.h:562)
drivers/net/3c59x.c:294: warning: `MODULE_PARM_' is deprecated (declared at=
 include/linux/module.h:562)
drivers/net/3c59x.c:295: warning: `MODULE_PARM_' is deprecated (declared at=
 include/linux/module.h:562)


with -bk3. got the same ones in -bk2.

eric

--=20
       ,''`.   http://www.debian.org/       http://www.nuit.ca/
       : :' :  Debian GNU/Linux             http://simonraven.nuit.ca/
       '                                    ------------------------------
         `-                                 GPG Print: 7C49 FD9C 1054 7300
                                            3B7B 8BF4 6A88 7AE2 711D F097

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQGVAwUBQZ0G+GqIeuJxHfCXAQIyigwAmUt4Vf7PFKdD2N9BK4oFaxogYQhUCmW9
kJ6bgfFIxj1J44bqEsBI3RSazrUA5AFW3GYWTqzyLUNrT8vId/tU0H0EKyTNQR4V
+8sNjeinDxR9jO6KkpXueYZBi+jDl4+x5AXiTYzPDlPQFPwugozeOPrekKXBVtiz
VhNZpIWUN30g5qRrqplEunPYgmZMkCGAVPFlcR8siDHXLEW9Bo0P5B5WUJcVc9/+
ub1aETB1ZkDZINQIYRUGcfMLAsAU8QXm6BMMalbI5OHu/5xvicp/lJ8PcV8BTdz+
jWYccqmQgXcy1YOpi9luoarFuwAfX3pcgTNCKKNE/xRqbYxdvUD7S2rWveFYsFAB
odfl/TtRnslldqJqjCQoS3+dCZ5JGVo+yX/Uw5uE3ai11/X6R6I+rc+TT9IciE9x
x8pxF9y0h2oTxEUDxMw1rdZ0S1ebKEzyBlcaL/61vKh6MZyD+VHiO3gpm09t3EFT
m0clExrmd+AYk5l5J1Zse78e79S6p0sK
=++u3
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
