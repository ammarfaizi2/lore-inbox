Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSGILle>; Tue, 9 Jul 2002 07:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314829AbSGILld>; Tue, 9 Jul 2002 07:41:33 -0400
Received: from chaos.analogic.com ([204.178.40.224]:41348 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S314811AbSGILlc>; Tue, 9 Jul 2002 07:41:32 -0400
Date: Tue, 9 Jul 2002 07:45:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Thunder from the hill <thunder@ngforever.de>
cc: Oliver Neukum <oliver@neukum.name>, Keith Owens <kaos@ocs.com.au>,
       Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Driverfs updates
In-Reply-To: <Pine.LNX.4.44.0207090502510.10105-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.3.95.1020709073843.24291A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2002, Thunder from the hill wrote:

> Hi,
> 
> On Tue, 9 Jul 2002, Oliver Neukum wrote:
> > -It is slow.
> 
> I wouldn't call it any fast when I think about the idea that 31 of my CPUs 
> on Hawkeye shall be stopped because I unload a module. Sometimes at high 
> noon my server (Hawkeye) can hardly keep up all the traffic. Just imagine 
> a module would be unloaded then! That's the problem I'm having with it.
> 
> What should make a lock for parts of the kernel slower than a lock for 
> the _whole_ kernel?
> 
> 							Regards,
> 							Thunder

The module unload is to be used only during module development (so you
don't have to re-boot), as was the very first conjecture in this thread.

The current 'auto-unload' in some distributions like RedHat will go away.
The only way a module will be unloaded is if you, as root, unload it.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

