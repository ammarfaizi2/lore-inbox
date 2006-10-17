Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWJQSqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWJQSqt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWJQSqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:46:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:39323 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751123AbWJQSqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:46:48 -0400
Subject: Re: config EXT4DEV_FS question
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Mingming Cao <cmm@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Randy Dunlap <rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0610172034090.30104@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610170100480.30479@yvahk01.tjqt.qr>
	 <1161088430.14171.2.camel@kleikamp.austin.ibm.com>
	 <Pine.LNX.4.61.0610172034090.30104@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 13:46:42 -0500
Message-Id: <1161110803.14171.26.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-17 at 20:37 +0200, Jan Engelhardt wrote:
> Then I suggest removing the bogus part, as per following patch.
> 
> Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
Acked-by: Dave Kleikamp <shaggy@austin.ibm.com>

> 
> Index: linux-2.6.19-rc2/fs/Kconfig
> ===================================================================
> --- linux-2.6.19-rc2.orig/fs/Kconfig
> +++ linux-2.6.19-rc2/fs/Kconfig
> @@ -12,9 +12,7 @@ config EXT2_FS
>  	  Ext2 is a standard Linux file system for hard disks.
>  
>  	  To compile this file system support as a module, choose M here: the
> -	  module will be called ext2.  Be aware however that the file system
> -	  of your root partition (the one containing the directory /) cannot
> -	  be compiled as a module, and so this could be dangerous.
> +	  module will be called ext2.
>  
>  	  If unsure, say Y.
>  
> @@ -98,9 +96,7 @@ config EXT3_FS
>  	  (available at <http://sourceforge.net/projects/e2fsprogs/>).
>  
>  	  To compile this file system support as a module, choose M here: the
> -	  module will be called ext3.  Be aware however that the file system
> -	  of your root partition (the one containing the directory /) cannot
> -	  be compiled as a module, and so this may be dangerous.
> +	  module will be called ext3.
>  
>  config EXT3_FS_XATTR
>  	bool "Ext3 extended attributes"
> @@ -163,9 +159,7 @@ config EXT4DEV_FS
>  	  features will be added to ext4dev gradually.
>  
>  	  To compile this file system support as a module, choose M here. The
> -	  module will be called ext4dev.  Be aware, however, that the filesystem
> -	  of your root partition (the one containing the directory /) cannot
> -	  be compiled as a module, and so this could be dangerous.
> +	  module will be called ext4dev.
>  
>  	  If unsure, say N.
>  
> #<EOF>
> 
> 
> 	-`J'
-- 
David Kleikamp
IBM Linux Technology Center

