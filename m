Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131126AbRAIXmi>; Tue, 9 Jan 2001 18:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131809AbRAIXmW>; Tue, 9 Jan 2001 18:42:22 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:20240 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S131509AbRAIXmG>; Tue, 9 Jan 2001 18:42:06 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDEE9@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Adam Huffman'" <bloch@verdurin.com>, linux-kernel@vger.kernel.org
Subject: RE: USB problems with 2.4.0
Date: Tue, 9 Jan 2001 15:41:46 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What kind of USB host controller is it?
Maybe there are some issues with it.

Maybe 'lspci -vv'...

~Randy
_______________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
-----------------------------------------------

> From: Adam Huffman [mailto:bloch@verdurin.com]
> 
> System is a KA7-100, sole USB peripheral is a Logitech MouseMan Wheel.
> 
> If I use the uhci driver, it doesn't initialise properly (there is a
> message along the lines of "something bad happened".  If I use the
> usb-uhci driver, I frequently get an oops if I move the mouse during
> bootup.
> 
> If anyone is interested I will try to obtain a decoded oops report.
> 
> I've had this problem for a while and have reported it here before, as
> well as to one of the USB maintainers, but with no result so far.
> 
> 
> Adam
> -

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
