Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVBXLOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVBXLOG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 06:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVBXLLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 06:11:33 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44305 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262224AbVBXLLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 06:11:11 -0500
Date: Thu, 24 Feb 2005 12:11:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, roland@topspin.com, mshefty@ichips.intel.com,
       halr@voltaire.com, openib-general@openib.org, greg@kroah.com
Subject: 2.6.11-rc4-mm1: infiniband/core/user_mad.c warning
Message-ID: <20050224111110.GF8651@stusta.de>
References: <20050223014233.6710fd73.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223014233.6710fd73.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 01:42:33AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.11-rc3-mm1:
>...
>  bk-driver-core-infiniband-build-fix.patch
>...

This gives me the following compile error:

<--  snip  -->

...
  CC      drivers/infiniband/core/user_mad.o
drivers/infiniband/core/user_mad.c:587: warning: 'class_device_attr_dev' defined but not used
...

<--  snip  -->


Reverting this patch fixes the warning (but I don't know about the 
underlying issues).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

