Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965652AbWKTKOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965652AbWKTKOd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 05:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965591AbWKTKOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 05:14:33 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:4041 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S965600AbWKTKOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 05:14:32 -0500
Date: Mon, 20 Nov 2006 11:14:31 +0100
From: Sander <sander@humilis.net>
To: Mingming Cao <cmm@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] Register ext3dev filesystem
Message-ID: <20061120101431.GA8831@favonius>
Reply-To: sander@humilis.net
References: <1155172642.3161.74.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155172642.3161.74.camel@localhost.localdomain>
X-Uptime: 10:52:02 up 17:03, 17 users,  load average: 3.16, 3.00, 3.01
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao wrote (ao):
> Register ext4 filesystem as ext3dev filesystem in kernel.

[cut]

> diff -puN fs/Kconfig~register-ext3dev fs/Kconfig
> --- linux-2.6.18-rc4/fs/Kconfig~register-ext3dev	2006-08-09 15:41:29.277105718 -0700
> +++ linux-2.6.18-rc4-ming/fs/Kconfig	2006-08-09 15:41:29.321106074 -0700
> @@ -138,6 +138,72 @@ config EXT3_FS_SECURITY
>  	  If you are not using a security module that requires using
>  	  extended attributes for file security labels, say N.
>  
> +config EXT3DEV_FS
> +	tristate "Developmenting extended fs support"
> +	select JBD
> +	help
> +	  Ext3dev is a precede filesystem toward next generation
> +	  of extended fs, based on ext3 filesystem code. It will be
> +	  renamed ext4 fs later once this ext3dev is mature and stabled.

[cut]

> +	  To compile this file system support as a module, choose M here: the
> +	  module will be called ext2.  Be aware however that the file system
                                ^^^^
This should be 'ext4'?

	With kind regards, Sander


-- 
Humilis IT Services and Solutions
http://www.humilis.net
