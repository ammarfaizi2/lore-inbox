Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTELP1F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 11:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbTELP1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 11:27:05 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:42245 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S262228AbTELP1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 11:27:04 -0400
Date: Mon, 12 May 2003 17:39:45 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Dave Jones <davej@codemonkey.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new kconfig goodies
In-Reply-To: <20030512143207.GA6459@suse.de>
Message-ID: <Pine.LNX.4.44.0305121737560.5042-100000@serv>
References: <Pine.LNX.4.44.0305111838300.14274-100000@serv>
 <20030512143207.GA6459@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 12 May 2003, Dave Jones wrote:

>  > config AGP
>  > 	tristate "/dev/agpgart (AGP Support)"
>  > 
>  > config GART_IOMMU
>  > 	bool "IOMMU support"
>  > 	enable AGP
>  > 
>  > This will cause AGP to be selected if GART_IOMMU is selected.
> 
> Looks good. However, will this still offer the CONFIG_AGP tristate
> in the menu? If IOMMU is on, there must be no way to switch off
> the agpgart support on which it depends.

Yes, you will see AGP, but you can't change it.

bye, Roman

