Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbUJ0LL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbUJ0LL6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 07:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUJ0LL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 07:11:58 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17416 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262374AbUJ0LLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 07:11:43 -0400
Date: Wed, 27 Oct 2004 13:11:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: 2.6.10-rc1-mm1: reiser4 delete_from_page_cache compile error
Message-ID: <20041027111102.GD2550@stusta.de>
References: <20041026213156.682f35ca.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <20041026213156.682f35ca.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, Oct 26, 2004 at 09:31:56PM -0700, Andrew Morton wrote:
>...
> All 394 patches:
>...
> reiser4-delete_from_page_cache.patch
>   reiser4 delete_from_page_cache
>...


<--  snip  -->

...
  CC      fs/reiser4/page_cache.o
fs/reiser4/page_cache.c: In function `drop_page':
fs/reiser4/page_cache.c:763: warning: implicit declaration of function `delete_from_page_cache'
...
  LD      .tmp_vmlinux1
fs/built-in.o(.text+0xd2393): In function `drop_page':
: undefined reference to `delete_from_page_cache'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Hugh already requested to drop his patch.


cu
Adrian

- -- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBf4JGmfzqmE8StAARAoq4AKCf9MLA96xH2zEAzARZm3x3pFQxxACfWqNf
Kxdi7/k9BoAZQujxs9RjgVU=
=lAUl
-----END PGP SIGNATURE-----
