Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWFYTcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWFYTcX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 15:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWFYTcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 15:32:23 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24593 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751391AbWFYTcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 15:32:23 -0400
Date: Sun, 25 Jun 2006 21:32:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, mike.miller@hp.com, iss_storagedev@hp.com,
       hbabu@us.ibm.com, fastboot@lists.osdl.org
Subject: 2.6.17-mm2: BLK_CPQ_CISS_DA=m error
Message-ID: <20060625193220.GE23314@stusta.de>
References: <20060624061914.202fbfb5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624061914.202fbfb5.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 06:19:14AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm1:
>...
> +kdump-cciss-driver-initialization-issue-fix.patch
> 
>  Unpleasant kdump patches.
>...

This patch breaks CONFIG_BLK_CPQ_CISS_DA=m:

<--  snip  -->

...
if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map  2.6.17-mm2; fi
WARNING: /lib/modules/2.6.17-mm2/kernel/drivers/block/cciss.ko needs unknown symbol crash_boot

<--  snip  -->
 
cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

