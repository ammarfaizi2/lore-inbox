Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbUDZEPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUDZEPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 00:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264422AbUDZEPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 00:15:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4319 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261597AbUDZEPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 00:15:16 -0400
Date: Mon, 26 Apr 2004 05:15:15 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Dru <andru@treshna.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel lockup on alpha with heavy IO
Message-ID: <20040426041515.GO17014@parcelfarce.linux.theplanet.co.uk>
References: <408C75E4.50908@treshna.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408C75E4.50908@treshna.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 02:37:24PM +1200, Dru wrote:
> I've recently installed debian on a alpha box and have a problem with  
> the kernel locking up
> after a couple of hours of heavy use.  An individual partition will stop 
> responding, all processes
> that try and access it will just sit there waiting and you have to 
> reboot the server.
> I've been using a mixture of IDE drives and they all do this. I thought 
> it might be the motherboard
> so i've installed a pci ide controller card, had same effect. I've tried 
> accessing files over usb devices
> as a finial ditch effort but it also does it there also so i am sure it 
> is in the kernel and not
> the hardware that is at fault.

... or you have problems with heat dissipation.  Get into SRM right after
the deadlock and say show power - that should, IIRC, give you temperatures.
