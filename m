Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbUD1Tez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUD1Tez (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUD1TeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:34:04 -0400
Received: from gonzo.one-2-one.net ([217.115.142.69]:15499 "EHLO
	gonzo.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S265014AbUD1Rlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 13:41:40 -0400
Envelope-to: linux-kernel@vger.kernel.org
Date: Wed, 28 Apr 2004 19:41:26 +0200
From: stefan.eletzhofer@eletztrick.de
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add RTC 8564 I2C chip support
Message-ID: <20040428174125.GB23534@gonzo.local>
Reply-To: stefan.eletzhofer@eletztrick.de
Mail-Followup-To: stefan.eletzhofer@eletztrick.de,
	LKML <linux-kernel@vger.kernel.org>
References: <1083164773.408fc86533f29@imp.gcu.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083164773.408fc86533f29@imp.gcu.info>
User-Agent: Mutt/1.3.27i
Organization: Eletztrick Computing
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 05:06:13PM +0200, Jean Delvare wrote:
> Hi Stefan,
> 
> Just a quick comment about your patch: it's a common habit of the
> sensors folks to prefix i2c bus drivers with i2c-, but not chip
> drivers. So I would suggest that you name your driver rtc8564, not
> i2c-rtc8564.

Ok, I'll fix that.

> 
> Also, please keep the lines in drivers/i2c/chips/Makefile in the
> alphabetic order.

... and that one

> And your header states
> "linux/drivers/system3/rtc8564.c" while the driver will be in a
> different location. Please correct.

And that too.

> I've not read your code otherwise, I don't know anything about RTCs.
> 
> Thanks.
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Eletztrick Computing - Customized Linux Development
Stefan Eletzhofer, Marktstrasse 43, DE-88214 Ravensburg
http://www.eletztrick.de
