Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWHBGRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWHBGRz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 02:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWHBGRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 02:17:55 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:23787 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751266AbWHBGRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 02:17:54 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: single bit flip detector.
Date: Wed, 2 Aug 2006 08:20:26 +0200
User-Agent: KMail/1.9.3
Cc: Andreas Schwab <schwab@suse.de>, Alexey Dobriyan <adobriyan@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060801184451.GP22240@redhat.com> <20060801235109.GB12102@redhat.com> <20060802001626.GA14689@redhat.com>
In-Reply-To: <20060802001626.GA14689@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1472269.KKEQVTxF0C";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608020820.31931.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1472269.KKEQVTxF0C
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dave Jones wrote:
> On Tue, Aug 01, 2006 at 07:51:09PM -0400, Dave Jones wrote:
>  > I'm going for the record of 'most times a patch gets submitted in one
>  > day'. And to think we were complaining that patches don't get enough
>  > review ? :) If every change had this much polish, we'd be awesome.
>
> Sigh. Spaces before printk. Whatever next.
> I am now officially bored of seeing this patch.

> diff --git a/mm/slab.c b/mm/slab.c
> index 21ba060..39f1183 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1638,10 +1638,28 @@ static void poison_obj(struct kmem_cache
>  static void dump_line(char *data, int offset, int limit)
>  {
>  	int i;
> +	unsigned char total =3D 0, bad_count =3D 0, errors;
>  	printk(KERN_ERR "%03x:", offset);
> -	for (i =3D 0; i < limit; i++)
> +	for (i =3D 0; i < limit; i++) {

You might want to add a newline before the actual code to make it more=20
readable :)

Eike

--nextPart1472269.KKEQVTxF0C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBE0EQvXKSJPmm5/E4RAkJ7AKCPq1G0He4puV++TxddXV/YQO8zEQCeOQpx
6VGc1TDTDIm5ieaYu9l0gDY=
=4yHn
-----END PGP SIGNATURE-----

--nextPart1472269.KKEQVTxF0C--
