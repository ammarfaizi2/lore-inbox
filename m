Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbTA0Uik>; Mon, 27 Jan 2003 15:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbTA0Uik>; Mon, 27 Jan 2003 15:38:40 -0500
Received: from pc-80-192-208-23-mo.blueyonder.co.uk ([80.192.208.23]:58560
	"EHLO efix.biz") by vger.kernel.org with ESMTP id <S262807AbTA0Uij>;
	Mon, 27 Jan 2003 15:38:39 -0500
Subject: Re: 2.4.21-pre3 kernel crash
From: Edward Tandi <ed@efix.biz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Martin MOKREJ? <mmokrejs@natur.cuni.cz>,
       Ross Biro <rossb@google.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030127203628.GA20873@gtf.org>
References: <Pine.OSF.4.51.0301271632230.49659@tao.natur.cuni.cz>
	 <3E356403.9010805@google.com>
	 <Pine.OSF.4.51.0301271813230.57372@tao.natur.cuni.cz>
	 <20030127192327.GD889@suse.de> <1043699262.2696.7.camel@wires.home.biz>
	 <20030127203628.GA20873@gtf.org>
Content-Type: text/plain
Organization: 
Message-Id: <1043700477.2656.18.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 27 Jan 2003 20:47:57 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-27 at 20:36, Jeff Garzik wrote:
> On Mon, Jan 27, 2003 at 08:27:43PM +0000, Edward Tandi wrote:
> > The VIA audio issue is still there though ;-)
> 
> What issue?
> 
> Alan has patches that should address support for VT8233 in
> via82cxxx_audio driver, in this -ac kernel.
> 
> 	Jeff

>From the original e-mail (-pre3-ac3) slightly altered:

I am running Linux on an ASUS A7V8X, VIA KT400 chipset motherboard. The
processor is a 1.5GHz Athlon XP. I started experimenting with new-ish
kernels again because of the general lack of kernel support for this
chipset in stock kernels.

...

2) The OSS audio driver. It works and this is the main reason why I use
this version of the kernel. The issue I have with it, is that if I start
certain applications (gaim, macromedia flash player 6 for example), esd
gets itself into some kind of hung/blocked state. When this happens, I
need to kill esd and re-start it. Games and xmms work however. The
reason I ask about this is that the downloaded driver from the viaarena
works on a stock kernel without this glitch. Is this a known problem?

The chip is a VT8235 and I'm happy that it mostly works in pre3 too. The
alsa driver reportedly works OK.

While I'm here, any chance of getting the bcm4400 NIC driver into the
2.4 kernel?

Ed-T.


