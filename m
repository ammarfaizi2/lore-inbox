Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTLGJQf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 04:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264378AbTLGJQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 04:16:33 -0500
Received: from mail.kroah.org ([65.200.24.183]:28597 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264363AbTLGJQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 04:16:32 -0500
Date: Sun, 7 Dec 2003 00:06:40 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Alexeev <al_pavel@rambler.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: (Bug report) USB Mass Storage in 2.6.0-test11 (cannot mount flash drive)
Message-ID: <20031207080640.GA29643@kroah.com>
References: <3FD2694D.5090706@rambler.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD2694D.5090706@rambler.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 12:42:05AM +0100, Pavel Alexeev wrote:
> Hi!
> Sorry, i am totally stumped as to whom to send the report :)

are you sure you don't see the device in /sys/block somewhere?
And that you've selected scsi disk support?

If so, enable CONFIG_USB_STORAGE_DEBUG and send the output of what the
kernel log says when you plug your device in to the linux-usb-devel
mailing list.

Good luck,

greg k-h
