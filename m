Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbTIEQV3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 12:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbTIEQV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 12:21:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:51617 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262613AbTIEQTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 12:19:08 -0400
Date: Fri, 5 Sep 2003 09:08:16 -0700
From: Greg KH <greg@kroah.com>
To: Momes <momes@mundo-r.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB hang
Message-ID: <20030905160815.GA1946@kroah.com>
References: <200309041951.37523.momes@mundo-r.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309041951.37523.momes@mundo-r.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 07:51:37PM +0200, Momes wrote:
> Hello:
> I'm trying to compile new kernel 2.4.22 (with XFS patch) in my machine. The 
> problem is that it always hangs when I plug in my USB keyboard.
> My system needs "noapic" option in lilo.conf but it has always worked fined
> up to kernel 2.4.21. I've searched the archives and also used Google without
> found any answer, so decided to post my problem in the list with the hope
> that someone can give some clue.
> 
> The system always stops at this point:
> 
> "input: USB HID v1.00 Keyboard [BTC USB Keyboard] on usb2:3.0"

If you boot without any USB devices plugged in, and then plug them in
after boot, do you still have this problem?

And does this happen without the XFS patch?

thanks,

greg k-h
