Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTESDao (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 23:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTESDao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 23:30:44 -0400
Received: from dp.samba.org ([66.70.73.150]:15770 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262321AbTESDan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 23:30:43 -0400
Date: Mon, 19 May 2003 13:40:31 +1000
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Naming devices
Message-ID: <20030519034031.GI8994@krispykreme>
References: <20030518213358.GE8994@krispykreme> <20030518233634.C4224@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030518233634.C4224@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Isn't this what dev->bus_id in the device structure is supposed to be?
> (which is supposed to be a unique bus ID on a particular bus type, in
> the pci case, a PCI device.)

We could use that, although for ppc64 Id like to increase its size and
stash the physical location in there as well.

> Now that the point has been raised, it seems pretty obvious that
> initialisation failures should report the BUS ID of the failing card,
> not the logical name assigned by the system to that device which could
> change.  Once the card is up and running, using the logical name becomes
> meaningful - it's the identifier which user space uses to reference the
> device.

Sounds good to me.

Anton
