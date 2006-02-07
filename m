Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWBGIuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWBGIuc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 03:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWBGIuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 03:50:32 -0500
Received: from ozlabs.org ([203.10.76.45]:39066 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932447AbWBGIuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 03:50:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17384.24235.960221.979322@cargo.ozlabs.ibm.com>
Date: Tue, 7 Feb 2006 19:47:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: Haren Myneni <haren@us.ibm.com>
Cc: linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linuxppc64-dev@ozlabs.org, Milton Miller <miltonm@bga.com>,
       hpa@zytor.com
Subject: Re: [PATCH] Fix in free initrd when overlapped with crashkernel region
In-Reply-To: <43E818EB.7010003@us.ibm.com>
References: <43E818EB.7010003@us.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haren Myneni writes:

> --- 2616-rc2.orig/include/linux/kexec.h	2006-02-06 19:08:01.000000000 -0800
> +++ 2616-rc2/include/linux/kexec.h	2006-02-06 19:06:37.000000000 -0800
> @@ -6,6 +6,7 @@
>  #include <linux/list.h>
>  #include <linux/linkage.h>
>  #include <linux/compat.h>
> +#include <linux/ioport.h>
>  #include <asm/kexec.h>

What's this hunk for?

Paul.
