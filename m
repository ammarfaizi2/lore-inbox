Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbUA3SSJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 13:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbUA3SSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 13:18:09 -0500
Received: from pop.gmx.net ([213.165.64.20]:61334 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263424AbUA3SRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 13:17:55 -0500
X-Authenticated: #4512188
Message-ID: <401A9FCB.4080804@gmx.de>
Date: Fri, 30 Jan 2004 19:17:47 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 015 release
References: <20040126215036.GA6906@kroah.com> <401A8A35.1020105@gmx.de> <20040130172310.GB5265@kroah.com> <401A97E0.4010704@gmx.de> <20040130174935.GC5265@kroah.com>
In-Reply-To: <20040130174935.GC5265@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
 > On Fri, Jan 30, 2004 at 06:44:00PM +0100, Prakash K. Cheemplavam wrote:
 >
 >>>What does:
 >>>	usbinfo -a -p /sys/class/usb/scanner0
 >>>say?
 >>
 >
 > Oops, sorry, that should have been 'udevinfo' not 'usbinfo'.
 >
 > Not awake yet...

Ok, but it doesn't help, as I guess the scanner0 entry will only appear 
if I use the scanner module, which I don't want to...so no scanner0 
entry in my case.

But I basicaly managed to get support vie libusb (doing a brute chmod 
666 on the proc device). Just need to set the rights correctly to the 
device via a script and let hotplug do the rest. Everything new to me, 
but makes sense somehow...

Prakash
