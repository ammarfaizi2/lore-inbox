Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317013AbSFQVDF>; Mon, 17 Jun 2002 17:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317016AbSFQVDE>; Mon, 17 Jun 2002 17:03:04 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:8386 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317013AbSFQVDA>; Mon, 17 Jun 2002 17:03:00 -0400
Date: Mon, 17 Jun 2002 17:02:20 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200206172102.g5HL2K011511@devserv.devel.redhat.com>
To: Martin Schwidefsky <martin.schwidefsky@debitel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.22: common code changes for s/390.
In-Reply-To: <mailman.1024345597.31683.linux-kernel2news@redhat.com>
References: <mailman.1024345597.31683.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.5.22/include/linux/auto_fs.h	Mon Jun 17 04:31:22 2002
> +++ linux-2.5.22-s390/include/linux/auto_fs.h	Tue Jun  4 09:52:06 2002
> @@ -45,7 +45,8 @@
>   * If so, 32-bit user-space code should be backwards compatible.
>   */
>  
> -#if defined(__sparc__) || defined(__mips__) || defined(__x86_64__) || defined(__powerpc__)
> +#if defined(__sparc__) || defined(__mips__) || defined(__x86_64) \
> + || defined(__powerpc__) || defined(__s390__)

Sure it's not missing __ at the end of x86_64?
Testing if anyone reads it, are you :)

-- Pete
