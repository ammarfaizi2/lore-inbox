Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbUKKXlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbUKKXlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 18:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbUKKXfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 18:35:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53003 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262542AbUKKX3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 18:29:31 -0500
Date: Fri, 12 Nov 2004 00:28:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc1-mm5: reiser4: print_clog in debug.c useless?
Message-ID: <20041111232859.GC2310@stusta.de>
References: <20041111012333.1b529478.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111012333.1b529478.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

print_clog in fs/reiser4/debug.c works with values that get assigned by 
clog_op - but clog_op has exactly zero callers.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

