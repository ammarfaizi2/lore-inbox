Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266307AbSLTXVY>; Fri, 20 Dec 2002 18:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266316AbSLTXVY>; Fri, 20 Dec 2002 18:21:24 -0500
Received: from services.cam.org ([198.73.180.252]:9228 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S266307AbSLTXVX>;
	Fri, 20 Dec 2002 18:21:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Date: Fri, 20 Dec 2002 18:29:18 -0500
User-Agent: KMail/1.4.3
References: <20021218094714.43C712C076@lists.samba.org> <200212181803.23279.tomlins@cam.org> <20021219105909.GE29122@suse.de>
In-Reply-To: <20021219105909.GE29122@suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212201829.18430.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 19, 2002 05:59 am, Dave Jones wrote:
> On Wed, Dec 18, 2002 at 06:03:23PM -0500, Ed Tomlinson wrote:
>  > both with and without agp 3.0 enabled I get:
>  >
>  > Dec 18 17:51:10 oscar kernel: Linux agpgart interface v0.100 (c) Dave
>  > Jones Dec 18 17:51:29 oscar kernel: via_agp: Unknown symbol
>  > agp_generic_agp_3_0_enable
>
> I don't get this. Can you mail me your .config ?

Dave, with the pull from this morning (8am EST), it almost works modular.
I get:

Dec 20 18:20:19 oscar upsd[636]: Communication established
Dec 20 18:20:47 oscar kernel: Linux agpgart interface v0.100 (c) Dave Jones
Dec 20 18:20:47 oscar kernel: agpgart: Detected VIA MVP3 chipset
Dec 20 18:20:47 oscar kernel: agpgart: AGP aperture is 64M @ 0xe0000000
Dec 20 18:20:58 oscar kernel: [drm] Initialized mga 3.1.0 20021029 on minor 0
Dec 20 18:20:58 oscar kernel: Module agpgart cannot be unloaded due to unsafe usage in drivers/char/ag
p/backend.c:58

but find this in the X startup log.

(EE) MGA: Failed to load module "mga_hal" (module does not exist, 0)
(EE) MGA(0): [agp] Out of memory (-1014)
(EE) MGA(0): [drm] failed to remove DRM signal handler
DRIUnlock called when not locked

ideas?

Ed Tomlinson

