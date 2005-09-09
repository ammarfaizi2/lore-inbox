Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbVIIDbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbVIIDbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 23:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbVIIDbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 23:31:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:31616 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751403AbVIIDbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 23:31:08 -0400
Date: Thu, 8 Sep 2005 20:30:36 -0700
From: Greg KH <gregkh@suse.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru
Subject: Re: [GIT PATCH] W1 patches for 2.6.13
Message-ID: <20050909033036.GB11369@suse.de>
References: <20050908222105.GA6633@kroah.com> <1126222209.5286.74.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126222209.5286.74.camel@blade>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 01:30:09AM +0200, Marcel Holtmann wrote:
> Hi Greg,
> 
> > Here are some w1 patches that have been in the -mm tree for a while.
> > They add a new driver, and fix up the netlink logic a lot.  They also
> > add a crc16 implementation that is needed.
> 
> adding the CRC-16 is very cool. I was just about to submit one by my
> own, because it is also needed for the Bluetooth L2CAP retransmission
> and flow control support.
> 
> What about the 1-Wire notes inside the CRC-16 code. This suppose to be
> generic code and so this doesn't belong there.

Yes, those comments don't belong there.  Evgeniy, want to fix this?

thanks,

greg k-h
