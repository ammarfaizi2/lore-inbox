Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030502AbVKWXi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbVKWXi4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbVKWXiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:38:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14084 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030502AbVKWXiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:38:54 -0500
Date: Thu, 24 Nov 2005 00:38:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20051123233853.GL3963@stusta.de>
References: <20051123223438.GY3963@stusta.de> <20051123150905.6c7a952d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123150905.6c7a952d.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 03:09:05PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > Currently, using an undeclared function gives a compile warning, but it 
> > can lead to a nasty runtime error if the prototype of the function is 
> > different from what gcc guessed.
> > 
> > With -Werror-implicit-function-declaration, we are getting an immediate 
> > compile error instead.
> 
> Where "we" == "me".  This patch means I get to fix all the errors which I
> encounter.  No fair.  This should be the last patch, not the first.

Is it my fault that you applied neither Al Viro's patches to remove the 
usages of the ISA legacy functions nor my patch to mark 
virt_to_bus/bus_to_virt as __deprecated on i386?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

