Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162491AbWLBV1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162491AbWLBV1S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 16:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162494AbWLBV1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 16:27:18 -0500
Received: from isilmar.linta.de ([213.239.214.66]:16784 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1162491AbWLBV1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 16:27:17 -0500
Date: Sat, 2 Dec 2006 23:11:44 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/pcmcia/m32r_cfc.c: fix compilation
Message-ID: <20061202211144.GA12613@dominikbrodowski.de>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20061202175505.GT11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061202175505.GT11084@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 06:55:06PM +0100, Adrian Bunk wrote:
> More fallout of the post 2.6.19-rc1 IRQ changes...
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/pcmcia/m32r_cfc.o
> In function 'pcc_interrupt_wrapper':
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc6-mm2/drivers/pcmcia/m32r_cfc.c:401: 
> error: too many arguments to function 'pcc_interrupt'
> make[3]: *** [drivers/pcmcia/m32r_cfc.o] Error 1
> 
> <--  snip  -->
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

	Dominik
