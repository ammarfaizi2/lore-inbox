Return-Path: <linux-kernel-owner+w=401wt.eu-S1161269AbWLPRWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161269AbWLPRWP (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 12:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161272AbWLPRWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 12:22:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3813 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1161269AbWLPRWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 12:22:14 -0500
Date: Sat, 16 Dec 2006 18:22:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] more ftape removal
Message-ID: <20061216172213.GA10316@stusta.de>
References: <20061213130515.GB3851@stusta.de> <45842095.5040107@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45842095.5040107@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 11:36:37AM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >This patch removes some more ftape code.
> >
> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> this affects userspace exported headers, so I'm not sure we want to kill 
> that.  even if the interface is gone is current kernels, people might 
> want to build binaries against these headers that work on older kernels.

Can you be more specific?

Building ftape-utils has already been broken by you removing four 
userspace exported ftape headers in your ftape removal patch.

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

