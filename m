Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWADIt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWADIt0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 03:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWADItZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 03:49:25 -0500
Received: from dslsmtp.struer.net ([62.242.36.21]:45067 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S1751224AbWADItY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 03:49:24 -0500
Message-ID: <47519.194.237.142.10.1136364561.squirrel@194.237.142.10>
In-Reply-To: <200601040828.k048SgGX019713@shell0.pdx.osdl.net>
References: <200601040828.k048SgGX019713@shell0.pdx.osdl.net>
Date: Wed, 4 Jan 2006 09:49:21 +0100 (CET)
Subject: Re: + gitignore-asm-offsetsh.patch added to -mm tree
From: sam@ravnborg.org
To: akpm@osdl.org
Cc: bgerst@didntduck.org, mm-commits@vger.kernel.org,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew.

This patch is already part of git-kbuild.
Do you have the latest pull from my kbuild repository?

    Sam

>
> The patch titled
>
>      gitignore asm-offsets.h
>
> has been added to the -mm tree.  Its filename is
>
>      gitignore-asm-offsetsh.patch
>
>
> From: Brian Gerst <bgerst@didntduck.org>
>
> Ignore asm-offsets.h for all arches.
>
> Signed-off-by: Brian Gerst <bgerst@didntduck.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  dev/null   |    1 -
>  .gitignore |    1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff -puN .gitignore~gitignore-asm-offsetsh .gitignore
> --- .gitignore~gitignore-asm-offsetsh	2006-01-04 00:28:30.000000000 -0800
> +++ devel-akpm/.gitignore	2006-01-04 00:28:30.000000000 -0800
> @@ -23,6 +23,7 @@ Module.symvers
>  # Generated include files
>  #
>  include/asm
> +include/asm-*/asm-offsets.h
>  include/config
>  include/linux/autoconf.h
>  include/linux/compile.h
> diff -L include/asm-mips/.gitignore -puN
> include/asm-mips/.gitignore~gitignore-asm-offsetsh /dev/null
> --- devel/include/asm-mips/.gitignore
> +++ /dev/null	2003-09-15 06:40:47.000000000 -0700
> @@ -1 +0,0 @@
> -asm_offsets.h
> _
>
> Patches currently in -mm which might be from bgerst@didntduck.org are
>
> mpspec-remove-unneeded-packed-attribute.patch
> gitignore-asm-offsetsh.patch
> gitignore-x86_64-files.patch
> gitignore-misc.patch
> remove-checkconfigpl.patch
>
> -
> To unsubscribe from this list: send the line "unsubscribe mm-commits" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


