Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262937AbUKRTqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbUKRTqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbUKRTox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:44:53 -0500
Received: from flex.com ([206.126.0.13]:22545 "EHLO flex.com")
	by vger.kernel.org with ESMTP id S262926AbUKRTn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:43:27 -0500
From: Marr <marr@flex.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Linux support for SiLabs CP2102 devices
Date: Thu, 18 Nov 2004 15:41:40 -0400
User-Agent: KMail/1.5.4
Cc: MCU.Tools@silabs.com
References: <20041118173908.GA10667@kroah.com>
In-Reply-To: <20041118173908.GA10667@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411181441.40458.marr@flex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 November 2004 12:39pm, Greg KH wrote:
> Hi all,
>
> I've been getting a lot of requests lately to see if Linux supports the
> USB to serial device from Silicon Laboratories called the CP2102 chip.
> It turns out that the company is claiming Linux support, yet they are
> only shipping a binary driver for Red Hat Linux 9.0.
>
> In talking with the company, they insist that they will not release the
> source code to this module, and they claim that they are not infringing
> on any rights by not doing so.

(... snip ...)

> So, they are in violation, so what.  Well, I can't do much about this
> (due to my employer's rules about suing companies).  But I can do my
> best to spread the word that the CP2102 device is not supported on
> Linux, and should be avoided at all costs by anyone considering such a
> device in a future design.  I encourage everyone else to help spread
> this information too.

(... snip ...)

> So, in conclusion, please stay away from Silicon Laboratories devices,
> if you want to run Linux, as they are obviously not supporting Linux in
> any way.

If anyone has the USB Vendor/Product IDs (VID/PID) for these errant devices, a 
negative report (maybe including a link back to Greg's post in the 
Linux-USB-Devel list archives [http://
marc.theaimsgroup.com/?l=linux-usb-devel&m=110079963113076&w=2]) should be 
submitted to the USB 'Working Devices' list for RS-232/USB adapters at:

   http://www.qbik.ch/usb/devices/showdevcat.php?id=12

(I just did a search at that location for 'CP2102' and 'Silicon' and 'SiLabs' 
and found no entries for any such devices. I don't see any USB VID/PID info 
about them or their devices in the 'usb.ids' file either.)

That might help keep future users away from the devices of a company with such 
a poorly-thought-out policy.

Thank you, Greg, for alerting us to this situation.

Bill Marr

