Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316823AbSE3Sty>; Thu, 30 May 2002 14:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316824AbSE3Stx>; Thu, 30 May 2002 14:49:53 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:13319 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316823AbSE3Stx>;
	Thu, 30 May 2002 14:49:53 -0400
Date: Thu, 30 May 2002 11:48:18 -0700
From: Greg KH <greg@kroah.com>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.4] ATM driver for the Alcatel SpeedTouch USB DSL modem
Message-ID: <20020530184817.GB28893@kroah.com>
In-Reply-To: <1022782402.1920.130.camel@ldb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 02 May 2002 17:19:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 08:13:22PM +0200, Luca Barbieri wrote:
> Depends:
> - [PATCH] [2.4, 2.5] printk helper functions
> - [PATCH] [2.4] Waitable counter structure
> - [PATCH] [2.4] ATM SAR support, based on SARlib

Because of these dependencies (and the fact that the maintainer doesn't
want it added yet) I will not apply this patch.

> Recommends:
> - [PATCH] [2.4] [2.5] Fix PPPoATM crash on disconnection
> (tasklet_disable; kfree(tasklet)) <merged in 2.4.19-pre9>
> 
> Look at Configure.help for the description.
> 
> This driver is based on the 1.5 driver written and maintained by Johan
> Verrept.
> I sent an older version of this set of patches to him on 16/may/2002. On
> 20/may/2002 he replied saying that he would look at the patch, but he
> didn't send me any further messages.
> So, since the identity of the maintainer doesn't matter when deciding
> whether to apply a patch or not, I'm sending this to linux-kernel
> without waiting for an answer from the 1.5 maintainer in order to save
> time.

Sending this to linux-usb-devel might be a better place, instead of
bothering linux-kernel.

thanks,

greg k-h
