Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265545AbUF2LGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265545AbUF2LGA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 07:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265703AbUF2LGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 07:06:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54458 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265545AbUF2LF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 07:05:58 -0400
Date: Tue, 29 Jun 2004 07:05:23 -0400
From: Jeff Garzik <jgarzik@redhat.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: greg@kroah.com, arjanv@redhat.com, tburke@redhat.com,
       linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
       mdharm-usb@one-eyed-alien.net, david-b@pacbell.net, oliver@neukum.org
Subject: Re: drivers/block/ub.c
Message-ID: <20040629110523.GA3480@devserv.devel.redhat.com>
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040626130645.55be13ce@lembas.zaitcev.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 01:06:45PM -0700, Pete Zaitcev wrote:
> Hi, guys,
> 
> I have drafted up an implementation of a USB storage driver as I wish
> it done (called "ub"). The main goal of the project is to produce a driver
> which never oopses, and above all, never locks up the machine. To this
> point I did all my debugging while running X11 and yapping on IRC. If this
> goal requires to sacrifice performance, so be it. This is how ub differs
> from the usb-storage.
> 
> The current usb-storage works quite well on servers where netdump can
> be brought to bear, but on desktop its debuggability leaves some room
> for improvement. In all other respects, it is superior to ub. Since
> characteristics of usb-storage and ub are different I expect them to
> coexist potentially indefinitely (if ub finds any use at all).
> 
> Please refer to the attached patch. It is quite raw, for instance the
> disconnect is not processed at all, although I do have a plan for it.
> This posting is largely a "release early release often" excercise, as
> Papa ESR taught us. But you can see the design outline clearly now,
> I hope, and I'm interested in feedback on that.


I can't comment on the USB portions, but the rest seems sane to me.

	Jeff



