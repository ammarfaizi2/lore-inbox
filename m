Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSJNQof>; Mon, 14 Oct 2002 12:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262025AbSJNQof>; Mon, 14 Oct 2002 12:44:35 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:56581 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262023AbSJNQoe>;
	Mon, 14 Oct 2002 12:44:34 -0400
Date: Mon, 14 Oct 2002 09:50:44 -0700
From: Greg KH <greg@kroah.com>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Sleeping in illegal context
Message-ID: <20021014165043.GB6955@kroah.com>
References: <20021013174316.732c4298.us15@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021013174316.732c4298.us15@os.inf.tu-dresden.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 05:43:16PM +0200, Udo A. Steinberg wrote:
> 
> Hello,
> 
> This turned up in 2.5.42-ac1.
> 
> Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
> Call Trace:
>  [<c02ad282>] usb_hub_events+0x72/0x3b0

Should be fixed in the latest round of patches I sent to Linus.

thanks,

greg k-h
