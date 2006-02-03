Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946014AbWBCWc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946014AbWBCWc1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945909AbWBCWc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:32:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48654 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1946014AbWBCWc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:32:26 -0500
Date: Fri, 3 Feb 2006 23:32:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       hch@infradead.org
Subject: Re: unexport lookup_hash
Message-ID: <20060203223224.GT4408@stusta.de>
References: <20060203212259.GA11066@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203212259.GA11066@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 04:22:59PM -0500, Dave Jones wrote:
> I just stumbled across this whilst checking for planned feature removal,
> and missed any discussion why this didn't happen, so I assume Christoph forgot.
>...

I did beat you by a few minutes.  :-)

This patch wasn't possible before the latest -mm since 
net/sunrpc/rpc_pipe.c still used it.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

