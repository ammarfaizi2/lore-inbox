Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282012AbRKZShm>; Mon, 26 Nov 2001 13:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282027AbRKZSgN>; Mon, 26 Nov 2001 13:36:13 -0500
Received: from quark.didntduck.org ([216.43.55.190]:46352 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S282037AbRKZSfX>; Mon, 26 Nov 2001 13:35:23 -0500
Message-ID: <3C028B63.3A6AF1EC@didntduck.org>
Date: Mon, 26 Nov 2001 13:35:15 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: war <war@starband.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16 Bug (PPC)
In-Reply-To: <3C028378.50CA616C@starband.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

war wrote:
> 
> Bug still resides in 2.4.16 still, even after the PPC fixes that were
> applied to 2.4.16-pre1.
> 
> If nobody cares about PPC updates, I guess I should put the box back on
> the shelf.
> 
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
> It also allows for the video driver to be brought up succesfully.
> 
> Now will this bug be fixed in 2.4.17 for PPC or should I just put my PPC
> back on the shelf? :)

Is CONFIG_NVRAM built in to the kernel?

--

				Brian Gerst
