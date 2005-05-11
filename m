Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVEKIUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVEKIUI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 04:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVEKIUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 04:20:08 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51461 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261921AbVEKIUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 04:20:03 -0400
Date: Wed, 11 May 2005 10:19:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: gaa <gaa@mail.nnov.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dosemu crashes under 2.6.12-rc4
Message-ID: <20050511081955.GG3590@stusta.de>
References: <20050511060223.7B62F146C83@just.ip-center.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050511060223.7B62F146C83@just.ip-center.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 10:03:40AM +0400, gaa wrote:

> "dosemu" does not work under kernel 2.6.12-rc4(but works under 2.6.11.7).
> Next lines are stdout of crashed dosemu process:
> 
> Linux DOS emulator 1.2.1.0 $Date: 2004/03/06$
>...

That's a known problem of the dosemu in Debian unstable/sarge together 
with recent kernels.

Workaround:
  echo 0 > /proc/sys/kernel/randomize_va_space

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

