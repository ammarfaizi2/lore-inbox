Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWF2LxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWF2LxN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWF2LxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:53:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20620 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964803AbWF2LxM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:53:12 -0400
Subject: Re: [PATCH] Kconfig: Typos in fs/Kconfig
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt LaPlante <laplam@rpi.edu>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20060629020052.f73d7ca1.laplam@rpi.edu>
References: <20060629020052.f73d7ca1.laplam@rpi.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 29 Jun 2006 13:09:39 +0100
Message-Id: <1151582979.23785.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-29 am 02:00 -0400, ysgrifennodd Matt LaPlante:
> Fix several typos in fs/Kconfig

Some wrong, some right.

> -	tristate "Ext3 journalling file system support"
> +	tristate "Ext3 journaling file system support"

There is actually no such word in the dictionaries I have access to
(including the OED). An -ing form would be "-lling" in British English
and ext3 is maintained in the UK which is probably why it uses "lling".
This was discussed at length about three years ago and the lling was the
decision taken at the end of the thread.

>  	select JBD
>  	help
>  	  This is the journaling version of the Second extended file system

That one ought to get fixed instead if anything to be consistent.

> @@ -831,7 +831,7 @@
>  
>  	Some system agents rely on the information in sysfs to operate.
>  	/sbin/hotplug uses device and object attributes in sysfs to assist in
> -	delegating policy decisions, like persistantly naming devices.
> +	delegating policy decisions, like persistently naming devices.

Persistantly is also correct. Both forms are valid English

> -	  levelling, compression and support for hard links. You cannot use
> +	  leveling, compression and support for hard links. You cannot use

levelling with double ll is also correct English. Single "l" is an
Americanism. Please stop trying to "Americanise" the Kconfig files and
just fix actual errors.

>  config JFFS2_CMODE_PRIORITY
>          bool "priority"
>          help
> -          Tries the compressors in a predefinied order and chooses the first

Appears to be a genuine fix 

>  
>  config JFFS2_CMODE_SIZE
> @@ -1892,7 +1892,7 @@
>  	  If you say Y here, you will get an experimental Andrew File System
>  	  driver. It currently only supports unsecured read-only AFS access.
>  
> -	  See <file:Documentation/filesystems/afs.txt> for more intormation.
> +	  See <file:Documentation/filesystems/afs.txt> for more information.

Likewise


