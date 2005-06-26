Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVFZWqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVFZWqj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 18:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVFZWqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 18:46:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20241 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261626AbVFZWiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 18:38:24 -0400
Date: Mon, 27 Jun 2005 00:38:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/hamradio/: cleanups
Message-ID: <20050626223820.GL3629@stusta.de>
References: <20050502014637.GQ3592@stusta.de> <42BF2BA9.8060502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BF2BA9.8060502@pobox.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 06:26:49PM -0400, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >This patch contains the following cleanups:
> >- dmascc.c: remove the unused global function dmascc_setup
> 
> Better to use it, then remove it.

Can you give me a hint how it should be used?

Why doesn't dmascc_init together with the MODULE_PARM(io,...) work in 
the non-modular case?

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

