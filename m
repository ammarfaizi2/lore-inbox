Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267342AbSLRTWU>; Wed, 18 Dec 2002 14:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267343AbSLRTWU>; Wed, 18 Dec 2002 14:22:20 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:17425 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267342AbSLRTWT>;
	Wed, 18 Dec 2002 14:22:19 -0500
Date: Wed, 18 Dec 2002 11:27:40 -0800
From: Greg KH <greg@kroah.com>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ALSA update
Message-ID: <20021218192740.GC32190@kroah.com>
References: <20021218182135.GD31197@kroah.com> <Pine.LNX.4.33.0212182013070.550-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0212182013070.550-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 08:17:55PM +0100, Jaroslav Kysela wrote:
> 
> Not much. We have 9 #ifdef's and all trying to resolve the conflicts with 
> new function prototypes which is difficult to replace with defines or 
> inline functions. Perhaps, you'll have an idea to solve this problem.

Short of keeping a 2.4 version and a 2.5/2.6 version, no, I do not have
any ideas, sorry.  The USB core has changed a lot between those two
trees, as you know.

> For us, it's very important to have only one code base for all kernels, 
> but on the other hand, we're trying to leave the 2.2/2.4 kernel code 
> specific parts separate in our CVS repository if possible.

Then you might want to leave the OLD_USB stuff out of the 2.5 kernel :)

thanks,

greg k-h
