Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWCUWyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWCUWyd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbWCUWyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:54:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56842 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964881AbWCUWyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:54:32 -0500
Date: Tue, 21 Mar 2006 23:54:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc6-mm2: Why is CONFIG_MIGRATION available for everyone?
Message-ID: <20060321225430.GJ3890@stusta.de>
References: <20060318044056.350a2931.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318044056.350a2931.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 04:40:56AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc6-mm1:
>...
> +page-migration-reorg.patch
>...
>  Reorganise the page migration code
>...

The patch description includes:

5. Make it possible to configure NUMA systems without page migration
   and non-NUMA systems with page migration.


I don't see the point in making this option visible for the majority of 
users on non-NUMA systems who will never need it.

When is it required on non-NUMA systems?
Memory hotplug?
Can we express this explicitely?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

