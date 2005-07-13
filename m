Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbVGMTjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbVGMTjJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVGMTgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:36:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18369 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262460AbVGMTgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:36:04 -0400
Date: Wed, 13 Jul 2005 12:34:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: 2.6.13-rc2-mm2 -- include/linux/mtd/xip.h:68:25: error:
 asm/mtd-xip.h: No such file or directory
Message-Id: <20050713123434.3f607f0a.akpm@osdl.org>
In-Reply-To: <a44ae5cd05071308224b39aad5@mail.gmail.com>
References: <a44ae5cd05071308224b39aad5@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane <miles.lane@gmail.com> wrote:
>
> In file included from drivers/mtd/chips/cfi_probe.c:18:
> include/linux/mtd/xip.h:68:25: error: asm/mtd-xip.h: No such file or directory


I assume MTD_CFI should depend on ARM?
