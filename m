Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271738AbTGXVRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 17:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271739AbTGXVRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 17:17:12 -0400
Received: from roadie.xs4all.nl ([80.126.43.246]:44672 "EHLO www.spearhead.org")
	by vger.kernel.org with ESMTP id S271738AbTGXVRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 17:17:11 -0400
Date: Thu, 24 Jul 2003 23:35:53 +0200
From: koraq@xs4all.nl
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.22-pre7] speedtouch.o unresolved symbols
Message-ID: <20030724213553.GA8866@spearhead>
References: <20030724202048.GA16411@spearhead>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030724202048.GA16411@spearhead>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 10:20:48PM +0200, koraq@xs4all.nl wrote:
> After compiling kernel 2.4.22-pre7 the make modules_install failed with the following errors
> 
> cd /lib/modules/2.4.22-pre7; \
> mkdir -p pcmcia; \
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.22-pre7; fi
> depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre7/kernel/drivers/usb/speedtch.o
> depmod:         shutdown_atm_dev_R0b9b1467
> depmod:         atm_charge_Rf874f17b
> depmod:         atm_dev_register_Rc23701a4
> make: *** [_modinst_post] Error 1
> 
>

I saw 2-4.22-pre8 was just uploaded after my previous message, I tested it and got the same errors.

Regards,
Mark de Wever 
