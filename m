Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbVCPRcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVCPRcR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 12:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVCPRcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 12:32:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4104 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262704AbVCPRbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 12:31:51 -0500
Date: Wed, 16 Mar 2005 18:31:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm4
Message-ID: <20050316173147.GC3153@stusta.de>
References: <20050316040654.62881834.akpm@osdl.org> <20050316142248.GI29333@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316142248.GI29333@ens-lyon.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 03:22:49PM +0100, Benoit Boissinot wrote:

> It doesn't compile with gcc-4.0.
> 
> drivers/video/console/fbcon.c:133: error: static declaration of ???fb_con???
> follows non-static declaration
> drivers/video/console/fbcon.h:166: error: previous declaration of
> ???fb_con??? was here
> 
> Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

Acked-by: Adrian Bunk <bunk@stusta.de>

Thanks for the patch.

That was my fault:
gcc 3.4 doesn't even warn about this, and I missed it while grep'ing.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

