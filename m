Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270322AbTHQPtF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 11:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270324AbTHQPtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 11:49:05 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:38541 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270322AbTHQPtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 11:49:04 -0400
Subject: Re: 2.4.22-rc2 unresolved symbols in drm/sis.o when CONFIG_AGP=m
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Filip Sneppe <filip.sneppe@yucom.be>
Cc: faith@valinux.com, DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1061134780.670.150.camel@exile>
References: <1061134780.670.150.camel@exile>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061135303.21878.42.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 17 Aug 2003 16:48:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-17 at 16:39, Filip Sneppe wrote:
> Hi,
> 
> I get this on Debian Sarge at the end of a "make modules_install":
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.22-rc2/kernel/drivers/char/drm/sis.o
> depmod:         sis_malloc_Ra3329ed5
> depmod:         sis_free_Rced25333

SIS DRM requires SIS frame buffer, known problem

