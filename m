Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVFGU7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVFGU7M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 16:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVFGU7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 16:59:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12817 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261875AbVFGU7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 16:59:08 -0400
Date: Tue, 7 Jun 2005 22:59:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Matt Porter <mporter@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc6-mm1: rio confusion
Message-ID: <20050607205906.GA7962@stusta.de>
References: <20050607042931.23f8f8e0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607042931.23f8f8e0.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 04:29:31AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.12-rc5-mm2:
>...
> +rapidio-support-core-base.patch
> +rapidio-support-core-includes.patch
> +rapidio-support-core-enum.patch
> +rapidio-support-ppc32.patch
> +rapidio-support-net-driver.patch
> 
>  RapidIO driver
>...

That we do now have both drivers/rio/ and drivers/char/rio/ and that 
they are for completely different things is confusing.

What about drivers/rapidio/ ?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

