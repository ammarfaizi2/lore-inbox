Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264551AbUFEHzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbUFEHzL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 03:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUFEHzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 03:55:11 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:64181 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S264551AbUFEHzE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 03:55:04 -0400
From: Duncan Sands <baldrick@free.fr>
To: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
Subject: Re: [linux-usb-devel] Re: USBDEVFS_RESET deadlocks USB bus.
Date: Sat, 5 Jun 2004 09:55:01 +0200
User-Agent: KMail/1.5.4
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       "David A. Desrosiers" <desrod@gnu-designs.com>,
       linux-usb-devel@lists.sourceforge.net
References: <20040604193911.GA3261@babylon.d2dc.net> <200406042240.43490.baldrick@free.fr> <20040604213037.GA2881@babylon.d2dc.net>
In-Reply-To: <20040604213037.GA2881@babylon.d2dc.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406050955.01677.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 June 2004 23:30, Zephaniah E. Hull wrote:
> On Fri, Jun 04, 2004 at 10:40:43PM +0200, Duncan Sands wrote:
> > > c4bae310 Call Trace:
> > >  [<c0336735>] __down+0x85/0x120
> > >  [<c033692f>] __down_failed+0xb/0x14
> > >  [<c026af27>] .text.lock.hub+0x69/0x82
> > >  [<c0272b7f>] usbdev_ioctl+0x19f/0x710
> > >  [<c015a45d>] file_ioctl+0x5d/0x170
> > >  [<c015a686>] sys_ioctl+0x116/0x250
> > >  [<c0103f8f>] syscall_call+0x7/0xb
> >
> > Does this help?
>
> I'm afraid not.

Are you sure?  That seems impossible to me!  Can you
get a new call trace please.

Thanks,

Duncan.
