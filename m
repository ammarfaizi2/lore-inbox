Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVFKM5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVFKM5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 08:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVFKM5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 08:57:24 -0400
Received: from animx.eu.org ([216.98.75.249]:42176 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261674AbVFKM5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 08:57:20 -0400
Date: Sat, 11 Jun 2005 08:52:40 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: kaweth fails to work on 2.6.12-rc[56]
Message-ID: <20050611125239.GA6252@animx.eu.org>
Mail-Followup-To: Oliver Neukum <oliver@neukum.org>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050608021140.GA28524@animx.eu.org> <200506081308.39450.oliver@neukum.org> <20050611041136.GA5617@animx.eu.org> <200506111313.14756.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506111313.14756.oliver@neukum.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Am Samstag, 11. Juni 2005 06:11 schrieb Wakko Warner:
> > Oliver Neukum wrote:
> > > Sorry, I should be more specific. It will print out the error codes
> > > internal to the USB layer which are meaningful even if interrupts are shared.
> > > Also, are you seeing tx errors in the error count?
> > 
> > Unless I did something wrong, it's apparently not in the USB subsystem.
> > 
> > I have 2.6.12-rc3 and rc4 compiled.  Same config file on a test system.
> > again, rc3 works, rc4 does not.  I booted rc3 and force loaded the usb
> > modules from rc4 into rc3.  It tainted the kernel, but it worked.
> > 
> > I booted into rc4.  I do have ACPI compiled so I added acpi=off.  This did
> > not work, same problem as before.  I left a ping running, the usb controller
> > was on IRQ 9.  The test system is an old NEC notebook with an Intel chipset
> > (thus uhci-hcd usb1.1).  I plugged in a Belkin USB2.0 cardbus card (USB1.1
> > is serviced by ohci-hcd) and plugged the ethernet adapter into that.  Same
> > problem.
> 
> Do you see tx errors?

No.  Oh oops I forgot to say the ping caused the interrupts to increase.
ifconfig showed 1 packet sent but never went up.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
