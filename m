Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVLKR4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVLKR4O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 12:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVLKR4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 12:56:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64523 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750760AbVLKR4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 12:56:13 -0500
Date: Sun, 11 Dec 2005 18:56:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Ben Gardner <gardner.ben@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc5-mm2: two cs5535 modules
Message-ID: <20051211175612.GL23349@stusta.de>
References: <20051211041308.7bb19454.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051211041308.7bb19454.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 04:13:08AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.15-rc5-mm1:
>...
> +i386-cs5535-chip-support-cpu.patch
>...
>  Updated.   Still need work.
>...

This patch adds a module cs5535 under arch/i386/kernel/, but there's 
already a module of the same name present under drivers/ide/pci/.

This is a problem if both are modular since two modules of the same name 
are not possible.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

