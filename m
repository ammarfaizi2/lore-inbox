Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267323AbUHPB7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbUHPB7f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 21:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266534AbUHPB7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 21:59:34 -0400
Received: from ozlabs.org ([203.10.76.45]:15821 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267323AbUHPB7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 21:59:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16671.57622.138928.813542@cargo.ozlabs.ibm.com>
Date: Mon, 16 Aug 2004 08:17:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove dead CONFIG_KERNEL_ELF Kconfig entry
In-Reply-To: <20040814185419.GA29000@lst.de>
References: <20040814185419.GA29000@lst.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

> We don't allow non-ELF kernels since 2.0 days, and surprisingly this
> is not actually checked anywhere.
> 
> 
> --- 1.73/arch/ppc/Kconfig	2004-07-02 07:23:46 +02:00
> +++ edited/arch/ppc/Kconfig	2004-07-04 00:21:37 +02:00
> @@ -799,10 +799,6 @@
>  config HIGHMEM
>  	bool "High memory support"
>  
> -config KERNEL_ELF
> -	bool
> -	default y
> -

Looks good to me.

Paul.
