Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbVJERk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbVJERk7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 13:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbVJERk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 13:40:59 -0400
Received: from smtp.enter.net ([216.193.128.24]:21261 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1030293AbVJERk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 13:40:58 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Marc Perkel <marc@perkel.com>
Subject: Re: what's next for the linux kernel?
Date: Wed, 5 Oct 2005 13:45:52 +0000
User-Agent: KMail/1.7.2
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, linux-kernel@vger.kernel.org
References: <20051002204703.GG6290@lkcl.net> <200510050122.39307.dhazelton@enter.net> <4343694F.5000709@perkel.com>
In-Reply-To: <4343694F.5000709@perkel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1524345.mzOcXRejMQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510051346.00853.dhazelton@enter.net>
X-Virus-Checker-Version: Enter.Net Virus Scanner 1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1524345.mzOcXRejMQ
Content-Type: multipart/mixed;
  boundary="Boundary-01=_Rk9QDWY+qqrGEZZ"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_Rk9QDWY+qqrGEZZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 05 October 2005 05:49, Marc Perkel wrote:
> D. Hazelton wrote:
> >>Novell Netware type permissions. ACLs are a step in the right
> >>direction but Linux isn't any where near where Novell was back in
> >>1990. Linux lets you - for example - to delete files that you
> >> have no read or write access rights to.
> >
> >As someone else pointed out, this is because unlinking is related
> > to your access permissions on the parent directory and not the
> > file.
>
> Right - that's Unix "inside the box" thinking. The idea is to make
> the operating system smarter so that the user doesn't have to deal
> with what's computer friendly - but reather what makes sense to the
> user. From a user's perspective if you have not rights to access a
> file then why should you be allowed to delete it?

You're confusing concepts. In Unix unlinking a file is not the same as=20
deleting it. As has already been said, to remove content from a file,=20
you truncate it, which, no surprise, requires that you have write=20
access to a file. Even in DOS deleting a file, unless you use a=20
secure delete program, doesn't delete the file - it merely changes=20
the name slightly and marks the chain of FAT cluster entries as=20
usable.=20

I've had the displeasure of having to fix a netware system that had=20
been so fsked up by an admin that had been fired that it was easier=20
for me to remove the volume and restore it from a backup. The problem=20
was that he made a large number of files with the administrative=20
account removed from the ACL's... And the same problem plagues=20
(plagued? I haven't checked up on this in a while) NTFS. It is all to=20
possible to create a bunch of files with "Administrator" and all=20
other "Administrator" class users form the ACL's and then kill that=20
user.

> Now - the idea is to create choice. If you need to emulate Unix
> nehavior for compatibility that's fine. But I would migrate away
> from that into a permissions paradygme that worked like Netware.

So provide a filesystem and a set of tools for that filesystem. Nobody=20
is standing in your way and the Linux filesystem and block device=20
layers are open enough that this is an easy (though not simple) task.

> I started with Netware and I'm spoiled. They had it right 15 years
> ago and Linux isn't any where near what I was with Netware and DOS
> in 1990. Once you've had this kind of permission power Linux is a
> real big step down.

Oh, so that explains it. You got used to one paradigm and haven't been=20
able to adjust to another. Well, as I have previously said, go ahead=20
and provide us with the work.

> So - the thread is about the future so I say - time to fix Unix.

Time to fix Unix? I doubt something seriously borked would have=20
outlasted every other OS on the market. Unix was around before=20
Netware and, IMHO, will be around a long time after the last=20
adherents of NetWare are gone. (and with MS doing it's level best to=20
kill NetWare with it's own shared filesystems and built-in networking=20
this cannot be that far off. After all, Netware was developed to fill=20
a vacancy in the MS world.)

DRH

--Boundary-01=_Rk9QDWY+qqrGEZZ
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

--Boundary-01=_Rk9QDWY+qqrGEZZ--

--nextPart1524345.mzOcXRejMQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBDQ9kYj4KAu4sAwyoRAplNAKC+gJC1rBQRe6xz7K21JC2DGm9DQwCgqpz/
adw3Fixy6zI9i6q9W/f6ysI=
=x5Lz
-----END PGP SIGNATURE-----

--nextPart1524345.mzOcXRejMQ--
