Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270103AbTGMEO3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 00:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270098AbTGMENO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 00:13:14 -0400
Received: from mail.kroah.org ([65.200.24.183]:18390 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270094AbTGMENI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 00:13:08 -0400
Date: Sat, 12 Jul 2003 21:14:19 -0700
From: Greg KH <greg@kroah.com>
To: Fridtjof Busse <fridtjof.busse@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.22-pre5] usb-storage error
Message-ID: <20030713041419.GB2695@kroah.com>
References: <200307121956.12642@fbunet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307121956.12642@fbunet.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 07:56:12PM +0200, Fridtjof Busse wrote:
> Hi
> I'm trying to backup files from an ext3-partition via dump. The 
> backup-drive is an USB 2.0 disk.
> After a few minutes I get an error (with -pre3 to -pre5):
> 
> kernel: usb_control/bulk_msg: timeout
> kernel: usb_control/bulk_msg: timeout
> kernel: usb_control/bulk_msg: timeout
> kernel: usb.c: USB disconnect on device 00:02.2-1 address 2

Hm, your device disconnected itself, not much the kernel can do about
that :)

How does 2.5 work for you?  It has much better usb-storage support.

thanks,

greg k-h
