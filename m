Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVGIOMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVGIOMs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 10:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVGIOMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 10:12:48 -0400
Received: from ns.schottelius.org ([213.146.113.242]:43665 "HELO
	ei.schottelius.org") by vger.kernel.org with SMTP id S261418AbVGIOMr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 10:12:47 -0400
Date: Sat, 9 Jul 2005 17:12:27 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: halt: init exits/panic
Message-ID: <20050709151227.GM1322@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YIwHDYD8sUXtBKvt"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.12.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YIwHDYD8sUXtBKvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

What's the 'correct behaviour' of an init system, if someone wants
to shutdown the system?

I currently do:

- call reboot(RB_POWER_OFF/RB_AUTOBOOT/RB_HALT_SYSTEM)
- _exit(0)

Is this exit() call wrong? If I do RB_HALT_SYSTEM and _exit(0) after,
the kernel panics.

Should init simply sleep, return to normal processing or exit?

Sincerly,

Nico

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--YIwHDYD8sUXtBKvt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQs/pWrOTBMvCUbrlAQJqVxAAg6AssHolHxztrVnHnNOgu0jRWyu6G9Tz
aoGbvSScKhs3kstRxaPxpsn/+07anwSrSoFGJcOjmJMHfF2yppHhM3dxguoMdxlS
CUhAf3+JtbVYfZER+gLhoHZPtHbJiew/AShktKGzaTJSCVNA+zrVldbsiAnNzezu
rOUusnhpIQHX/cbYpYHxw0gI6H1W2YRaN7z+AC3V62I8JSC8fR7wr6RIuemFxzsm
KB/0CDcSMX/sEf45JZ/W6ihl2W8IgsCWMp+B5pIw2XAaZlwpoWl70i9PI6Mupwla
Mr8ilmUotTrRxggLduofoYeXDDiY1MYD5L2BtpwhjXMf9FM5r3anP63qxTC3Et7k
LROL6VI2Ab1BmCaxDsTUfW6nEFER+oqlYzjjWJSD5n9fbb8IEdpkkzv7V4lTmU51
Jmn0BWVR82/mzIa2Fax01rYOYGhi1d/OCEcIql4Glrkb3GRQBR0jN7xStXabdg/c
iojfzesG9aV/VMORwVZrsEUMiPzbYtbeyF1IR+Q966PhC3F6M7BrTO/lMlrh1XZi
L8XFDycc/ni1C5jZjDekVFLkZJuFqDuaEczYu2IJuLtQNx4sdToPB8DE+oOPLCyO
onPNePiULh+iMAeu/sRjlmD0Adi7gE7in5oB1SVKzdDgWqdHJFiUQq01+mplAhVC
vxy25tc9P4g=
=YLI9
-----END PGP SIGNATURE-----

--YIwHDYD8sUXtBKvt--
