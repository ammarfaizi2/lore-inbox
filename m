Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbUKRX3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUKRX3L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbUKRX1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 18:27:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55052 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262997AbUKRXZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 18:25:34 -0500
Date: Fri, 19 Nov 2004 00:25:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Nicolas Pitre <nico@cam.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org
Subject: Re: [patch] 2.6.10-rc2-mm2: MTD_XIP dependencies
Message-ID: <20041118232527.GI4943@stusta.de>
References: <20041118021538.5764d58c.akpm@osdl.org> <20041118154110.GE4943@stusta.de> <1100793112.8191.7315.camel@hades.cambridge.redhat.com> <Pine.LNX.4.61.0411181132440.12260@xanadu.home> <20041118213232.GG4943@stusta.de> <Pine.LNX.4.61.0411181727010.12260@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411181727010.12260@xanadu.home>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 05:31:32PM -0500, Nicolas Pitre wrote:
>...
> Can we make it conditional on CONFIG_XIP_KERNEL instead?
> It would be less messy IMHO.

I copied the dependency from the #ifdef before the #error.

The #error should either go or be the same than the Kconfig dependency.

> Nicolas

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

