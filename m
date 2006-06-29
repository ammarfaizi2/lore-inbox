Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWF2Qu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWF2Qu0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 12:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWF2Qu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 12:50:26 -0400
Received: from [141.84.69.5] ([141.84.69.5]:9231 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S1750959AbWF2QuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 12:50:25 -0400
Date: Thu, 29 Jun 2006 18:49:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: mitr@volny.cz, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/input/misc/wistron_btns.c: section fixes
Message-ID: <20060629164944.GE19712@stusta.de>
References: <20060626103509.GQ23314@stusta.de> <200606260750.32863.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606260750.32863.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 07:50:31AM -0400, Dmitry Torokhov wrote:
> On Monday 26 June 2006 06:35, Adrian Bunk wrote:
> > This patch contains the following fixes:
> > - it doesn't make sense to mark a variable on the stack as __initdata
> > - struct dmi_ids is using the __init dmi_matched()
> 
> Since when did static variables become allocated on stack?

Only when I miss the static...

> Dmitry

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

