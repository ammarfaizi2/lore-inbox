Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbTA0UsG>; Mon, 27 Jan 2003 15:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbTA0UsF>; Mon, 27 Jan 2003 15:48:05 -0500
Received: from havoc.daloft.com ([64.213.145.173]:2507 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S262812AbTA0UsF>;
	Mon, 27 Jan 2003 15:48:05 -0500
Date: Mon, 27 Jan 2003 15:57:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Edward Tandi <ed@efix.biz>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: Re: 2.4.21-pre3 kernel crash
Message-ID: <20030127205719.GB20873@gtf.org>
References: <Pine.OSF.4.51.0301271632230.49659@tao.natur.cuni.cz> <3E356403.9010805@google.com> <Pine.OSF.4.51.0301271813230.57372@tao.natur.cuni.cz> <20030127192327.GD889@suse.de> <1043699262.2696.7.camel@wires.home.biz> <20030127203628.GA20873@gtf.org> <1043700477.2656.18.camel@wires.home.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043700477.2656.18.camel@wires.home.biz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 08:47:57PM +0000, Edward Tandi wrote:
> 2) The OSS audio driver. It works and this is the main reason why I use
> this version of the kernel. The issue I have with it, is that if I start
> certain applications (gaim, macromedia flash player 6 for example), esd
> gets itself into some kind of hung/blocked state. When this happens, I
> need to kill esd and re-start it. Games and xmms work however. The
> reason I ask about this is that the downloaded driver from the viaarena
> works on a stock kernel without this glitch. Is this a known problem?
> 
> The chip is a VT8235 and I'm happy that it mostly works in pre3 too. The
> alsa driver reportedly works OK.

hmmm, not a known problem to me.  Alan?



> While I'm here, any chance of getting the bcm4400 NIC driver into the
> 2.4 kernel?

Nope, no chance at all.  It's more of BroadCom's abstraction layer,
bug-filled crap.

The route here is to fix up "b44" in 2.5, and then put it into 2.4.

	Jeff



