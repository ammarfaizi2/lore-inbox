Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTLLAIJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 19:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbTLLAHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 19:07:47 -0500
Received: from alhya.freenux.org ([213.41.137.38]:32694 "EHLO
	moria.freenux.org") by vger.kernel.org with ESMTP id S264437AbTLLAHk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 19:07:40 -0500
From: Mickael Marchand <marchand@kde.org>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Silicon image 3114 SATA link (really basic support)
Date: Fri, 12 Dec 2003 01:07:49 +0100
User-Agent: KMail/1.5.94
References: <20031203204445.GA26987@gtf.org> <200312091954.28224.marchand@kde.org> <200312092114.47241.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200312092114.47241.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200312120107.55031.marchand@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

if anyone is able to tell me how to find the io address of the SATA ports I 
could make this patch support the 4 drives of Sil3114 (only the 2 first are 
working atm).
As I really don't know how to find this, I prefer ask to the kernel experts ;)
Once I have this info, making the patch is a matter of a few minutes I think

I tried looking at lspci/scanpci outputs but could not really find any usefull 
informations recording io ports.

Cheers,
Mik

Le Tuesday 09 December 2003 21:14, Bartlomiej Zolnierkiewicz a écrit :
> On Tuesday 09 of December 2003 19:54, Mickael Marchand wrote:
> > the attached patch makes _both_ drivers work (whereas the previous one
> > made only the libata one working)
>
> Great!  Now I know it is really working.
>
> I've already corrected your previous patch and included it in -bart1 patch:
> http://www.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1/broke
>n-out/ide-siimage-sil3114.patch
>
> Yes, I forgot to send you corrected patch, sorry. :-)
>
> --bart
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/2QbVyOYzc4nQ8j0RAhO/AJ9bm0gJ7uwGlKquhXaIYm1GMRBVWQCdGPwn
wbQskwDqvS7PI54zTefPquM=
=p1UV
-----END PGP SIGNATURE-----
