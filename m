Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287373AbSAGX0O>; Mon, 7 Jan 2002 18:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287375AbSAGX0E>; Mon, 7 Jan 2002 18:26:04 -0500
Received: from [194.162.148.63] ([194.162.148.63]:22766 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S287373AbSAGXZv>; Mon, 7 Jan 2002 18:25:51 -0500
Date: Tue, 8 Jan 2002 00:25:03 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Dave Jones <davej@suse.de>
cc: Paul Jakma <paulj@alphyra.ie>, <knobi@knobisoft.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <Pine.LNX.4.33.0201051807160.27113-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0201061705010.1407-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002, Dave Jones wrote:

> devicefs is just a means of exporting this to userspace, be that for
> usage with the userspace acpi tools, or for hinv like programs.
> As I mentioned earlier, ACPI enumerates pretty much everything in the
> system, even if theres no driver for it.
> If there is a driver for it, it can register things like "I support
> these power saving states" with driverfs for additional functionality.
> 
> It would be nice at some point to get some of the other (pre-ACPI)
> busses registering stuff there too, for completeness.

I had a patch which showed ISAPnP devices within driverfs at one point. 
Once the switch to struct device is in the kernel, I'll dig it out and 
bring it up to date.

--Kai



