Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265963AbUFTWRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265963AbUFTWRf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 18:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265965AbUFTWRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 18:17:35 -0400
Received: from [213.146.154.40] ([213.146.154.40]:20957 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265963AbUFTWRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 18:17:32 -0400
Date: Sun, 20 Jun 2004 23:17:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: chas@cmf.nrl.navy.mil, linux-atm-general@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix typos in ATM_FORE200E_USE_TASKLET help text
Message-ID: <20040620221713.GA9238@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>, chas@cmf.nrl.navy.mil,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20040620220752.GB27822@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040620220752.GB27822@fs.tum.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 12:07:52AM +0200, Adrian Bunk wrote:
> The trivial patch below fixes two typos in the ATM_FORE200E_USE_TASKLET 
> help text.
> 
> Please apply
> Adrian
> 
> --- linux-2.6.7/drivers/atm/Kconfig.old	2004-06-21 00:03:30.000000000 +0200
> +++ linux-2.6.7/drivers/atm/Kconfig	2004-06-21 00:07:29.000000000 +0200
> @@ -391,8 +391,8 @@
>  	default n
>  	help
>  	  This defers work to be done by the interrupt handler to a
> -	  tasklet instead of hanlding everything at interrupt time.  This
> -	  may improve the responsive of the host.
> +	  tasklet instead of handling everything at interrupt time.  This
> +	  may improve the responsiveness of the host.

Btw, this isn't exactly something that should be a config option.  Either
it's an improvement and should always be on or not.  But the arm drivers
seem to like gazillions of options for just about everything..

