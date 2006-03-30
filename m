Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWC3Ltd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWC3Ltd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWC3Ltc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:49:32 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:45983 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750854AbWC3Ltb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:49:31 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend2-2.2.2 for 2.6.16.
Date: Thu, 30 Mar 2006 19:39:40 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Mark Lord <lkml@rtr.ca>,
       linux-kernel@vger.kernel.org
References: <200603281601.22521.ncunningham@cyclades.com> <200603292050.33622.ncunningham@cyclades.com> <200603301134.49089.rjw@sisk.pl>
In-Reply-To: <200603301134.49089.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2838126.tcYTXPCy8i";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603301939.45872.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2838126.tcYTXPCy8i
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 30 March 2006 19:34, Rafael J. Wysocki wrote:
> Hi,
>
> On Wednesday 29 March 2006 12:50, Nigel Cunningham wrote:
> > Don't bother suggesting that to x86_64 owners: compilation is currently
> > broken in vbetool/lrmi.c (at least).

I get:

nigel@nigel_c_laptop:/usr/src/uswsusp/suspend$ make suspend
cc -Wall -O2 -c vbetool/lrmi.c -o vbetool/lrmi.o
vbetool/lrmi.c:83: error: field =E2=80=98vm=E2=80=99 has incomplete type
vbetool/lrmi.c: In function =E2=80=98get_int_seg=E2=80=99:
vbetool/lrmi.c:111: warning: cast to pointer from integer of different size
vbetool/lrmi.c: In function =E2=80=98get_int_off=E2=80=99:
vbetool/lrmi.c:118: warning: cast to pointer from integer of different size
vbetool/lrmi.c: In function =E2=80=98LRMI_init=E2=80=99:
vbetool/lrmi.c:147: warning: cast from pointer to integer of different size
vbetool/lrmi.c:155: warning: cast from pointer to integer of different size
vbetool/lrmi.c:156: warning: cast from pointer to integer of different size
vbetool/lrmi.c: In function =E2=80=98set_regs=E2=80=99:
vbetool/lrmi.c:191: error: =E2=80=98IF_MASK=E2=80=99 undeclared (first use =
in this function)
vbetool/lrmi.c:191: error: (Each undeclared identifier is reported only once
vbetool/lrmi.c:191: error: for each function it appears in.)
vbetool/lrmi.c:191: error: =E2=80=98IOPL_MASK=E2=80=99 undeclared (first us=
e in this function)
vbetool/lrmi.c: In function =E2=80=98em_inbl=E2=80=99:
vbetool/lrmi.c:337: error: invalid lvalue in asm output 0
vbetool/lrmi.c: In function =E2=80=98em_inb=E2=80=99:
vbetool/lrmi.c:345: error: invalid lvalue in asm output 0
vbetool/lrmi.c: In function =E2=80=98em_inw=E2=80=99:
vbetool/lrmi.c:353: error: invalid lvalue in asm output 0
vbetool/lrmi.c: In function =E2=80=98em_inl=E2=80=99:
vbetool/lrmi.c:361: error: invalid lvalue in asm output 0
vbetool/lrmi.c: In function =E2=80=98run_vm86=E2=80=99:
vbetool/lrmi.c:594: warning: implicit declaration of function =E2=80=98VM86=
_TYPE=E2=80=99
vbetool/lrmi.c:594: error: =E2=80=98VM86_INTx=E2=80=99 undeclared (first us=
e in this function)
vbetool/lrmi.c:595: warning: implicit declaration of function =E2=80=98VM86=
_ARG=E2=80=99
vbetool/lrmi.c:613: error: =E2=80=98VIF_MASK=E2=80=99 undeclared (first use=
 in this function)
vbetool/lrmi.c:613: error: =E2=80=98TF_MASK=E2=80=99 undeclared (first use =
in this function)
vbetool/lrmi.c:618: error: =E2=80=98VM86_UNKNOWN=E2=80=99 undeclared (first=
 use in this=20
function)
vbetool/lrmi.c: In function =E2=80=98LRMI_int=E2=80=99:
vbetool/lrmi.c:840: error: =E2=80=98IF_MASK=E2=80=99 undeclared (first use =
in this function)
vbetool/lrmi.c:840: error: =E2=80=98IOPL_MASK=E2=80=99 undeclared (first us=
e in this function)
make: *** [vbetool/lrmi.o] Error 1
nigel@nigel_c_laptop:/usr/src/uswsusp/suspend$=20

Regards,

Nigel

--nextPart2838126.tcYTXPCy8i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEK6dhN0y+n1M3mo0RAshqAKCumAFXJKls/wbha6YYKyAApOE77wCcCfkk
BdyTRgfNlg3c9Nx7g5JC1H4=
=wcZA
-----END PGP SIGNATURE-----

--nextPart2838126.tcYTXPCy8i--
