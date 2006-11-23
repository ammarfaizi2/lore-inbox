Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757147AbWKWBMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757147AbWKWBMK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 20:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757176AbWKWBMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 20:12:10 -0500
Received: from smtp.osdl.org ([65.172.181.25]:20370 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757147AbWKWBMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 20:12:08 -0500
Date: Wed, 22 Nov 2006 17:08:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>,
       Roman Zippel <zippel@linux-m68k.org>, Phil Oester <kernel@linuxace.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.19-rc6: known regressions with patches available
Message-Id: <20061122170815.f9c04fc3.akpm@osdl.org>
In-Reply-To: <20061123005457.GG3557@stusta.de>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
	<20061123005457.GG3557@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 01:54:57 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> This email lists some known regressions in 2.6.19-rc6 compared to 2.6.18
> with patches available.
> 
> The first issue (for an unknown it never occured before - is seems some 
> random Kconfig change has triggered this latent bug) seems to have the 
> potential of affecting more users.
> 
> The second issue is so exotic that I wouldn't have listed it if there 
> was no patch, but considering that the patch looks safe I don't see why 
> this regression shouldn't be fixed in 2.6.19.
> 
> 
> Subject    : xconfig crashes on x86_64
> References : http://lkml.org/lkml/2006/11/19/177
> Submitter  : Randy Dunlap <randy.dunlap@oracle.com>
> Handled-By : Roman Zippel <zippel@linux-m68k.org>
> Patch      : http://lkml.org/lkml/2006/11/20/340
> Status     : patch available
> 
> 
> Subject    : menuconfig problems with TERM=vt100
> References : http://lkml.org/lkml/2006/11/13/369
> Submitter  : Phil Oester <kernel@linuxace.com>
> Caused-By  : Sam Ravnborg <sam@ravnborg.org>
>              commit 350b5b76384e77bcc58217f00455fdbec5cac594
> Handled-By : Roman Zippel <zippel@linux-m68k.org>
> Patch      : http://lkml.org/lkml/2006/11/20/341
> Status     : patch available

I have both these queued for 2.6.19, thanks.
