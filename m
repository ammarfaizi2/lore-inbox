Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751748AbWF2HRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbWF2HRv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 03:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWF2HRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 03:17:51 -0400
Received: from xenotime.net ([66.160.160.81]:33941 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751223AbWF2HRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 03:17:50 -0400
Date: Thu, 29 Jun 2006 00:20:36 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Matt LaPlante <laplam@rpi.edu>
Cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] Kconfig: Typos in fs/Kconfig
Message-Id: <20060629002036.ef53a483.rdunlap@xenotime.net>
In-Reply-To: <20060629020052.f73d7ca1.laplam@rpi.edu>
References: <20060629020052.f73d7ca1.laplam@rpi.edu>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 02:00:52 -0400 Matt LaPlante wrote:

> Fix several typos in fs/Kconfig
> 
> -
> --- b/fs/Kconfig	2006-06-29 01:35:36.000000000 -0400
> +++ a/fs/Kconfig	2006-06-29 01:58:52.000000000 -0400
> @@ -69,7 +69,7 @@
>  	default y
>  
>  config EXT3_FS
> -	tristate "Ext3 journalling file system support"
> +	tristate "Ext3 journaling file system support"

Some dictionaries spell it either way, but it should be spelled
consistently (see 3 lines below).

>  	select JBD
>  	help
>  	  This is the journaling version of the Second extended file system

> @@ -1059,13 +1059,13 @@
>  	  to be made available to the user in the /proc/fs/jffs/ directory.
>  
>  config JFFS2_FS
> -	tristate "Journalling Flash File System v2 (JFFS2) support"
> +	tristate "Journaling Flash File System v2 (JFFS2) support"
>  	select CRC32
>  	depends on MTD
>  	help
> -	  JFFS2 is the second generation of the Journalling Flash File System
> +	  JFFS2 is the second generation of the Journaling Flash File System
>  	  for use on diskless embedded devices. It provides improved wear
> -	  levelling, compression and support for hard links. You cannot use
> +	  leveling, compression and support for hard links. You cannot use

either spelling is OK.

>  	  this on normal block devices, only on 'MTD' devices.
>  
>  	  Further information on the design and implementation of JFFS2 is

---
~Randy
