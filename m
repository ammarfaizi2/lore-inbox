Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbQLHIWL>; Fri, 8 Dec 2000 03:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbQLHIWC>; Fri, 8 Dec 2000 03:22:02 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:59892 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129532AbQLHIVq>; Fri, 8 Dec 2000 03:21:46 -0500
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200012080750.IAA13825@sunrise.pg.gda.pl>
Subject: Re: [Fwd: NTFS repair tools]
To: peter@cadcamlab.org (Peter Samuelson)
Date: Fri, 8 Dec 2000 08:50:47 +0100 (MET)
Cc: jmerkey@timpanogas.org (Jeff V. Merkey), linux-kernel@vger.kernel.org
In-Reply-To: <20001207230407.S6567@cadcamlab.org> from "Peter Samuelson" at Dec 07, 2000 11:04:07 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter Samuelson wrote:"
> [Michael Warfield]
> > This thing is not armed and dangerous due to an act of ommision.
> > It's live and active only through three acts of commision.
> 
> We could make it *four* acts of commission. (: (: (:
> 
> diff -urk~ fs/Config.in
> --- fs/Config.in~	Mon Nov 13 01:43:42 2000
> +++ fs/Config.in	Thu Dec  7 23:00:34 2000
> @@ -37,7 +37,8 @@
>  tristate 'Minix fs support' CONFIG_MINIX_FS
>  
>  tristate 'NTFS file system support (read only)' CONFIG_NTFS_FS
> -dep_mbool '  NTFS write support (DANGEROUS)' CONFIG_NTFS_RW $CONFIG_NTFS_FS $CONFIG_EXPERIMENTAL
> +dep_mbool '  NTFS write support (DANGEROUS)' CONFIG_MORON $CONFIG_NTFS_FS $CONFIG_EXPERIMENTAL
> +dep_bool  '    Are you sure?  I hope you dont care about your NTFS filesystems' CONFIG_NTFS_RW $CONFIG_MORON
>  
>  tristate 'OS/2 HPFS file system support' CONFIG_HPFS_FS

Of course, you know that it *WILL NOT* work as CONFIG_MORON is nowhere 
defined ... ?

Andrzej
--
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
