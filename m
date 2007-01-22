Return-Path: <linux-kernel-owner+w=401wt.eu-S1751454AbXAVPiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbXAVPiK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbXAVPiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:38:10 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2737 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751453AbXAVPiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:38:08 -0500
Date: Mon, 22 Jan 2007 16:38:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SCSI seagate.c: remove SEAGATE_USE_ASM
Message-ID: <20070122153813.GT9093@stusta.de>
References: <20070121191300.GL9093@stusta.de> <20070122151841.6d0473e4@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070122151841.6d0473e4@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2007 at 03:18:41PM +0000, Alan wrote:
> On Sun, 21 Jan 2007 20:13:00 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > Using assembler code for performance in drivers might have been a good 
> > idea 15 years ago when this code was written, but with today's compilers 
> > that's unlikely to be an advantage.
> > 
> > Besides this, it also hurts the readability.
> > 
> > Simply use the C code that was already there as an alternative.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 					"stosb\n\t"
> 
> NAK
> 
> The C codepaths are essentially untested on this driver.

Has any part of this driver ever be tested with kernel 2.6?
Or compiled with gcc 4?

> Alan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

