Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267179AbUFZP5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267179AbUFZP5j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 11:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267181AbUFZP5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 11:57:39 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:12282 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id S267179AbUFZP5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 11:57:30 -0400
Organization: 
Date: Sat, 26 Jun 2004 18:57:15 +0300 (EEST)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: David Eger <eger@havoc.gtf.org>
cc: Hamie <hamish@travellingkiwi.com>, linux-kernel@vger.kernel.org
Subject: Re: radeonfb == blank screen (Thinkpad r50p - FireGL T2 1600x1200
 LCD)
In-Reply-To: <20040626153018.GA17639@havoc.gtf.org>
Message-ID: <Pine.GSO.4.58.0406261852480.29659@thanatos.csd.uoc.gr>
References: <20040618154118.ED0D5106@damned.travellingkiwi.com>
 <20040626153018.GA17639@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also have the same problem with the new radeon driver.
If I use the old radeon driver, it works Ok.
I am using 2.6.7-bk.

I load the kernel with:
"video=radeonfb:1024x768-32@85"

I have the following options in my .config
CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_RADEON=y

CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

Regards
	Panagiotis Papadakos

On Sat, 26 Jun 2004, David Eger wrote:

> It doesn't look like you have fbcon enabled... make sure you have
> at least the following set in your .config:
>
> CONFIG_FB=y
> CONFIG_FB_RADEON=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
>
> -dte
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
