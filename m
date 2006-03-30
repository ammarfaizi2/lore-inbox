Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWC3QFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWC3QFX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWC3QFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:05:23 -0500
Received: from unthought.net ([212.97.129.88]:36873 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1750769AbWC3QFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:05:22 -0500
Date: Thu, 30 Mar 2006 18:05:21 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: NFS/Kernel Problem: getfh failed: Operation not permitted
Message-ID: <20060330160521.GC9811@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	Justin Piszcz <jpiszcz@lucidpixels.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
References: <Pine.LNX.4.64.0603300813270.18696@p34> <1143728720.8074.41.camel@lade.trondhjem.org> <Pine.LNX.4.64.0603300929340.18696@p34> <1143729766.8074.49.camel@lade.trondhjem.org> <Pine.LNX.4.64.0603300949000.18696@p34> <1143731364.8074.53.camel@lade.trondhjem.org> <Pine.LNX.4.64.0603301011160.18696@p34> <20060330153128.GB9811@unthought.net> <Pine.LNX.4.61.0603301053030.738@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603301053030.738@chaos.analogic.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 10:58:08AM -0500, linux-os (Dick Johnson) wrote:
...
> This is my /etc/exports and it works fine with linux-2.6.15.4.
> All the host names are local, inside the firewall, and need to
> be looked-up over a W$<crap> name-server.
> 
> #
> /rmtboot/LinuxRoot	*(ro,async)
> /root/Scanner	*(ro,no_root_squash,sync)
> /tmp		*(rw,no_root_squash,sync)
> /usr/src	quark(rw,no_root_squash,sync)
> /usr/lib	quark(rw,no_root_squash,sync)
...

Well lucky you  :)

I'm not saying it can't work. I'm just saying I've spent too much time
finding out the hard way that it does not necessarily work  :)

-- 

 / jakob

