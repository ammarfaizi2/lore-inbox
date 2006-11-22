Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756698AbWKVTRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698AbWKVTRM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756701AbWKVTRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:17:12 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23020 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1756698AbWKVTRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:17:11 -0500
Date: Wed, 22 Nov 2006 19:21:29 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Akinobu Mita <akinobu.mita@gmail.com>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata: fix platform_device_register_simple() error check
Message-ID: <20061122192129.7cf20628@localhost.localdomain>
In-Reply-To: <20061122184755.GD2985@APFDCB5C>
References: <20061122184755.GD2985@APFDCB5C>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 03:47:55 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> The return value of platform_device_register_simple() should be checked
> by IS_ERR().
> 
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: Alan <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Thanks for noticing that one.

Acked-by: Alan Cox <alan@redhat.com>
