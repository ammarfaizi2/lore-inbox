Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVAYKi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVAYKi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 05:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVAYKi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 05:38:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26642 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261881AbVAYKiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 05:38:25 -0500
Date: Tue, 25 Jan 2005 11:38:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: v4l-saa7134-module compile error
Message-ID: <20050125103821.GN3515@stusta.de>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124111713.GF3515@stusta.de> <20050124135716.GA23702@bytesex> <20050124174559.GJ3515@stusta.de> <20050125101508.GB1060@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125101508.GB1060@bytesex>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 11:15:09AM +0100, Gerd Knorr wrote:
> > > The patch below should fix this.
> > 
> > Not completely:
> 
> >   CC      drivers/media/video/saa7134/saa7134-core.o
> > drivers/media/video/saa7134/saa7134-core.c: In function `saa7134_initdev':
> > drivers/media/video/saa7134/saa7134-core.c:997: error: `need_empress' undeclared (first use in this function)
> 
> New version, this time using a #define, which should kill the reference
> to need_* as well ...

I can confirm that this patch fixes the compilation.

>   Gerd
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

