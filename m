Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbUJ0SEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbUJ0SEe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbUJ0SCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:02:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35601 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262536AbUJ0R6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 13:58:04 -0400
Date: Wed, 27 Oct 2004 19:57:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1: undefined reference to `hpet_alloc'
Message-ID: <20041027175727.GA2713@stusta.de>
References: <416E343C.70900@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <416E343C.70900@t-online.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, Oct 14, 2004 at 10:09:32AM +0200, Harald Dunkel wrote:

> Hi folks,

Hi Harald,

> It seems that it is possible to set CONFIG_HPET_TIMER without
> setting CONFIG_HPET:
> 
> % g HPET .config
> CONFIG_HPET_TIMER=y
> # CONFIG_HPET is not set
> 
> AFAIR this was reported before, but obviously the problem
> is still in.

I tried to reproduce your problem in 2.6.10-rc1-mm1, but I didn't get 
the link error.

Are you still able to reproduce it in 2.6.10-rc1-mm1?
If yes, please send your .config .

> Regards
> 
> Harri

cu
Adrian

- -- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBf+GGmfzqmE8StAARAqimAKC7xNxSfBHJGihAEj/Two4eWaSeawCffmtb
qYOX0v92NdLcLdgMG34k+VE=
=ZZ2d
-----END PGP SIGNATURE-----
