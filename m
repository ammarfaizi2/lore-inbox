Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWFGEY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWFGEY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 00:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWFGEY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 00:24:28 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:49875 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1750833AbWFGEY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 00:24:28 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc (was: 2.6.18 -mm merge plans)
Date: Wed, 7 Jun 2006 14:25:31 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060604135011.decdc7c9.akpm@osdl.org> <200606071400.49980.ncunningham@linuxmail.org> <e65jj9$m9p$1@terminus.zytor.com>
In-Reply-To: <e65jj9$m9p$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2196648.AtAUTa2bMV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606071425.35802.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2196648.AtAUTa2bMV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 07 June 2006 14:10, H. Peter Anvin wrote:
> Followup to:  <200606071400.49980.ncunningham@linuxmail.org>
> By author:    Nigel Cunningham <ncunningham@linuxmail.org>
> In newsgroup: linux.dev.kernel
>
> > Hi.
> >
> > Sorry for coming in late. I've only just resubscribed after my move.
> >
> > Not sure who originally said this...
> >
> > > > > problems it entails.)  The initial code to have removed
> > > > > is the root-mounting code, with all the various ugly
> > > > > mutations of that (ramdisk loading, NFS root, initrd...)
> >
> > Could I get more explanation of what this means and its implications? I=
'm
> > thinking in particular about the implications for suspending to disk.
> > Will it imply that everyone will _have_ to have an initramfs with some
> > userspace program that sets up device nodes and so on, even if at the
> > moment all you have is root=3D/dev/hda1 resume2=3Dswap:/dev/hda2?
>
> Yes.  That initramfs is embedded in the kernel image.
>
> > Along similar lines, I had been considering eventually including support
> > for putting an image in place of the initrd (for embedded).
>
> You can still override the default buildin initramfs.  Then you get
> the benefit of not carrying a bunch of code with you that can never be
> executed.

Ok. Ta. I guess I should put some time into learning this prior to 2.6.18=20
then, so I can help others through the transition.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart2196648.AtAUTa2bMV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQBEhlU/N0y+n1M3mo0RAoygAJiduFhlu5CcMBGV/8dXC20lKMf5AJ93IEy+
x+s3hh0NIYY6g5frH0fjxw==
=UvVF
-----END PGP SIGNATURE-----

--nextPart2196648.AtAUTa2bMV--
