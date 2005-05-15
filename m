Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbVEOMMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbVEOMMe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 08:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbVEOMMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 08:12:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53520 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262819AbVEOMM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 08:12:27 -0400
Date: Sun, 15 May 2005 14:12:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] make MII no longer user visible
Message-ID: <20050515121222.GR16549@stusta.de>
References: <20050513035257.GC3603@stusta.de> <4284DD16.8090405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4284DD16.8090405@pobox.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 01:00:06PM -0400, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >MII is a classical example of a helper option no user should ever see.
> 
> Incorrect.
> 
> It's the classic example of an option that distributors may want to 
> build as a module, even if no shipped modules need it, to enable net 
> driver development and use in their kernel.

Every distibutor will have more than one net driver select'ing MII 
enabled.

And if you are doing net driver development, you can always enable it in 
your kernel.

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

