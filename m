Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbUKXAPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbUKXAPg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 19:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUKXAPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 19:15:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23308 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261390AbUKXANd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 19:13:33 -0500
Date: Wed, 24 Nov 2004 01:13:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC/v2][2/21] Add core InfiniBand support
Message-ID: <20041124001328.GE2927@stusta.de>
References: <20041123814.rXLIXw020elfd6Da@topspin.com> <20041123814.m1N7Tf2QmSCq9s5q@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123814.m1N7Tf2QmSCq9s5q@topspin.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 08:14:19AM -0800, Roland Dreier wrote:
> Add implementation of core InfiniBand support.  This can be thought of
> as a midlayer that provides an abstraction between low-level hardware
> drivers and upper level protocols (such as IP-over-InfiniBand).
>
> Signed-off-by: Roland Dreier <roland@topspin.com>
>
>
> --- /dev/null 1970-01-01 00:00:00.000000000 +0000
> +++ linux-bk/drivers/infiniband/Kconfig       2004-11-23 
08:10:16.399144313 -$
> @@ -0,0 +1,11 @@
> +menu "InfiniBand support"
> +
> +config INFINIBAND
> +     tristate "InfiniBand support"
> +     default n
>...

This "default n" has no effect.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

