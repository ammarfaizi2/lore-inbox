Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbUJ0OTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbUJ0OTZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 10:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbUJ0OTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 10:19:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:65298 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262459AbUJ0OTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 10:19:14 -0400
Date: Wed, 27 Oct 2004 16:18:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Mathieu Segaud <matt@minas-morgul.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm1
Message-ID: <20041027141841.GG2550@stusta.de>
References: <20041026213156.682f35ca.akpm@osdl.org> <87breos8f4.fsf@barad-dur.crans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <87breos8f4.fsf@barad-dur.crans.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, Oct 27, 2004 at 01:32:47PM +0200, Mathieu Segaud wrote:
> 
> It fails to build if CONFIG_FS_REISER4=y and issues a depmod error if reiser4
> is built modular, as delete_from_page_cache has been ripped out

Revert reiser4-delete_from_page_cache.patch .

> Best regards,
> 
> Mathieu

cu
Adrian

- -- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBf65BmfzqmE8StAARAt5rAKCXVqVoaFT+n08H7Fl+bTzVz9pjPwCfbLKi
K62m2ycCA0sxDEeVkWwetIg=
=qWyx
-----END PGP SIGNATURE-----
