Return-Path: <linux-kernel-owner+w=401wt.eu-S932521AbWLPSh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWLPSh2 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 13:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWLPSh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 13:37:28 -0500
Received: from gateway.crfreenet.org ([81.92.146.254]:37036 "EHLO
	mail.crfreenet.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932518AbWLPSh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 13:37:27 -0500
X-Greylist: delayed 1228 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 13:37:27 EST
Date: Sat, 16 Dec 2006 19:16:55 +0100
From: Ondrej Zajicek <santiago@crfreenet.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Ondrej Zajicek <santiago@crfreenet.org>,
       linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>,
       adaplas@pol.net
Subject: Re: [-mm patch] drivers/video/{s3fb,svgalib}.c: possible cleanups
Message-ID: <20061216181655.GA8604@localhost.localdomain>
References: <20061214225913.3338f677.akpm@osdl.org> <20061216135657.GC3388@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216135657.GC3388@stusta.de>
X-Operating-System: Debian GNU/Linux 3.1 (Sarge)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 02:56:57PM +0100, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - CodingStyle:
>   - opening braces of functions at the beginning of the next line
>   - C99 struct initializers
> - make the following needlessly global functions static:
>   - s3fb.c: s3fb_settile()
>   - s3fb.c: s3fb_tilecopy()
>   - s3fb.c: s3fb_tilefill()
>   - s3fb.c: s3fb_tileblit()
>   - s3fb.c: s3fb_tilecursor()
>   - s3fb.c: s3fb_init()
>   - svgalib.c: svga_regset_size()
> - #if 0 the following unused global functions:
>   - svga_wseq_multi()
>   - svga_dump_var()
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Ondrej Zajicek <santiago@crfreenet.org>

-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."
