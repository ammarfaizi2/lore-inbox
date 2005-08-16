Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbVHPBjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbVHPBjh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 21:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVHPBjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 21:39:37 -0400
Received: from smtp.enter.net ([216.193.128.24]:45840 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S965070AbVHPBjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 21:39:36 -0400
From: "D. ShadowWolf" <dhazelton@enter.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: oops in 2.6.13-rc6-git5
Date: Mon, 15 Aug 2005 21:46:00 -0400
User-Agent: KMail/1.7.2
References: <200508150133.49400.dhazelton@enter.net> <9a8748490508150522f6c3921@mail.gmail.com>
In-Reply-To: <9a8748490508150522f6c3921@mail.gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6942770.AorGf0fXII";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508152146.07553.dhazelton@enter.net>
X-Virus-Checker-Version: Enter.Net Virus Scanner 1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6942770.AorGf0fXII
Content-Type: multipart/mixed;
  boundary="Boundary-01=_YVUADKm3ObguThX"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_YVUADKm3ObguThX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 15 August 2005 08:22, you wrote:
> On 8/15/05, D. ShadowWolf <dhazelton@enter.net> wrote:
> > Decided to take the latest git kernel for a run and ran into the
> > following oops when shutting the system down to try it from a cold-boot
> > situation. I wasn't able to capture the oops as it happened, but
> > thankfully syslog was still running and I managed to trap it there.
>
> serial console, netconsole, console on line-printer  are all useful
> for capturing Oops data. There are detailed guides in Documentation/
>
> > When the oops occurred the system was almost shut down, but the command
> > that was executing at the time was to save the sync the hardware clock =
to
> > Linux (I think)... the trap from my kernel logs (I have each class of
> > kernel event redirected to a different file. This leads to some huge
> > files in a short span, but is useful for debugging a new kernel) The
> > kernel is tainted by the lt modem drivers (lt_modem & lt_serial) however
> > the problem does not appear to be in either of those, and they function
> > properly under 2.6.12.3
> >
> > I'm running a basic Slackware 10 distribution (other than the ltmodem
> > drivers (gone inside the next month))
>
> I've tried to reproduce the Oops here with your config, but my
> hardware is too different to match your config, so I had to make some
> changes to get the kernel running. In the end I was not able to
> reproduce it.
>
> Can you reproduce the crash reliably?
> Can you reproduce the crash with a non-tainted kernel?

Haven't attempted to reproduce - I actually tried the kernel against my bet=
ter=20
judgement -- I've had hard-drives killed by faulty kernels in the past. But=
=20
since you've requested, yes, I'll give it a shot. Reproducing it with an=20
untainted kernel should be as simple as just booting the system, but I'm=20
going to have to go monkey my init scripts to disable the automagic loading=
=20
of the modules that taint the kernel.

As for doing it using a network or serial console - I don't have the equipm=
ent=20
anymore. I used to have a decent WYSE serial console, but that died in the=
=20
same storm that caught my old system... If you know where I can pick up an=
=20
old line printer or a cheap serial terminal I'll buy it and get it setup=20
ASAP.

DRH

--Boundary-01=_YVUADKm3ObguThX
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

--Boundary-01=_YVUADKm3ObguThX--

--nextPart6942770.AorGf0fXII
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBDAUVfj4KAu4sAwyoRAqLtAJ94EkmGiLxQ1xLhaAfvijSoQsG5ywCfc11h
aR8qSNlS0TpiPAv68cM6qTc=
=I0Nk
-----END PGP SIGNATURE-----

--nextPart6942770.AorGf0fXII--
