Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVCZRUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVCZRUD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 12:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVCZRUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 12:20:03 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:50185
	"HELO linuxace.com") by vger.kernel.org with SMTP id S261189AbVCZRT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 12:19:59 -0500
Date: Sat, 26 Mar 2005 09:19:58 -0800
From: Phil Oester <kernel@linuxace.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>, Luca <kronos@kronoz.cjb.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Garbage on serial console after serial driver loads
Message-ID: <20050326171958.GA6121@linuxace.com>
References: <20050325202414.GA9929@dreamland.darkstar.lan> <20050325203853.C12715@flint.arm.linux.org.uk> <20050325210132.GA11201@dreamland.darkstar.lan> <Pine.LNX.4.61.0503261115480.28431@yvahk01.tjqt.qr> <20050326151005.D12809@flint.arm.linux.org.uk> <20050326155549.GA5881@linuxace.com> <20050326163729.A23306@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050326163729.A23306@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 04:37:29PM +0000, Russell King wrote:
> > But intererstingly, on identical boxes, the garbage only appears on
> > those hooked up to a PortMaster device - those using a Cyclades never
> > display this problem. (???)
> 
> Sorry, I don't understand your scenarios.  Can you explain the
> circumstances under which you see corruption?
> 
> From the kernel messages you've quoted above, I can only think that
> you're not using ttyS0 as the serial console - if you were, my
> understanding of this issue would indicate that you should get the
> garbage immediately after the line starting "Serial:"
> 
> Either my understanding of the cause of this problem is wrong, or
> I'm not understanding your setup.

I have a number of PowerEdge 2550 servers.  All are setup with serial
console on ttyS0 @ 9600.  One group uses a (old) Portmaster device for console
access, the other group uses a Cyclades device.  Only those servers
using the Portmaster device exhibit the garbage problem.  The Cyclades
group never displays garbage on boot.

Phil

