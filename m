Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWIMQRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWIMQRp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWIMQRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:17:45 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751006AbWIMQRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:17:43 -0400
Date: Wed, 13 Sep 2006 18:17:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/6] Implement a general log2 facility in the kernel
Message-ID: <20060913161734.GE3564@stusta.de>
References: <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com> <20060913130300.32022.69743.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060913130300.32022.69743.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 02:03:00PM +0100, David Howells wrote:
> From: David Howells <dhowells@redhat.com>
> 
> This facility provides three entry points:
> 
> 	log2()		Log base 2 of u32
>...

Considering that several arch maintainers have vetoed my patch to revert 
the -ffreestanding removal Andi sneaked in with his usual trick to hide 
generic patches as "x86_64 patch", such a usage of a libc function name 
with a signature different from the one defined in ISO/IEC 9899:1999 is 
a namespace violation that mustn't happen.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

