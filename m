Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVA2RXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVA2RXV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 12:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVA2RXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 12:23:21 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:12808 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261517AbVA2RWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 12:22:43 -0500
Date: Sat, 29 Jan 2005 18:22:55 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] mark the mcd cdrom driver as BROKEN
Message-Id: <20050129182255.37b8fe2c.khali@linux-fr.org>
In-Reply-To: <3s4gX-P6-45@gated-at.bofh.it>
References: <3s4gX-P6-45@gated-at.bofh.it>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> The mcd driver drives only very old hardware (some single and double 
> speed CD drives that were connected either via the soundcard or a 
> special ISA card), and the mcdx driver offers more functionality for
> the  same hardware.
> 
> My plan is to mark MCD as broken in 2.6.11 and if noone complains 
> completely remove this driver some time later.
> (...)
> -	depends on CD_NO_IDESCSI
> +	depends on CD_NO_IDESCSI && BROKEN

Shouldn't we introduce a DEPRECATED option for use in cases like this
one?

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
