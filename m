Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261690AbSJJREu>; Thu, 10 Oct 2002 13:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbSJJREu>; Thu, 10 Oct 2002 13:04:50 -0400
Received: from atlas.inria.fr ([138.96.66.22]:23976 "EHLO atlas.inria.fr")
	by vger.kernel.org with ESMTP id <S261690AbSJJREt>;
	Thu, 10 Oct 2002 13:04:49 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
Organization: SEMIR - INRIA Sophia Antipolis
To: linux-kernel@vger.kernel.org
Subject: 2.4.17, CONFIG_HIGHMEM4G=y and mem= boot parameter.
Date: Thu, 10 Oct 2002 19:10:33 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210101910.33565.Nicolas.Turro@sophia.inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi,
We have a computer with 4 Go of ram, and a matrox meteor frame grabber.
The meteor board need some ram to be reserved and not used by linux,
using mem=<total RAM - 2Mo> kernel parameter (in lilo.conf for me).

If i use a kernel without CONFIG_HIGHMEM enabled, everything goes fine,
but of course i endup with +- 800 Mo of available RAM for linux.

If i add CONFIG_HIGHMEM4G support to my kernel, without mem setting,
the kernel boots, sees about 3800 Mo of RAM, but my meteor doesn't work.

If i use CONFIG_HIGHMEM4G  and mem=3600M , my system doesn't boot,
crashing with an obscure EXT2 error and 'no init found'

Any help ?

N. Turro
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9pbSJty/HpgyBIboRAvX7AJ9/5cj3KOFUrjKGpuYg1JE1FLTYgwCdE2Te
s2rptKcodT0xVZkNnWgxYpQ=
=Ck8u
-----END PGP SIGNATURE-----
