Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTLBJuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 04:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbTLBJuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 04:50:15 -0500
Received: from main.gmane.org ([80.91.224.249]:25580 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261754AbTLBJuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 04:50:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: USB timeout with printer
Date: Tue, 2 Dec 2003 12:50:04 +0300
Message-ID: <20031202125004.15d4dce5.vsu@altlinux.ru>
References: <20031201195032.GC3385@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Newsreader: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-alt-linux-gnu)
Cc: linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Dec 2003 11:50:32 -0800 Aaron Lehmann wrote:

> I have a HP LaserJet 1300 that I'm using over USB.
> 
> (drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 8 if 0 alt 1 proto 2 vid 0x03F0 pid 0x1017)
> 
> What's getting to be very annoying is that usually within a day after
> printing something, I get the message usb 1-2: control timeout on
> ep0in, and the printer needs to be power cycled. I get other weird
> errors sometimes, like "drivers/usb/class/usblp.c: usblp0: error -110
> reading printer status". I don't have any evidence that this is
> Linux's fault, but it seems like a fairly likely possibility, at least
> if you consider it an incompatibility with the printer rather than a bug.
> My mouse uses USB and it works fine. I'm using an expensive Belkin
> USB cable. The kernel version is 2.6.0-test9-bk17. Here is some
> information on my USB controller:
> 
> 00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 [UHCI])
>         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
>         Flags: bus master, medium devsel, latency 32, IRQ 10
>         I/O ports at c800 [size=32]
>         Capabilities: <available only to root>
> 
> I think this may have started a few -test revisions ago, but I'm not
> sure. I only purchased the printer fairly recently so it's not like I
> can say that it's worked for years.

I have experienced similar issues with LaserJet 1300:

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=106208938406301&w=2
http://marc.theaimsgroup.com/?w=2&r=1&s=laserjet+1300+lockup&q=t

