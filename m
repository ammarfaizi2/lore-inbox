Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbUKUQBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbUKUQBn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 11:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUKUP73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:59:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7694 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261742AbUKUP6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 10:58:12 -0500
Date: Sun, 21 Nov 2004 16:58:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Antonino Daplas <adaplas@pol.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] drivers/video/: misc cleanups
Message-ID: <20041121155811.GA2961@stusta.de>
References: <20041121153702.GB2829@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121153702.GB2829@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 04:37:02PM +0100, Adrian Bunk wrote:

> The patch below does the following cleanups under drivers/video/ :
> - make some needlessly global code static
> - the following was needlessly EXPORT_SYMBOL'ed:
>   - fbcon.c: fb_con
>   - mdacon.c: fb_blank
>   - fbmon.c: get_EDID_from_firmware (completely unused)
>...

I forgot one thing:

Please review my global_mode_option removal in modedb.c .

It was always NULL and I'd say the only usage was wrong (although it 
had no practical effect).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

