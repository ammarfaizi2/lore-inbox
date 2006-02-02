Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWBBWaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWBBWaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWBBWaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:30:06 -0500
Received: from digitalimplant.org ([64.62.235.95]:44187 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932361AbWBBWaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:30:05 -0500
Date: Thu, 2 Feb 2006 14:29:58 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill include/linux/platform.h, default_idle() cleanup
In-Reply-To: <20060128224354.GQ3777@stusta.de>
Message-ID: <Pine.LNX.4.50.0602021429310.20034-100000@monsoon.he.net>
References: <20060128224354.GQ3777@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Sat, 28 Jan 2006, Adrian Bunk wrote:

> include/linux/platform.h contained nothing that was actually used except
> the default_idle() prototype, and is therefore removed by this patch.
>
> This patch does the following with the platform specific default_idle()
> functions on different architectures:
> - remove the unused function:
>   - parisc
>   - sparc64
> - make the needlessly global function static:
>   - arm
>   - h8300
>   - m68k
>   - m68knommu
>   - s390
>   - v850
>   - x86_64
> - add a prototype in asm/system.h:
>   - cris
>   - i386
>   - ia64
>
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

ACK, please make it go away. :-)

Thanks,


	Patrick
