Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUCKUep (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUCKUbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:31:37 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39627 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261712AbUCKUYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:24:01 -0500
Date: Thu, 11 Mar 2004 21:23:53 +0100
From: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: 2.6.4-mm1: modular quota needs unknown symbol
Message-ID: <20040311202352.GD14833@fs.tum.de>
References: <20040310233140.3ce99610.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310233140.3ce99610.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 11:31:40PM -0800, Andrew Morton wrote:
>...
> ext3-journalled-quotas-2.patch
>   ext3: journalled quota
>...

This patch broke modular quota:
  WARNING: /lib/modules/2.6.4-mm1/kernel/fs/quota_v2.ko needs unknown 
  symbol mark_info_dirty


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

