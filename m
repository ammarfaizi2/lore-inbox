Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264307AbUFGHFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbUFGHFp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 03:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbUFGHFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 03:05:45 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:60335 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S264307AbUFGHFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 03:05:44 -0400
From: Duncan Sands <baldrick@free.fr>
To: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
Subject: Re: [linux-usb-devel] Re: USBDEVFS_RESET deadlocks USB bus.
Date: Mon, 7 Jun 2004 09:05:41 +0200
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       "David A. Desrosiers" <desrod@gnu-designs.com>,
       linux-usb-devel@lists.sourceforge.net
References: <20040604193911.GA3261@babylon.d2dc.net> <200406050955.01677.baldrick@free.fr> <20040606063559.GA3018@babylon.d2dc.net>
In-Reply-To: <20040606063559.GA3018@babylon.d2dc.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200406070905.41145.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Are you sure?  That seems impossible to me!  Can you
> > get a new call trace please.
> 
> Hrm, I could have sworn that the kernel I tested with was rebuilt with
> the patch, but now that I am trying it on rc2-mm1 with the patch, it
> does in fact seem to be working, mostly.
> 
> Thanks a lot, and sorry for the previous report.
> 
> I seem to be seeing a locking related race condition on bulk reads and
> writes as well, should I start a new thread for those?

I don't think it matters much whether you start a new thread or not.  What
problem are you seeing?

Ciao,

Duncan.
