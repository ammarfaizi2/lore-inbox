Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWEQKPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWEQKPr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 06:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWEQKPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 06:15:46 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62992 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750855AbWEQKPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 06:15:46 -0400
Date: Wed, 17 May 2006 12:15:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swapper_space export
Message-ID: <20060517101544.GW10077@stusta.de>
References: <20060516232443.GA10762@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516232443.GA10762@filer.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 07:24:43PM -0400, Josef Sipek wrote:
> I was trying to compile the Unionfs[1] to get it up to sync it up with
> the kernel developments from the past few months. Anyway, long story
> short...swapper_space (defined in mm/swap_state.c) is not exported
> anymore (git commit: 4936967374c1ad0eb3b734f24875e2484c3786cc). This
> apparently is not an issue for most modules. Troubles arise when the
> modules include mm.h or any of its relatives.
> 
> One simply gets a linker error about swapper_space not being defined.
> The problem is that it is used in mm.h.
> 
> I included a reverse patch to export the symbol again.

Can we discuss this patch when Unionfs gets submitted for inclusion into 
the kernel?

It's in fact a good thing if you and other people regularly notice that 
external modules do not longer work here or there since it creates 
pressure towards getting external modules submitted for inclusion into 
the kernel.

> Josef "Jeff" Sipek.
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

