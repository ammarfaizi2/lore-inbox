Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbVHaMbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVHaMbf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 08:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVHaMbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 08:31:35 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:58541 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932416AbVHaMbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 08:31:34 -0400
Date: Wed, 31 Aug 2005 14:31:13 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Message-ID: <20050831123113.GB17473@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <20050828024750.GF9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050828024750.GF9322@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.10i
X-SA-Exim-Connect-IP: 84.189.244.102
Subject: Re: [PATCH] missing include in tda80xx
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2005 Al Viro wrote:
> Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

I added this patch to linuxtv.org CVS.

Thanks,
Johannes

> diff -urN RC13-rc7-base/drivers/media/dvb/frontends/tda80xx.c current/drivers/media/dvb/frontends/tda80xx.c
> --- RC13-rc7-base/drivers/media/dvb/frontends/tda80xx.c	2005-08-24 01:56:38.000000000 -0400
> +++ current/drivers/media/dvb/frontends/tda80xx.c	2005-08-27 22:36:10.000000000 -0400
> @@ -30,6 +30,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <asm/irq.h>
>  #include <asm/div64.h>
>  
>  #include "dvb_frontend.h"
