Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVFMVlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVFMVlz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVFMVkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:40:35 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:10726 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261426AbVFMVf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:35:59 -0400
Date: Mon, 13 Jun 2005 23:35:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Christian Leber <christian@leber.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lzma support: decompression lib, initrd support
In-Reply-To: <20050612214305.GA26732@core.home>
Message-ID: <Pine.LNX.4.61.0506132333380.3743@scrub.home>
References: <20050607213204.GA2645@core.home> <20050607145903.4b2ac9bf.akpm@osdl.org>
 <20050612214305.GA26732@core.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 12 Jun 2005, Christian Leber wrote:

> +config BLK_DEV_RAM_GZ
> +       bool "Gzip compressed ramdisk support"
> +       depends on BLK_DEV_RAM=y || BLK_DEV_RAM=m

"depends on BLK_DEV_RAM" is enough.

> +config BLK_DEV_RAM_LZMA
> +       bool "Lzma compressed ramdisk support (EXPERIMENTAL)"
> +       depends on BLK_DEV_RAM=y || BLK_DEV_RAM=m && EXPERIMENTAL
> +       default n

Same as above and "default n" is useless.

bye, Roman
