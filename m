Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264049AbUDFWaX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264050AbUDFWaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:30:23 -0400
Received: from karnickel.franken.de ([193.141.110.11]:27145 "EHLO
	karnickel.franken.de") by vger.kernel.org with ESMTP
	id S264049AbUDFWaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:30:16 -0400
Subject: Re: [linux-usb-devel] Re: Oops with bluetooth dongle
From: Erik Tews <erik@debian.franken.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Alex Riesen <fork0@users.sourceforge.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0404061654560.6345-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0404061654560.6345-100000@ida.rowland.org>
Content-Type: text/plain
Message-Id: <1081290256.3515.12.camel@tpl.lokalnetz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 07 Apr 2004 00:24:17 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, den 06.04.2004 schrieb Alan Stern um 22:59:
> Please, folks, don't just say it oopses.  Post a crash dump so I have
> some chance of figuring out what's going wrong!
> 
> So many people have reported problems with the USB bluetooth driver that I
> can't keep them straight.  Some of them crashed in usb_set_interface(),
> and the patch I sent out should have fixed that.  Others crashed in
> hcd_giveback_urb(), and others crashed elsewhere.  This will require more 
> than a single fix.

OK, my problem is that I cannot see anything because the kernel freezes
and I got X running, so no oops is visible.

I will apply your patch and see what happens. Perhaps I can get some
more info using kdb and a console.

