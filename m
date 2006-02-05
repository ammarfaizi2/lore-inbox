Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751707AbWBELJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbWBELJm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 06:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbWBELJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 06:09:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15045 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751705AbWBELJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 06:09:42 -0500
Subject: Re: [v4l-dvb-maintainer] [RFC: 2.6 patch] DVB: remove the
	at76c651/tda80xx frontends
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andreas Oberritter <obi@linuxtv.org>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060128165726.GL3777@stusta.de>
References: <20060128165726.GL3777@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 05 Feb 2006 09:09:29 -0200
Message-Id: <1139137769.27465.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sáb, 2006-01-28 às 17:57 +0100, Adrian Bunk escreveu:
> The at76c651 and tda80xx frontends are currently completely unused, IOW 
> their only effect is making the kernel larger for people accitentially 
> enabling them.
> 
> The current in-kernel drivers differ from the drivers at cvs.tuxbox.org, 
> and re-adding them when parts of the dbox2 project get merged should be 
> trivial.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
	Acked-by: Mauro Carvalho Chehab <mchehab@infradead.org>

I'll apply at v4l-dvb.git and ask Linus to pull from it.

> 
> ---
> 
>  drivers/media/dvb/frontends/Kconfig    |   12 
>  drivers/media/dvb/frontends/Makefile   |    2 
>  drivers/media/dvb/frontends/at76c651.c |  450 ---------------
>  drivers/media/dvb/frontends/at76c651.h |   47 -
>  drivers/media/dvb/frontends/tda80xx.c  |  734 -------------------------

Cheers, 
Mauro.

