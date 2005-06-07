Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVFGCNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVFGCNk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 22:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVFGCNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 22:13:40 -0400
Received: from animx.eu.org ([216.98.75.249]:8889 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261476AbVFGCN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 22:13:28 -0400
Date: Mon, 6 Jun 2005 22:09:12 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: randy_dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux@dominikbrodowski.net
Subject: Re: [PATCH] pcmcia/ds: handle any error code
Message-ID: <20050607020912.GB25480@animx.eu.org>
Mail-Followup-To: randy_dunlap <rdunlap@xenotime.net>,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	linux@dominikbrodowski.net
References: <20050512015220.GA31634@animx.eu.org> <20050512230206.GA1380@animx.eu.org> <20050512222038.325081b2.rdunlap@xenotime.net> <20050513194549.GB3519@animx.eu.org> <20050514102213.3440c526.rdunlap@xenotime.net> <20050514172619.GA5835@animx.eu.org> <20050514103205.7718d5f6.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050514103205.7718d5f6.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

randy_dunlap wrote:
> On Sat, 14 May 2005 13:26:19 -0400 Wakko Warner wrote:
> | > I'm currently running a kernel built with -Os.  I can successfully
> | > load pcmcia_core.ko and pcmcia.ko.  I added debug printk's in
> | > drivers/pcmcia/ds.c and it allocates the dynamic major dev
> | > successfully:
> | 
> | I noticed this too.  I can't figure out why it wasn't working before.  I
> | don't believe the method of loading the kernel (hdd, usb, floppy) would
> | cause this.  Next week when I get a chance to work more on this project,
> | I'll wipe out my entire kernel tree (saving the .config) and try again (I
> | keep pristine sources in /usr/src/linux/dist/<kernel vers>)
> | 
> | > What gcc version are you using?  (gcc 4.0 has a few known issues.)
> | 
> | gcc (GCC) 3.4.4 20050314 (prerelease) (Debian 3.4.3-12)
> | 
> | I have gcc-3.3 also installed.  Should I use it instead?
> 
> I guess it's worth a try, although suspecting code generation is really
> low on my list.  (I used gcc 3.3.3.)

Sorry for taking so long.  I had time today to do something.  I did try this
version, I didn't have any problems.  I also didn't have any problems with
rc5.  I'll be trying rc6 when I get a chance.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
