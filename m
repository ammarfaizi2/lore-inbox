Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267519AbUJDNov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267519AbUJDNov (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 09:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267571AbUJDNov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 09:44:51 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20372 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267519AbUJDNot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 09:44:49 -0400
Date: Mon, 4 Oct 2004 06:43:27 -0700
From: Paul Jackson <pj@sgi.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au, akpm@zip.com.au
Subject: Re: Too many __s in donauboe.h
Message-Id: <20041004064327.32975f30.pj@sgi.com>
In-Reply-To: <20041004120109.GA25380@elf.ucw.cz>
References: <20041004120109.GA25380@elf.ucw.cz>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel wrote:
> @@ -316,7 +315,7 @@
>    chipio_t io;                  /* IrDA controller information */
>    struct qos_info qos;          /* QoS capabilities for this device */
>  
> -  __u32 flags;                  /* Interface flags */
> +  u32 flags;                  /* Interface flags */
>  
>    struct pci_dev *pdev;         /*PCI device */
>    int base;                     /*IO base */

Trading a couple of ugly underscores, for an ugly off by two spacing?
Sounds like progress to me ;).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
