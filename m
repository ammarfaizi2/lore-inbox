Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUGVQNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUGVQNm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 12:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266704AbUGVQNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 12:13:42 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:7649 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S266703AbUGVQNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 12:13:39 -0400
Date: Thu, 22 Jul 2004 09:13:35 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Oliver Neukum <oliver@neukum.org>, Jesse Stockall <stockall@magma.ca>,
       linux-kernel@vger.kernel.org, rgooch@safe-mbox.com, akpm@osdl.org
Subject: Re: [PATCH] delete devfs
Message-ID: <20040722091335.A17187@home.com>
References: <20040721141524.GA12564@kroah.com> <1090446817.8033.18.camel@homer.blizzard.org> <20040721220529.GB18721@kroah.com> <200407220047.53153.oliver@neukum.org> <20040722064952.GC20561@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040722064952.GC20561@kroah.com>; from greg@kroah.com on Thu, Jul 22, 2004 at 02:49:53AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 02:49:53AM -0400, Greg KH wrote:
> Also, everyone please, consider these points about the current devfs
> code:
> 	- it is unmaintained, and has been for years.
> 	- it contains known bugs (race conditions), that are pretty much
> 	  unsolvable with the current architecture of the code, that
> 	  have been pointed out many times, for years.
> 	- there is almost no functionality that devfs provides that is
> 	  not provided with udev[1]
> 	- no distro supports devfs

Minor nit: this is not true, maybe if you are talking only about
desktop/server distros. MontaVista Linux 3.1 uses devfs by default.

However, with udev devfs compatibility it easy for that distro
to migrate users IMHO. So, let's apply this patch so mvista doesn't
ship another release with devfs. :)

-Matt
