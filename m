Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266968AbSL3WIq>; Mon, 30 Dec 2002 17:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbSL3WIq>; Mon, 30 Dec 2002 17:08:46 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:49167 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266968AbSL3WIp>;
	Mon, 30 Dec 2002 17:08:45 -0500
Date: Mon, 30 Dec 2002 14:12:13 -0800
From: Greg KH <greg@kroah.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Adam Belay <ambx1@neo.rr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pnp & pci structure cleanups
Message-ID: <20021230221212.GE32324@kroah.com>
References: <Pine.LNX.4.33.0212291228200.532-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0212291228200.532-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 12:33:03PM +0100, Jaroslav Kysela wrote:
> Hi,
> 
> 	this is my second pnp cleanup. It removes ISA PnP variables from 
> PCI structures, cleans isapnp.h header file and adds the compatibility 
> routines. Also, i82365 pcmcia driver is updated to latest PnP API 
> (in compatibility mode). This patch will cause that all unconverted 
> ISA PnP code will fail to compile, but it's better than silent failure 
> (like the current kernel tree does).

Yeah!  Thanks for taking these fields out of pci.h, I really appreciate
it.  I'll send this on to Linus in a bit.

thanks,

greg k-h
