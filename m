Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266623AbSLCXaN>; Tue, 3 Dec 2002 18:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266626AbSLCXaN>; Tue, 3 Dec 2002 18:30:13 -0500
Received: from dp.samba.org ([66.70.73.150]:16343 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266623AbSLCXaM>;
	Tue, 3 Dec 2002 18:30:12 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Erlend Aasland <erlend-a@ux.his.no>
Cc: bfennema@falcon.csc.calpoly.edu, dave@trylinux.com,
       linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL PATCH 2.5] get rid of CONFIG_UDF_RW (i386) 
In-reply-to: Your message of "Tue, 03 Dec 2002 13:51:20 BST."
             <20021203125120.GA2417@johanna5.ux.his.no> 
Date: Wed, 04 Dec 2002 10:37:04 +1100
Message-Id: <20021203233744.AA03F2C29E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021203125120.GA2417@johanna5.ux.his.no> you write:
> I noticed that CONFIG_UDF_RW is not used anywhere, so I removed it from all
> the defconfigs.

But it's used in 2.4.20.  It *looks* like it's on by default in 2.5,
but I just want the authors to confirm that the option isn't coming
back.

Ben, Dave?

Rusty.

> diff -urN linux-2.5.50/arch/i386/defconfig linux-2.5.50-eaa/arch/i386/defconfig
> --- linux-2.5.50/arch/i386/defconfig	Tue Oct 22 00:13:57 2002
> +++ linux-2.5.50-eaa/arch/i386/defconfig	Tue Dec  3 00:48:05 2002
> @@ -804,7 +804,6 @@
>  CONFIG_EXT2_FS=y
>  # CONFIG_SYSV_FS is not set
>  CONFIG_UDF_FS=y
> -# CONFIG_UDF_RW is not set
>  # CONFIG_UFS_FS is not set
>  # CONFIG_UFS_FS_WRITE is not set
>  # CONFIG_XFS_FS is not set
> 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
