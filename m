Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269225AbUJKUSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269225AbUJKUSn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 16:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269237AbUJKUSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 16:18:43 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61199 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269225AbUJKUSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 16:18:41 -0400
Date: Mon, 11 Oct 2004 22:18:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Brice.Goglin@ens-lyon.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1
Message-ID: <20041011201810.GD1892@stusta.de>
References: <20041011032502.299dc88d.akpm@osdl.org> <416AD644.8010302@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416AD644.8010302@ens-lyon.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 08:51:48PM +0200, Brice Goglin wrote:

> Hi Andrew,
> 
> The old Gamma DRM driver seems broken.
> (I removed the inter_module_ "deprecated" warnings)

That's why it's marked BROKEN in the Kconfig file (you can't even select 
it unless you did previously choose to disable
  "Select only drivers expected to compile cleanly"
).

> Regards,
> Brice Goglin

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

