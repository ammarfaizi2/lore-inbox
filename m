Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWF2Nsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWF2Nsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 09:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWF2Nsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 09:48:46 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:33440 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750703AbWF2Nsp (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 09:48:45 -0400
Message-Id: <200606291348.k5TDm8t8003750@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Paolo Ornati <ornati@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org, Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       jensmh@gmx.de
Subject: Re: [PATCH] Documentation: remove duplicate cleanups
In-Reply-To: Your message of "Thu, 29 Jun 2006 15:11:55 +0200."
             <20060629151155.5609d59f@localhost>
From: Valdis.Kletnieks@vt.edu
References: <20060629134002.1b06257c@localhost>
            <20060629151155.5609d59f@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1151588887_2928P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 29 Jun 2006 09:48:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1151588887_2928P
Content-Type: text/plain; charset=us-ascii

On Thu, 29 Jun 2006 15:11:55 +0200, Paolo Ornati said:

> -                        matches the field we filled in in the struct
> +                        matches the field we filled in the struct
>                          video_device when registering.</entry>
> ------------
> 
> I'm not 100% sure of this.

Both are technically correct.  The original should be parsed (the field we
filled in) (in the struct).  The revision changes it to 'the field we filled'.
Probably should change, just to avoid 'Paris in the the spring' effects...

>  Note that ALL kernel parameters listed below are CASE SENSITIVE, and that
> -a trailing = on the name of any parameter states that that parameter will
> +a trailing = on the name of any parameter states that parameter will

> The old one looks correct.

Again, both are technically correct, but the change should be made...

> -caches are expected to be coherent, there's no guarantee that that coherency
> +caches are expected to be coherent, there's no guarantee that coherency
>  will be ordered.  This means that whilst changes made on one CPU will

> Not sure.

Again, should change, unless we want to emphasize "that *THAT* coherency
will be ordered" (as opposed to some other concurrenly applicable coherency).

>  The driver is not real good at the moment for finding the card.  You can
>  'help' it by changing the order of the potential addresses in the structure
> -found in the pt_init() function so the address of where the card is is put
> +found in the pt_init() function so the address of where the card is put
>  first.

> The old one looks correct.

Only by virtue of incredibly poor sentence structure originally.

"so the address of the card is put first." would be simpler and better.



--==_Exmh_1151588887_2928P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEo9oXcC3lWbTT17ARAiQcAKCVxPFaZZ41X8lHUPnGTbJjlSAo0QCg7ZFi
2DFxYg3ZgM4BnC/vqTScMg0=
=IO+y
-----END PGP SIGNATURE-----

--==_Exmh_1151588887_2928P--
