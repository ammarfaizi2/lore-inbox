Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbULJEtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbULJEtk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 23:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbULJEtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 23:49:40 -0500
Received: from gate.crashing.org ([63.228.1.57]:38302 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261706AbULJEtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 23:49:36 -0500
Subject: Re: [BK PATCH] USB fixes for 2.6.10-rc3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041210001932.GA10889@kroah.com>
References: <20041209230900.GA6091@kroah.com>
	 <Pine.LNX.4.58.0412091538510.31040@ppc970.osdl.org>
	 <20041209235709.GA8147@kroah.com>
	 <Pine.LNX.4.58.0412091606130.31040@ppc970.osdl.org>
	 <20041210001932.GA10889@kroah.com>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 15:48:43 +1100
Message-Id: <1102654123.22745.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hm, I'll look into doing that after 2.6.10, as it does make more sense
> in the long run.

I agree. I remember playing with a USB driver in linux a while ago and
spending some time trying to figure out what was going on with byte
order :) I'd rather keep the raw HW (that is: well defined) byte order
in those fields, and let sparse catch drivers who don't properly convert
before use.

Ben.


