Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754106AbWKGIOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbWKGIOQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 03:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754107AbWKGIOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 03:14:16 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:49756 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1754106AbWKGIOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 03:14:16 -0500
Date: Tue, 7 Nov 2006 09:13:26 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: schwidefsky@de.ibm.com, linux390@de.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-390@vm.marist.edu
Subject: Re: [PATCH] s390 need definitions for pagefault_disable and pagefault_enable
Message-ID: <20061107081326.GA7057@osiris.boeblingen.de.ibm.com>
References: <20061101235407.a92f94a5.akpm@osdl.org> <7e94d9e3967f67b1151689921a21fd65@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e94d9e3967f67b1151689921a21fd65@pinky>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 06:35:21PM +0000, Andy Whitcroft wrote:
> diff --git a/arch/s390/lib/uaccess_std.c b/arch/s390/lib/uaccess_std.c
> index 9bbeaa0..ad296dc 100644
> --- a/arch/s390/lib/uaccess_std.c
> +++ b/arch/s390/lib/uaccess_std.c
> @@ -11,6 +11,8 @@
>  
>  #include <linux/errno.h>
>  #include <linux/mm.h>
> +#include <linux/uaccess.h>
> +
>  #include <asm/uaccess.h>
>  #include <asm/futex.h>

http://lkml.org/lkml/2006/11/2/54

;)
