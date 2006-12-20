Return-Path: <linux-kernel-owner+w=401wt.eu-S1030372AbWLTWDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWLTWDN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWLTWDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:03:13 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43243 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030372AbWLTWDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:03:12 -0500
Date: Wed, 20 Dec 2006 14:03:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nicolas FERRE <nicolas.ferre@rfo.atmel.com>
Cc: David Brownell <d-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input/spi: add ads7843 support to ads7846 touchscreen
 driver
Message-Id: <20061220140304.af85754c.akpm@osdl.org>
In-Reply-To: <4582B4F4.2050106@rfo.atmel.com>
References: <4582B4F4.2050106@rfo.atmel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006 15:45:08 +0100
Nicolas FERRE <nicolas.ferre@rfo.atmel.com> wrote:

> Add support for the ads7843 touchscreen controller to the ads7846
> driver code.

Generates a lot of errors when applied to the current mainline kernel. 
Please prepare and test patches against Linus's current git tree.

> --- a/input/touchscreen/ads7846.c	(.../linux-2.6.19-at91/drivers)	(revision 634)
> +++ b/input/touchscreen/ads7846.c	(.../linux-2.6.19-atmel-devel/drivers)	(revision 634)


That should be

--- a/drivers/input/ads7846.c
+++ b/drivers/input/ads7846.c

ie: `patch -p1' form, thanks.
