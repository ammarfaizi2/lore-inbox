Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266848AbUGVJ4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266848AbUGVJ4L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 05:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266849AbUGVJ4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 05:56:11 -0400
Received: from mail1.kontent.de ([81.88.34.36]:15853 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266848AbUGVJ4I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 05:56:08 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] delete devfs
Date: Thu, 22 Jul 2004 11:55:12 +0200
User-Agent: KMail/1.6.2
Cc: Jesse Stockall <stockall@magma.ca>, linux-kernel@vger.kernel.org,
       rgooch@safe-mbox.com, akpm@osdl.org
References: <20040721141524.GA12564@kroah.com> <200407220047.53153.oliver@neukum.org> <20040722064952.GC20561@kroah.com>
In-Reply-To: <20040722064952.GC20561@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407221155.13004.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 22. Juli 2004 08:49 schrieb Greg KH:
> > Interesting, but we are not talking about an _internal_ API here.
> > It's about blocking the upgrade path.
> 
> There is no such block.  udev has a full devfs compatibility mode, I made
> sure of that before every suggesting that a change like this happen.

A smooth upgrade is replacing the kernel image, rerun lilo and reboot.
There's very good reason to remove devfs from 2.7.0, but almost none
to remove it from 2.6.X (unless Richard turns up and rewrites it from scratch)
Breaking existing setup is acceptable only if you can do nothing else.

	Regards
		Oliver
