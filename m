Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTELSDI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbTELSCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:02:34 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:35977 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262437AbTELR4T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:56:19 -0400
Date: Mon, 12 May 2003 11:06:03 -0700
From: Greg KH <greg@kroah.com>
To: Boris Kurktchiev <techstuff@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Posible memory leak!?
Message-ID: <20030512180603.GA28726@kroah.com>
References: <3EBC9C62.5010507@nortelnetworks.com> <3EBF144E.7050608@nortelnetworks.com> <m3y91cj0vm.fsf@varsoon.wireboard.com> <200305112342.27469.techstuff@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305112342.27469.techstuff@gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 11:42:27PM -0400, Boris Kurktchiev wrote:
> Now when I did the upgrade to 2.4.20 I did not change my config file at all
> the only new thing that I added was adding usb-to-usb networking ( i have a
> zaurus)

What driver are you using for this?  usbdnet?  I'd recommend using the
in-kernel support for this device instead.  I think the latest versions
of usbnet support it.

thanks,

greg k-h
