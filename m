Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266761AbSKLT0Y>; Tue, 12 Nov 2002 14:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266776AbSKLT0Y>; Tue, 12 Nov 2002 14:26:24 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:8464 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266761AbSKLT0Y>;
	Tue, 12 Nov 2002 14:26:24 -0500
Date: Tue, 12 Nov 2002 11:28:02 -0800
From: Greg KH <greg@kroah.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Adam Belay <ambx1@neo.rr.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PnP MODULE_DEVICE_TABLE Update - 2.5.46 (3/6)
Message-ID: <20021112192802.GC31530@kroah.com>
References: <20021112011304.GE26926@kroah.com> <Pine.LNX.4.33.0211121345480.503-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0211121345480.503-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 01:46:43PM +0100, Jaroslav Kysela wrote:
> 
> All ALSA modules will use it after this patch is merged.

I had to not apply the include/linux/module.h changes as Rusty is in the
middle of hacking that code into a billion tiny pieces.  As it was only
a comment change, I don't think it was a big deal right now :)

And he is currently changing the MODULE_DEVICE_TABLE() logic to not
expose kernel structures to userspace, so you might want to watch that
to see if it will work for your type of devices too.

thanks,

greg k-h
