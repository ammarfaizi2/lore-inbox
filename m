Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945994AbWANDtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945994AbWANDtT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 22:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945995AbWANDtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 22:49:18 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:17879 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1945993AbWANDtQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 22:49:16 -0500
Date: Fri, 13 Jan 2006 19:49:03 -0800
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jes Sorensen <jes@trained-monkey.org>, torvalds@osdl.org, akpm@osdl.org,
       tony.luck@intel.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       R.E.Wolff@BitWizard.nl, paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: Re: [2.6 patch] remove unused tmp_buf_sem's
Message-ID: <20060114034903.GA23074@suse.de>
References: <17348.61824.49889.569928@jaguar.mkp.net> <20060114020816.GW29663@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114020816.GW29663@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 03:08:16AM +0100, Adrian Bunk wrote:
> <--  snip  -->
> 
> 
> tmp_buf_sem sems to be a common name for something completely unused...
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  arch/ia64/hp/sim/simserial.c  |    1 -
>  arch/ppc/4xx_io/serial_sicc.c |    1 -
>  drivers/char/amiserial.c      |    1 -
>  drivers/char/esp.c            |    1 -
>  drivers/char/generic_serial.c |    1 -
>  drivers/char/riscom8.c        |    1 -
>  drivers/char/serial167.c      |    1 -
>  drivers/char/specialix.c      |    3 ---
>  drivers/char/synclink.c       |    1 -
>  drivers/sbus/char/aurora.c    |    1 -
>  drivers/serial/68328serial.c  |    1 -
>  drivers/usb/serial/pl2303.c   |    2 --
>  12 files changed, 15 deletions(-)

usb portion is:
  Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

