Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316959AbSEWQl7>; Thu, 23 May 2002 12:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316960AbSEWQl6>; Thu, 23 May 2002 12:41:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:14854 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316959AbSEWQl5>;
	Thu, 23 May 2002 12:41:57 -0400
Date: Thu, 23 May 2002 18:41:41 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [2.5.17-cset1.656] patch to compile nfs (and maybe others)
Message-Id: <20020523184141.6fe51ec2.sebastian.droege@gmx.de>
In-Reply-To: <20020523173425.A1713@infradead.org>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="H3Va4SRB_=.9I5QU"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--H3Va4SRB_=.9I5QU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2002 17:34:25 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, May 23, 2002 at 06:26:01PM +0200, Sebastian Droege wrote:
> > Hi,
> > this trivial patch adds 3 missing #includes
> > without them at least nfs won't compile
> 
> Please don't add additional includes to namei.h - it's purpose is to
> ubbork the headers instead of makeing them more complicated.
> 
> I have another bunch of header fixes (including the proper fixe for
> this failure) queued up for Linux after the buffer_head.h stuff goes in.
> 
Ok... but then we've to copy the FASTCALL stuff (which is used elsewhere too) from linkage.h to namei.h or something else...
Thanks anyway

Bye
--H3Va4SRB_=.9I5QU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE87RvMe9FFpVVDScsRAiAZAKCsmgz/YfvciDgtdt+htY/knnYSBgCcD6jc
t6kBizx0t4HE/1a66S/UgWU=
=ijCU
-----END PGP SIGNATURE-----

--H3Va4SRB_=.9I5QU--

