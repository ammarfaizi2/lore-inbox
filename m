Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289790AbSBEUs3>; Tue, 5 Feb 2002 15:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289789AbSBEUsT>; Tue, 5 Feb 2002 15:48:19 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:57092 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289790AbSBEUsE>; Tue, 5 Feb 2002 15:48:04 -0500
Date: Tue, 5 Feb 2002 20:47:51 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
Message-ID: <20020205204751.G27706@flint.arm.linux.org.uk>
In-Reply-To: <20020205173912.GA165@elf.ucw.cz> <Pine.LNX.4.33.0202050959020.25114-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0202050959020.25114-100000@segfault.osdlab.org>; from mochel@osdl.org on Tue, Feb 05, 2002 at 10:43:14AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2002 at 10:43:14AM -0800, Patrick Mochel wrote:
> I think that ide should get its own bus, as a child of the ide controller. 
> I haven't looked at ide yet at all. But, on most modern systems, the ide 
> controller is a function of the southbridge, so ide devices should go 
> under that. Like what the usb stuff does now...

What about, say, a Promise PCI IDE card?  You really need to reference
the parent PCI device when the is one.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

