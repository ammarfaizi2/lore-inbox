Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbUKGUtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUKGUtk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 15:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbUKGUtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 15:49:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36783 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261326AbUKGUtj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 15:49:39 -0500
Date: Sun, 7 Nov 2004 15:32:31 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] fix THIS_MODULE error in arp.c
Message-ID: <20041107173231.GA30130@logos.cnet>
References: <200411071458.12846.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411071458.12846.mbuesch@freenet.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael, 

All of the three corrections you have been made already.

Thanks for caring anyway. 

On Sun, Nov 07, 2004 at 02:58:12PM +0100, Michael Buesch wrote:
> Hi Marcelo,
> 
> This fixes an "undeclared THIS_MODULE" compiletime error.
> 
> Sorry for the attachment. My mailer is currently broken and
> corrupts diffs.

> --- linux-2.4.28-rc1-bk4/net/ipv4/arp.c.orig	Sun Nov  7 15:27:45 2004
> +++ linux-2.4.28-rc1-bk4/net/ipv4/arp.c	Sun Nov  7 15:28:42 2004
> @@ -94,6 +94,7 @@
>  #include <linux/stat.h>
>  #include <linux/init.h>
>  #include <linux/jhash.h>
> +#include <linux/module.h>
>  #ifdef CONFIG_SYSCTL
>  #include <linux/sysctl.h>
>  #endif

