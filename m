Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbUBHQml (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 11:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbUBHQkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 11:40:41 -0500
Received: from mail.kroah.org ([65.200.24.183]:48577 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263850AbUBHQkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 11:40:33 -0500
Date: Sun, 8 Feb 2004 08:40:18 -0800
From: Greg KH <greg@kroah.com>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb-storage in 2.6.2
Message-ID: <20040208164018.GC2531@kroah.com>
References: <20040208092859.A30004@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040208092859.A30004@animx.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 08, 2004 at 09:28:59AM -0500, Wakko Warner wrote:
> I've noticed that if I remove usb-storage and reinsert it, insmod will go
> into D state and usb-storage will not work.  At this point, I can't shut
> down the system normally since the shutdown will hang.
> 
> Is this a known problem?  The system is a supermicro X5DA8 board (E7505
> Chipset).  I've had this problem with all 2.6 kernels.

No, it isn't a known problem.  Did you umount the device before removing
it?  Or at least after you did remove it?

Please post this kind of info to the linux-usb-devel mailing list, the
usb-storage developers would be interested in this.

thanks,

greg k-h
