Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945971AbWGOBvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945971AbWGOBvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 21:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945974AbWGOBvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 21:51:04 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:19639 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1945972AbWGOBvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 21:51:03 -0400
Subject: Re: [2.6 patch] saa7134: rename dmasound_{init,exit}
From: hermann pitton <hermann-pitton@arcor.de>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060715003710.GO3633@stusta.de>
References: <20060715003710.GO3633@stusta.de>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 03:54:24 +0200
Message-Id: <1152928464.5738.5.camel@pc08.localdom.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, den 15.07.2006, 02:37 +0200 schrieb Adrian Bunk:
> Two different exports with the same name are not a good idea:
> 
> $ grep -r EXPORT_SYMBOL\(dmasound_init\) *
> drivers/media/video/saa7134/saa7134-core.c:EXPORT_SYMBOL(dmasound_init);
> sound/oss/dmasound/dmasound_core.c:EXPORT_SYMBOL(dmasound_init);
> $ 
> 
> This patch renames the saa7134 dmasound_{init,exit} to 
> saa7134_dmasound_{init,exit}.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 11 Jul 2006

Mauro is on a first short vacation after 1 1/2 years.
Please have patience until he is back.

You might be used to, that Gerd wasn't for six years.

Hermann



