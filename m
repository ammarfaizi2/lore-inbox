Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUDFVAe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 17:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264016AbUDFVAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 17:00:18 -0400
Received: from ida.rowland.org ([192.131.102.52]:27396 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264025AbUDFU7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:59:33 -0400
Date: Tue, 6 Apr 2004 16:59:32 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Erik Tews <erik@debian.franken.de>
cc: Alex Riesen <fork0@users.sourceforge.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: Oops with bluetooth dongle
In-Reply-To: <20040406192708.GA5327@debian.franken.de>
Message-ID: <Pine.LNX.4.44L0.0404061654560.6345-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2004, Erik Tews wrote:

> On Tue, Apr 06, 2004 at 08:47:36PM +0200, Alex Riesen wrote:
> > 
> > no change for me. Still oopses.
> 
> I have been running 2.6.5 with the bk-usb patch broken out of mm1. I
> still got the problem.
> 
> If I rmmod uhci-hcd, the kernel oopses too.
> 
> Still any ideas?

Please, folks, don't just say it oopses.  Post a crash dump so I have
some chance of figuring out what's going wrong!

So many people have reported problems with the USB bluetooth driver that I
can't keep them straight.  Some of them crashed in usb_set_interface(),
and the patch I sent out should have fixed that.  Others crashed in
hcd_giveback_urb(), and others crashed elsewhere.  This will require more 
than a single fix.

Alan Stern

