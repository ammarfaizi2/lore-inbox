Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262841AbVGMPTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbVGMPTI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 11:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVGMPTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 11:19:08 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:812 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262680AbVGMPTG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 11:19:06 -0400
Date: Wed, 13 Jul 2005 17:06:55 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Fabio Massimo Di Nitto <fabbione@fabbione.net>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: Re: [PATCH] modpost needs to cope with new glibc elf header on sparc (resend - my MTA did eat the previous one apparently)
Message-ID: <20050713170655.GA8197@mars.ravnborg.org>
References: <20050713062549.1ED325032@trider-g7.fabbione.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713062549.1ED325032@trider-g7.fabbione.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi everybody,
>   recently a change in the glibc elf.h header has been introduced causing
> modpost to spawn tons of warnings (like the one below) building the kernel on sparc:
> 
Applied.

You need to reread SubmittingPatches:
> diff -urNad --exclude=CVS --exclude=.svn ./scripts/mod/modpost.c /usr/src/dpatchtemp/dpep-work.EcxGXN/linux-source-2.6.12-2.6.12/scripts/mod/modpost.c
> --- ./scripts/mod/modpost.c	2005-06-17 21:48:29.000000000 +0200
> +++ /usr/src/dpatchtemp/dpep-work.EcxGXN/linux-source-2.6.12-2.6.12/scripts/mod/modpost.c	2005-06-30 09:29:54.000000000 +0200

This does not apply with patch -p1. I fixed it manually.

	Sam
