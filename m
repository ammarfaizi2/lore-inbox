Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269210AbUJKTyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269210AbUJKTyc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 15:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269239AbUJKTyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 15:54:31 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:36305 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S269210AbUJKTyE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 15:54:04 -0400
Message-ID: <416AD644.8010302@ens-lyon.fr>
Date: Mon, 11 Oct 2004 20:51:48 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1
References: <20041011032502.299dc88d.akpm@osdl.org>
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

The old Gamma DRM driver seems broken.
(I removed the inter_module_ "deprecated" warnings)

Regards,
Brice Goglin

  In file included from drivers/char/drm/gamma_drv.c:42:
drivers/char/drm/gamma_context.h: Dans la fonction « 
gamma_context_switch_complete »:
drivers/char/drm/gamma_context.h:193: error: structure has no member 
named `next_buffer'
drivers/char/drm/gamma_context.h:193: error: structure has no member 
named `next_buffer'
In file included from drivers/char/drm/gamma_drv.c:44:
drivers/char/drm/gamma_old_dma.h: Dans la fonction « 
gamma_clear_next_buffer »:
drivers/char/drm/gamma_old_dma.h:40: error: structure has no member 
named `next_buffer'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member 
named `next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member 
named `next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member 
named `next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member 
named `next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member 
named `next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member 
named `next_queue'
drivers/char/drm/gamma_old_dma.h:42: error: structure has no member 
named `next_queue'
drivers/char/drm/gamma_old_dma.h:44: error: structure has no member 
named `next_queue'
In file included from drivers/char/drm/gamma_drv.c:46:
drivers/char/drm/drm_drv.h: Dans la fonction « gamma_release »:
drivers/char/drm/drm_drv.h:808: attention : implicit declaration of 
function `gamma_ctxbitmap_free'
make[3]: *** [drivers/char/drm/gamma_drv.o] Erreur 1
make[2]: *** [drivers/char/drm] Erreur 2
make[1]: *** [drivers/char] Erreur 2
make: *** [drivers] Erreur 2
