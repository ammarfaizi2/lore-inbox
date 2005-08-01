Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVHAIqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVHAIqn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 04:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVHAIqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 04:46:43 -0400
Received: from gw.alcove.fr ([81.80.245.157]:36272 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S261351AbVHAIqm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 04:46:42 -0400
Subject: Re: [PATCH] sonypi, kernel 2.6.12.3
From: Stelian Pop <stelian@popies.net>
To: Erik Waling <erikw@acc.umu.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050801005900.GB20370@shaka.acc.umu.se>
References: <20050801005900.GB20370@shaka.acc.umu.se>
Content-Type: text/plain; charset=utf-8
Date: Mon, 01 Aug 2005 10:45:03 +0200
Message-Id: <1122885904.4509.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 01 août 2005 à 02:59 +0200, Erik Waling a écrit :
> Newer Sony VAIO models (VGN-S480, VGN-S460, VGN-S3XP etc) use a new method to
> initialize the SPIC device. The new way to initialize (and disable) the device
> comes directly from the AML code in the _CRS, _SRS and _DIS methods from the
> DSDT table. This patch against 2.6.12.3 adds support for the new models.
> 
> -- Erik Waling  <erikw@acc.umu.se>
> 
> 
> 
> --- linux-2.6.12.3/drivers/char/sonypi.c	2005-07-15 16:18:57.000000000 -0500
> +++ linux/drivers/char/sonypi.c	2005-07-31 16:55:41.000000000 -0500

[...]

> +	- some models with the nvidia card (geforce go 6200 tc) uses a 
> +	  different way to adjust the backlighting of the screen. There
> +	  is a userspace utility to adjust the brightness on those models.

Don't be shy, put the URL pointing to your SmartDimmer here :)

Otherwise you have my:
	Signed-off-by: Stelian Pop <stelian@popies.net>

Thanks Erik.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

