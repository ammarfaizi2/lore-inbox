Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266435AbUGUORO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266435AbUGUORO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 10:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266441AbUGUORO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 10:17:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:38047 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266435AbUGUORN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 10:17:13 -0400
Date: Wed, 21 Jul 2004 10:15:24 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] delete devfs
Message-ID: <20040721141524.GA12564@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, seems kernel.org dropped my big patch, so the patch below can be
found at:
	www.kernel.org/pub/linux/kernel/people/gregkh/misc/2.6/devfs-delete-2.6.8-rc2.patch



----- Forwarded message from Greg KH <greg@kroah.com> -----

Date: Wed, 21 Jul 2004 02:49:37 -0400
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] delete devfs

Ok, to test out the new development model, here's a nice patch that
simply removes the devfs code.  No commercial distro supports this for
2.6, and both Gentoo and Debian have full udev support for 2.6, so it is
not needed there either.  Combine this with the fact that Richard has
sent me a number of good udev patches to fix up some "emulate devfs with
udev" minor issues, I think we can successfully do this now.

Andrew, please apply this to your tree and feel free to send it to Linus
when you think it should be there.

thanks,

greg k-h

<PATCH SNIPPED>

----- End forwarded message -----
