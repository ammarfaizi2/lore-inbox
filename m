Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWGPNul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWGPNul (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 09:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWGPNul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 09:50:41 -0400
Received: from mail.gmx.net ([213.165.64.21]:5066 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030320AbWGPNul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 09:50:41 -0400
X-Authenticated: #428038
Date: Sun, 16 Jul 2006 15:50:38 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: ivo welch <ivowel@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserFS?
Message-ID: <20060716135038.GA8850@merlin.emma.line.org>
Mail-Followup-To: ivo welch <ivowel@gmail.com>,
	linux-kernel@vger.kernel.org
References: <50d1c22d0607160545rd06c828n55ad9bbbd2f20bfd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50d1c22d0607160545rd06c828n55ad9bbbd2f20bfd@mail.gmail.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12-2006-07-14
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jul 2006, ivo welch wrote:

> dear linux geeks:  may I ask why the "new" (many years old) reiser
> filesystem is not making it into the kernel?  it does seem to have
> some advantages, if nothing else at least over the old reiser v3.

Why would anyone want ReiserFS in the kernel that is discontinued by its
developers when it's just started to become stabile and useful, with
bugs (hashing) remaining, as happened with 3.6? Who is going to make
guarantees this won't happen again with reiser4?

Besides that, there had been technical discrepancies that prevented
reiser4 inclusion into the baseline kernel when it was suggested, search
the archives for details.

There's ext3, you can set the dir_index option (either for mke2fs, or
afterwards with tune2fs, then unmount and run e2fsck -fD) and you're set.

-- 
Matthias Andree
