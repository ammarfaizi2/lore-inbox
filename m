Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265001AbUD3P5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265001AbUD3P5A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 11:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUD3P5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 11:57:00 -0400
Received: from mail.kroah.org ([65.200.24.183]:10130 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265001AbUD3P43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 11:56:29 -0400
Date: Fri, 30 Apr 2004 08:55:21 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@free.fr>
Cc: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, linux-usb-devel@lists.sourceforge.net,
       speedtouch@ml.free.fr
Subject: Re: [linux-usb-devel] 3 USB regressions (2.6.6-rc3-bk1) that should be fixed before 2.6.6
Message-ID: <20040430155521.GA4463@kroah.com>
References: <Pine.LNX.4.58.0404300113120.444@alpha.polcom.net> <200404300952.00454.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404300952.00454.baldrick@free.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 09:52:00AM +0200, Duncan Sands wrote:
> (1) get Greg's latest bitkeeper tree (bk://kernel.bkbits.net/gregkh/linux/usb-2.6)

Or if you don't like using bitkeeper, use the latest -mm release.  All
of the changes in my tree are in there.

Honestly, I don't see how some of these issues started showing up
between those two kernel releases.  You can see the only changes made in
the USB section broken out by patch at:
	kernel.org/pub/linux/kernel/people/gregkh/2.6/2.6.6-rc2/

If you want, try reversing those patches one by one against 2.6.6-rc3 to
see which one caused the problems.

thanks,

greg k-h
