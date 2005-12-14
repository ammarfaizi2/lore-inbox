Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbVLNXWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbVLNXWo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbVLNXWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:22:43 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56073 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965071AbVLNXWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:22:42 -0500
Date: Wed, 14 Dec 2005 23:22:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][expample patch] Make the kernel -Wshadow clean ?
Message-ID: <20051214232226.GD31955@flint.arm.linux.org.uk>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200512150019.57124.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512150019.57124.jesper.juhl@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 12:19:57AM +0100, Jesper Juhl wrote:
> -			void (*dtor)(struct page *page);
> +			void (*dtor)(struct page *pge);

Note that this one just needs to be:
			void (*dtor)(struct page *);

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
