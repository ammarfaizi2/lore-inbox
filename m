Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbVHPFpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbVHPFpc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 01:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbVHPFpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 01:45:32 -0400
Received: from smtp.enter.net ([216.193.128.24]:42756 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S965117AbVHPFpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 01:45:31 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: oops in 2.6.13-rc6-git5
Date: Tue, 16 Aug 2005 01:51:21 -0400
User-Agent: KMail/1.7.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200508150133.49400.dhazelton@enter.net> <9a8748490508150522f6c3921@mail.gmail.com>
In-Reply-To: <9a8748490508150522f6c3921@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1948286.TMjGRTXMTp";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508160151.28999.dhazelton@enter.net>
X-Virus-Checker-Version: Enter.Net Virus Scanner 1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1948286.TMjGRTXMTp
Content-Type: multipart/mixed;
  boundary="Boundary-01=_a7XADHOxVrWURcZ"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_a7XADHOxVrWURcZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 15 August 2005 08:22, Jesper Juhl wrote:
> Can you reproduce the crash reliably?
> Can you reproduce the crash with a non-tainted kernel?

I've tried several times now to reproduce the oops, but there might have be=
en=20
another factor that led to the oops, because just booting the kernel and=20
shutting down does not trigger it. I have tried reproducing all conditions =
up=20
to the time that the oops actually occurred and think it might just be my=20
hardware going flaky - so I have reloaded the module that taints the kernel=
=20
(have done this already and having the module loaded when the powerdown=20
started did not trigger the oops) and am seeing if using it for any period =
of=20
time causes the oops to occur. If it does I will try the other driver=20
available for the modem, although that one also contains proprietary code.=
=20
The upside is that it does not make use of any functions marked as deprecat=
ed=20
in any version of the kernel, where the official driver requires me to=20
re-enable a deprecated function that had been made non-exported by the=20
kernel.

DRH


--Boundary-01=_a7XADHOxVrWURcZ
Content-Type: application/pgp-keys;
  name="OpenPGP key 0xA6992F96300F159086FF28208F8280BB8B00C32A"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=0xA6992F96300F159086FF28208F8280BB8B00C32A.asc

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.2.7 (GNU/Linux)

mQGiBEJS3C0RBADeLmOaFYR40Pd/n86pPD10DYJIiSuEEJJAovJI/E3kjYgKnom0
CmwPa9oEXf4B3FMVcqB0ksKrhA8ECVsNRwO91+LObFczyc59XBgYDScn9h9t+lu4
IZTObcR1SnQ/I+YdeJpd12ZcuLAnQ3EGl9+7bBOJgr4JcwM6Idixtg92kwCg4vhj
97BpUqPSk6cwD4LMRoqzABcEAJPZdEpYDwrXiy5aQx8ax+CbdfJX+XhxVcOrqzoI
8TS7yZPcE1rszCANpCb6xg7TReWyIOu+FQvfzLg5e7Cl2XtVC66RDgdlTBy/pjnX
fxIOIW5Hl+cVaWLBJ2tdAOIiyGPrKC/uTyY/N+4iQTsQK2l/yxc3fOgEN0g9AY9a
GSkHBACmX6awLcrdnxY0p2J/OmRtT4oOWcbq5TUchM9SzPLLIatGZEs7jUal9OYo
ZzmRPjElgM4koF7TTB+71FTUaqVGd0smJVKfJ1nVp6nefxOI6MH/v8/4j7Bvtb1Y
Ypkrxt+R8WWUI1L19yEDp55rvzqIkkLtmJZP/QJg2e7zxTYYi7Q5RGFuaWVsIFIu
IEhhemVsdG9uIChUaGUgU2hhZG93V29sZikgPGRoYXplbHRvbkBlbnRlci5uZXQ+
iF4EExECAB4FAkJS3C0CGwMGCwkIBwMCAxUCAwMWAgECHgECF4AACgkQj4KAu4sA
wyoRwwCeN+PEM8jpxxpxiG4dGyXNwTZBtNkAoKAtdOgeK66+zPEtJFanUeFe6lRX
uQENBEJS3DoQBACfejnq7GSJ7g8nL669pXDVFFrabOaiIC4sH0FgqbK+Oewm4h77
Ir5QL9SsHWvYSBYxnCODvR7zHv8HefWgJ4duC66b8PCXY/qcmxhRhYtdEssx/ncm
BhNXlPPvsyPT/e7PdZkDv7dJuVtVJrLVVeSniz+3KBIIYb395B+yhzjPLwAEDQP9
HFlaX9Duyg8c+RFhqStVrIluy7ZTg8pGjF2KLPsCmcSVzVLLhplF1M6Fs1CSgwRe
OCDRWPFohcaSxPIwIdlS0h2HOnWziPVpzh4HWylbtC6cZYg7dpgaDlJA00ikUlyj
6/bxwNwBuVoNSegIe0mN+xAIsvXM2TLuY1fFYcmeRxmISQQYEQIACQUCQlLcOgIb
DAAKCRCPgoC7iwDDKsoRAJwKJETliGVgcCSTMd7sq/WMOe9VAgCgxq4MRqWBvPWY
fPs99FjiIC8asFc=
=vwF/
-----END PGP PUBLIC KEY BLOCK-----

--Boundary-01=_a7XADHOxVrWURcZ--

--nextPart1948286.TMjGRTXMTp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBDAX7gj4KAu4sAwyoRAlglAJ4nM/ENZUzTRiRMI0k1vUtnjXeHQQCcDmB8
bX+GakXNneFhIo2YzTo2tPM=
=++BO
-----END PGP SIGNATURE-----

--nextPart1948286.TMjGRTXMTp--
