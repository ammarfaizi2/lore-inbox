Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267155AbTAPS1k>; Thu, 16 Jan 2003 13:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267156AbTAPS1k>; Thu, 16 Jan 2003 13:27:40 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:21007 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267155AbTAPS1f>;
	Thu, 16 Jan 2003 13:27:35 -0500
Date: Thu, 16 Jan 2003 10:35:53 -0800
From: Greg KH <greg@kroah.com>
To: Torben Mathiasen <torben.mathiasen@hp.com>
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       john.cagle@hp.com, dan.zink@hp.com
Subject: Re: [PATCH-2.4.20] PCI-X hotplug support for Compaq driver
Message-ID: <20030116183553.GB32126@kroah.com>
References: <20030115095513.GA2761@tmathiasen> <20030115230554.GC25816@kroah.com> <20030116114717.GC1222@tmathiasen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030116114717.GC1222@tmathiasen>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 12:47:17PM +0100, Torben Mathiasen wrote:
> Sure. I started out doing the patch for 2.5, but hit some hotplug bugs so I
> decided to get it working for 2.4 first and then port it to 2.5. I'll get on
> that.

Thanks.

> I wanted the user to be able to know exactly which bus speed/mode the driver
> switched to in case of a freq/mode change. Besides that it also put the info in
> proc as you mention.

But that is what the cur_bus_speed and max_bus_speed files in pcihpfs
for the slot are for, right?  Isn't this just duplicating that
information?

> Sure, we used to ship a system that only supported 50MHz PCI-X, but I'll have
> to get more details on that.

So 50MHz PCI-X is not in the spec, right?  If you all supported it, why
didn't you get it included in the spec?  :)

thanks,

greg k-h
