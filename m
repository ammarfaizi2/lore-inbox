Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282020AbRKZShm>; Mon, 26 Nov 2001 13:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282019AbRKZSgG>; Mon, 26 Nov 2001 13:36:06 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:1415 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S282016AbRKZSe2>; Mon, 26 Nov 2001 13:34:28 -0500
Date: Mon, 26 Nov 2001 11:34:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: war <war@starband.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16 Bug (PPC)
Message-ID: <20011126113429.A12583@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <3C028378.50CA616C@starband.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C028378.50CA616C@starband.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 01:01:28PM -0500, war wrote:

> Bug still resides in 2.4.16 still, even after the PPC fixes that were
> applied to 2.4.16-pre1.

Didn't see this one reported before...

> The video driver (plat) is the framebuffer for a few macs, without it,
> I cannot do anything.
> 
> Any plans to fix this?
> 
> //              default_vmode = nvram_read_byte(NV_VMODE);
> //              default_cmode = nvram_read_byte(NV_CMODE);
> 
> Commenting the two undefined functions out in drivers/video/platinumfb.c
> allows for a successful compile.

Is CONFIG_NVRAM on?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
