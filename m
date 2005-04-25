Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVDYXDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVDYXDC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 19:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVDYXDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 19:03:02 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51215 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261276AbVDYXC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 19:02:59 -0400
Date: Tue, 26 Apr 2005 01:02:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport __print_symbol
Message-ID: <20050425230254.GH4099@stusta.de>
References: <20050415151022.GD5456@stusta.de> <20050423163518.2dac351c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423163518.2dac351c.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2005 at 04:35:18PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > I didn't find any possible modular usage in the kernel.
> > 
> 
> Making print_symbol() available to modules during their development might
> aid that development.  Presumably, such debug code would not appear in the
> mainline tree.
> 
> IOW: people might want to use print_symbol() during private development, so
> we should continue to export it to modules.

If you need it during private development, you can always re-add it in 
your private tree.

And the possibility of such debug code accidentially getting into 
mainline drops to zero if the EXPORT_SYMBOL isn't there.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

