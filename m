Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130357AbQLHFes>; Fri, 8 Dec 2000 00:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130804AbQLHFej>; Fri, 8 Dec 2000 00:34:39 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:46853 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130357AbQLHFef>; Fri, 8 Dec 2000 00:34:35 -0500
Date: Thu, 7 Dec 2000 23:04:07 -0600
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools]
Message-ID: <20001207230407.S6567@cadcamlab.org>
In-Reply-To: <3A30552D.A6BE248C@timpanogas.org> <20001207221347.R6567@cadcamlab.org> <3A3066EC.3B657570@timpanogas.org> <20001208005337.A26577@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001208005337.A26577@alcove.wittsend.com>; from mhw@wittsend.com on Fri, Dec 08, 2000 at 12:53:37AM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Michael Warfield]
> This thing is not armed and dangerous due to an act of ommision.
> It's live and active only through three acts of commision.

We could make it *four* acts of commission. (: (: (:

diff -urk~ fs/Config.in
--- fs/Config.in~	Mon Nov 13 01:43:42 2000
+++ fs/Config.in	Thu Dec  7 23:00:34 2000
@@ -37,7 +37,8 @@
 tristate 'Minix fs support' CONFIG_MINIX_FS
 
 tristate 'NTFS file system support (read only)' CONFIG_NTFS_FS
-dep_mbool '  NTFS write support (DANGEROUS)' CONFIG_NTFS_RW $CONFIG_NTFS_FS $CONFIG_EXPERIMENTAL
+dep_mbool '  NTFS write support (DANGEROUS)' CONFIG_MORON $CONFIG_NTFS_FS $CONFIG_EXPERIMENTAL
+dep_bool  '    Are you sure?  I hope you dont care about your NTFS filesystems' CONFIG_NTFS_RW $CONFIG_MORON
 
 tristate 'OS/2 HPFS file system support' CONFIG_HPFS_FS
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
