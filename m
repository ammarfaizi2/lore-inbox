Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVCDDax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVCDDax (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 22:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVCDDZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 22:25:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:44162 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262765AbVCDCqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 21:46:19 -0500
Date: Thu, 3 Mar 2005 18:45:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 vs DVB cx88 stuffs
Message-Id: <20050303184547.33669e61.akpm@osdl.org>
In-Reply-To: <200503032119.04675.gene.heskett@verizon.net>
References: <200503032119.04675.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:
>
>  I've a new pcHDTV-3000 card, and I thought maybe it would
>  be a good idea to build the cx88 stuff in the DVB section
>  of a make xconfig.
> 
>  It doesn't build, spitting out this bailout:
> 
>    CC [M]  drivers/media/video/cx88/cx88-cards.o
>  drivers/media/video/cx88/cx88-cards.c: In function `hauppauge_eeprom_dvb':
>  drivers/media/video/cx88/cx88-cards.c:694: error: `PLLTYPE_DTT7595' undeclared (first use in this function)
>  drivers/media/video/cx88/cx88-cards.c:694: error: (Each undeclared identifier is reported only once
>  drivers/media/video/cx88/cx88-cards.c:694: error: for each function it appears in.)
>  drivers/media/video/cx88/cx88-cards.c:698: error: `PLLTYPE_DTT7592' undeclared (first use in this function)
>  drivers/media/video/cx88/cx88-cards.c: In function `cx88_card_setup':
>  drivers/media/video/cx88/cx88-cards.c:856: error: `PLLTYPE_DTT7579' undeclared (first use in this function)
>  make[4]: *** [drivers/media/video/cx88/cx88-cards.o] Error 1
>  make[3]: *** [drivers/media/video/cx88] Error 2
>  make[2]: *** [drivers/media/video] Error 2

.config, please.
