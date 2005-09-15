Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbVIOGRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbVIOGRi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOGRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:17:38 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:9700 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932527AbVIOGRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:17:38 -0400
Message-ID: <432911BB.2050301@t-online.de>
Date: Thu, 15 Sep 2005 08:16:27 +0200
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roger Heflin <rheflin@atipa.com>
CC: "'Jim Gifford'" <maillist@jg555.com>, "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'Andi Kleen'" <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
References: <EXCHG2003Aj5p1Fjxe0000006ad@EXCHG2003.microtech-ks.com>
In-Reply-To: <EXCHG2003Aj5p1Fjxe0000006ad@EXCHG2003.microtech-ks.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCDC4B0D9B8F977A39934B7D6"
X-ID: SrnctsZb8eIZ3K6rRI-fbfOwFR6yJc7cKorEMe2n-8Ww5cGoPhVecS
X-TOI-MSGID: 7f616739-8e1c-48bc-b90a-9b2257e1df64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCDC4B0D9B8F977A39934B7D6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Roger Heflin wrote:
> 
> I guess I see 5 choices:
> 
> #1:
> Use lib for whatever the standard os/arch size is.
> 
> Use lib32 for the non-standard size.
> 
> #2: 
> Continue the current mess.
> 
> #3:
> Use both lib32 and lib64 and maybe put a link from lib to the
> default one, probably lib64.
> 
> #4:
> Use both lib32 and lib64 and don't put a link.
> 
> #5:
> Designate the bit size in the name of the lib, ie libc.so64 or
> libc.so32 or something similar and put them all in the same
> directory and let the lib loading code take care of finding the
> correct size.
> 

I would say there is a sixth option, at least in theory: Add some
special symbols like 'LP64' or 'ILP32' to the symbol table, and add
a reference to one of these symbols to every *.o file. The linker
could distinguish between 32bit and 64bit implementation within the
same library. This would be similar to a symbol-versioned library.
But I am not sure whether this would be a reasonable option.


Regards

Harri

--------------enigCDC4B0D9B8F977A39934B7D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDKRG/UTlbRTxpHjcRAknhAKCFRD7k13t8Bp5ky8v4Szg8cf23uQCgi9QQ
WL34ST+QKgDeILQCrlioaVk=
=/l5M
-----END PGP SIGNATURE-----

--------------enigCDC4B0D9B8F977A39934B7D6--
