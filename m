Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161166AbVICGan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbVICGan (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 02:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161160AbVICGan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 02:30:43 -0400
Received: from smtp.enter.net ([216.193.128.24]:55055 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1161153AbVICGam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 02:30:42 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: GFS, what's remaining
Date: Sat, 3 Sep 2005 02:42:31 -0400
User-Agent: KMail/1.7.2
Cc: David Teigland <teigland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
References: <20050901104620.GA22482@redhat.com> <20050903051841.GA13211@redhat.com> <1125728040.3223.2.camel@laptopd505.fenrus.org>
In-Reply-To: <1125728040.3223.2.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart11853249.b7Je2gSEPu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509030242.37536.dhazelton@enter.net>
X-Virus-Checker-Version: Enter.Net Virus Scanner 1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart11853249.b7Je2gSEPu
Content-Type: multipart/mixed;
  boundary="Boundary-01=_YXUGD+G1+J64an6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_YXUGD+G1+J64an6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 03 September 2005 02:14, Arjan van de Ven wrote:
> On Sat, 2005-09-03 at 13:18 +0800, David Teigland wrote:
> > On Thu, Sep 01, 2005 at 01:21:04PM -0700, Andrew Morton wrote:
> > > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > > > - Why GFS is better than OCFS2, or has functionality which
> > > > > OCFS2 cannot possibly gain (or vice versa)
> > > > >
> > > > > - Relative merits of the two offerings
> > > >
> > > > You missed the important one - people actively use it and
> > > > have been for some years. Same reason with have NTFS, HPFS,
> > > > and all the others. On that alone it makes sense to include.
> > >
> > > Again, that's not a technical reason.  It's _a_ reason, sure.=20
> > > But what are the technical reasons for merging gfs[2], ocfs2,
> > > both or neither?
> > >
> > > If one can be grown to encompass the capabilities of the other
> > > then we're left with a bunch of legacy code and wasted effort.
> >
> > GFS is an established fs, it's not going away, you'd be hard
> > pressed to find a more widely used cluster fs on Linux.  GFS is
> > about 10 years old and has been in use by customers in production
> > environments for about 5 years.
>
> but you submitted GFS2 not GFS.

I'd rather not step into the middle of this mess, but you clipped out=20
a good portion that explains why he talks about GFS when he submitted=20
GFS2.  Let me quote the post you've pulled that partial paragraph=20
from: "The latest development cycle (GFS2) has focused on improving
performance, it's not a new file system -- the "2" indicates that it's=20
not ondisk compatible with earlier versions."

In other words he didn't submit the original, but the new version of=20
it that is not compatable with the original GFS on disk format. =20
While it is clear that GFS2 cannot claim the large installed user=20
base or the proven capacity of the original (it is, after all, a new=20
version that has incompatabilities) it can claim that as it's=20
heritage and what it's aiming towards, the same as ext3 can (and=20
does) claim the power and reliability of ext2.

In this case I've been following this thread just for the hell of it=20
and I've noticed that there are some people who seem to not want to=20
even think of having GFS2 included in a mainline kernel for personal=20
and not technical reasons. That does not describe most of the people=20
on this list, many of whom have helped debug the code (among other=20
things), but it does describe a few.

I'll go back to being quiet now...=20

DRH

--Boundary-01=_YXUGD+G1+J64an6
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

--Boundary-01=_YXUGD+G1+J64an6--

--nextPart11853249.b7Je2gSEPu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBDGUXdj4KAu4sAwyoRAtDCAJ9lC07Lq2BwLehHaHdeaWLhN/MNFQCdE6OR
J9Hj9vFbNJEmeAGSpy79kU4=
=aGik
-----END PGP SIGNATURE-----

--nextPart11853249.b7Je2gSEPu--
