Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317083AbSGNU17>; Sun, 14 Jul 2002 16:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317091AbSGNU16>; Sun, 14 Jul 2002 16:27:58 -0400
Received: from lsanca2-ar27-4-3-064-252.lsanca2.dsl-verizon.net ([4.3.64.252]:14468
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S317083AbSGNU16>; Sun, 14 Jul 2002 16:27:58 -0400
Date: Sun, 14 Jul 2002 13:30:37 -0700 (PDT)
From: Ben Clifford <benc@hawaga.org.uk>
To: Heinz Diehl <hd@cavy.de>
cc: Dave Jones <davej@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.25-dj2
In-Reply-To: <20020714111153.GA4692@chiara.cavy.de>
Message-ID: <Pine.LNX.4.44.0207141312250.28537-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 14 Jul 2002, Heinz Diehl wrote:

> > Just kill those lines.
> 
> This leads to:

That happens even if you don't kill those lines. I have ide-scsi as a 
module and if I say "make bzImage modules" I get the SCSI error handling 
error, and if I just say "make bzImage" I get the __udivdi3 error.

The only occurence of __udvidi3 in source code seems to be in the 
arch-specific directories (and not the i386 one - which I am using). 

Looks like it is being referenced somehow in the procfs .o files (but not 
procfs source)

- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
http://www.hawaga.org.uk/ben/

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9Md9vsYXoezDwaVARAmH8AJ9Dca0CI0qTU6PkYQ5lAg6C5ZvxkQCeOXJ/
Ux2lMrRF9pRU5P2M9kr3o9c=
=bEVu
-----END PGP SIGNATURE-----

