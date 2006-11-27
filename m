Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933713AbWK0VcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933713AbWK0VcW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 16:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933692AbWK0VcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 16:32:22 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:8151 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S933661AbWK0VcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 16:32:21 -0500
Date: Mon, 27 Nov 2006 13:32:05 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: what is the purpose of "CONFIG_DMA_IS_DMA32"?
In-Reply-To: <Pine.LNX.4.64.0611271314280.3419@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0611271330390.3406@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611271314280.3419@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006, Robert P. J. Day wrote:

> 
>   perhaps a silly question, but:
> 
> $ grep -r "DMA_IS_DMA32" *
> arch/ia64/defconfig:CONFIG_DMA_IS_DMA32=y
> arch/ia64/configs/sim_defconfig:CONFIG_DMA_IS_DMA32=y
> arch/ia64/configs/zx1_defconfig:CONFIG_DMA_IS_DMA32=y
> arch/ia64/configs/tiger_defconfig:CONFIG_DMA_IS_DMA32=y
> arch/ia64/configs/bigsur_defconfig:CONFIG_DMA_IS_DMA32=y
> arch/ia64/configs/gensparse_defconfig:CONFIG_DMA_IS_DMA32=y
> $
> 
> what is the purpose of a configuration symbol that is set but never
> involved in a conditional check?
> 
>   i'm guessing that used to be a config setting in the ia64/Kconfig
> file that has since vanished.

Correct that config setting was eliminated in the 2.6.19 development 
cycle. Refreshing the config files would be advisable.
5A
