Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbUCUDyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 22:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263599AbUCUDyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 22:54:09 -0500
Received: from fmr06.intel.com ([134.134.136.7]:15069 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263597AbUCUDyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 22:54:06 -0500
Subject: Re: Linux 2.4.25: USB problems ("device not accepting new address")
From: Len Brown <len.brown@intel.com>
To: Greg KH <greg@kroah.com>
Cc: Johannes Resch <jr@xor.at>, linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F5EC0@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F5EC0@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1079841238.7277.880.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 Mar 2004 22:53:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-20 at 14:53, Greg KH wrote:
> On Sat, Mar 20, 2004 at 12:05:33PM +0100, Johannes Resch wrote:
> > Hello,
> > 
> > I've got the problem that the USB mouse device will cease responding
> after
> > some time. "dmesg" then shows:
> > 
> > usb-uhci.c: interrupt, status 2, frame# 699
> > usb.c: USB device not accepting new address=2 (error=-110)
> > hub.c: new USB device 00:1d.1-2, assigned address 3
> > usb.c: USB device not accepting new address=3 (error=-110)
> 
> This is a PCI interrupt routing issue, not a USB issue.  I suggest
> disabing acpi if you do not need it.  If you require acpi, then please
> take this to the acpi mailing list, the people there will work with
> you
> to solve it.

I didn't notice any configuration-time ACPI issues that would cause
USB to start failing after a few hours of use.

If the system runs properly with acpi=off or pci=noacpi,
but fails without it, please set me know
cc: acpi-devel@lists.sourceforge.net

thanks,
-Len



