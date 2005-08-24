Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVHXLKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVHXLKh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 07:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVHXLKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 07:10:37 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25617 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750809AbVHXLKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 07:10:37 -0400
Date: Wed, 24 Aug 2005 13:10:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "H. J. Lu" <hjl@lucon.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc6-mm2 doesn't compile on xtensa
Message-ID: <20050824111035.GL5603@stusta.de>
References: <20050822213021.1beda4d5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822213021.1beda4d5.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

auxiliary-vector-cleanups.patch broke compilation on the xtensa 
architecture because it doesn't add an asm/auxvec.h on this 
architecture.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

