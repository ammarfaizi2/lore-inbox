Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161141AbVKDKwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161141AbVKDKwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 05:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbVKDKwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 05:52:41 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:45400 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1161141AbVKDKwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 05:52:40 -0500
Message-ID: <436B3D74.3080807@gentoo.org>
Date: Fri, 04 Nov 2005 10:52:36 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051023)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers (v2)
References: <43146CC3.4010005@gentoo.org>	 <58cb370e05083008121f2eb783@mail.gmail.com>	 <43179CC9.8090608@gentoo.org> <58cb370e050927062049be32f8@mail.gmail.com> <433B179A.8010600@gentoo.org>
In-Reply-To: <433B179A.8010600@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Support multiple controllers in the via82cxxx IDE driver, revised patch. 
> Cable detection and ISA bridge finding have been moved into their own 
> functions.
> 
> Unfortunately I won't have access to a via82cxxx machine until December 
> now, this patch is only compile-tested.

I went home a little earlier than expected and tested this patch on my 
single-controller via machine. It works fine. Is this ok to be merged?

> Signed-off-by: Daniel Drake <dsd@gentoo.org>
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.6.14-rc1/drivers/ide/pci/via82cxxx.c.orig	2005-09-28 22:31:22.000000000 +0100
> +++ linux-2.6.14-rc1/drivers/ide/pci/via82cxxx.c	2005-09-28 23:06:50.000000000 +0100
