Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbULNAG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbULNAG1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 19:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbULNAG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 19:06:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1038 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261352AbULNAGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 19:06:23 -0500
Date: Tue, 14 Dec 2004 01:06:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] some XFS cleanups (fwd)
Message-ID: <20041214000621.GO23151@stusta.de>
References: <20041207193533.GG7250@stusta.de> <20041208050348.GI1611@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041208050348.GI1611@frodo>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 04:03:48PM +1100, Nathan Scott wrote:
>...
> > The patch below makes the following cleanups in the XFS code:
> > - remove the unused global function vfs_dmapiops
> > - remove some unused #define's
> 
> These first changes aren't really useful; they make the DMAPI
> code more difficult to integrate and manage in our trees, for
> not-enough gain.
>...

OK, then the #define's have to stay.

Would it be OK to make vfs_dmapiops #ifdef on the DMAPI code?

> Nathan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

