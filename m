Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263873AbTLASc3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 13:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTLASc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 13:32:29 -0500
Received: from mail.kroah.org ([65.200.24.183]:28119 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263873AbTLASc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 13:32:28 -0500
Date: Mon, 1 Dec 2003 10:28:42 -0800
From: Greg KH <greg@kroah.com>
To: Christian Axelsson <smiler@lanil.mine.nu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USB mass-storage hell
Message-ID: <20031201182842.GA23020@kroah.com>
References: <3FCB001C.7000705@lanil.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCB001C.7000705@lanil.mine.nu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 09:47:24AM +0100, Christian Axelsson wrote:
> I have this USB harddrive and a USB mp3-player, when I plug them in 
> would like them to be mounted at /mnt/hd and /mnt/mp3 by auto.
> Is this possible using 2.6 and some supermount-like daemon?

Look at devlabel.

> Also, the device I plugin first becomes /dev/sda1 and the second 
> /dev/sda2 (using devfs) so I cant rely upon device names here to do 
> anything. Is there any ID of the USB-device aviable somewhere that can 
> be of any use?

Look at udev.

Good luck,

greg k-h
