Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030458AbVIAWUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbVIAWUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbVIAWUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:20:04 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1295 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030455AbVIAWUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:20:01 -0400
Date: Fri, 2 Sep 2005 00:19:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-kernel@vger.kernel.org, "Antonino A. Daplas" <adaplas@pol.net>
Subject: 2.6.13-mm1: broken drivers/video/sis/Makefile
Message-ID: <20050901221959.GB3657@stusta.de>
References: <20050901035542.1c621af6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901035542.1c621af6.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 03:55:42AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.13-rc6-mm2:
>...
> +sisfb-update.patch
>...
>  fbdev updates
>...

This patch accidentally replaces drivers/video/sis/Makefile with a 
toplevel Makefile.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

